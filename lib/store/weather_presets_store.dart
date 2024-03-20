import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:mordor_suit/exceptions/_exceptions.dart';
import 'package:mordor_suit/library/config/empty_weather_preset.dart';
import 'package:mordor_suit/store/_stores.dart';

part 'weather_presets_store.g.dart';

class WeatherPresetsStore = _WeatherPresetsStore with _$WeatherPresetsStore;

AppStore _appStoreWP = GetIt.I<AppStore>();

abstract class _WeatherPresetsStore with Store {
  _WeatherPresetsStore({
    required this.talker,
  });

  final Talker talker;
  String weatherApiKey = dotenv.get('WEATHER_API_KEY');
  Dio dio = GetIt.I<Dio>();

  DefaultCacheManager cacheManager = DefaultCacheManager();

// =============================================================================

  @observable
  ObservableList<Map<String, dynamic>> presetCityWeatherData = ObservableList();

// =============================================================================

  @computed
  int get presetCityWeatherDataCount => presetCityWeatherData.length;

  String baseTemp(index) =>
      presetCityWeatherData[index]['main']['temp'].toString();

  String feelsLike(index) =>
      presetCityWeatherData[index]['main']['feels_like'].toString();

  String weather(index) =>
      presetCityWeatherData[index]['weather'][0]['main'].toString();

  String description(index) =>
      presetCityWeatherData[index]['weather'][0]['description'].toString();

  String humidity(index) =>
      presetCityWeatherData[index]['main']['humidity'].toString();

  String wind(index) =>
      presetCityWeatherData[index]['wind']['speed'].toString();

// =============================================================================

  @action
  void dropPresetWeatherData() => presetCityWeatherData.clear();

  @action
  Future<void> addPreset(String city) async {
    await _appStoreWP.cityNamesStore.cityNamesBox.add(city);
    _appStoreWP.cityNamesStore.syncCityNamesWithBox();

    Map<String, dynamic> cityData = await fetchWeatherByCity(city);
    presetCityWeatherData.add(cityData);
    await dropWeatherPresetsCache(cacheManager);
    await setFileToCache(cacheManager, presetCityWeatherData);
  }

  @action
  Future<void> removePreset(int index) async {
    talker.info('Удаляю пресет $index');
    await _appStoreWP.cityNamesStore.cityNamesBox.deleteAt(index);
    await GetIt.I<AppStore>().fullRefreshAndGetFromCache();
  }

  @action
  Future<void> fetchCityWeatherData() async {
    talker.info('Данные из сети');

    dropPresetWeatherData();
    await dropWeatherPresetsCache(cacheManager);
    await GetIt.I<AppStore>().timestampStore.refreshTimestampCache(
          GetIt.I<AppStore>().timestampStore.cacheManager,
          GetIt.I<AppStore>().timestampStore.currentTimestamp,
        );

    _appStoreWP.cityNamesStore.syncCityNamesWithBox();

    for (String city in _appStoreWP.cityNamesStore.presetsCityNames) {
      Map<String, dynamic> cityData = await fetchWeatherByCity(city);
      presetCityWeatherData.add(cityData);
    }
    // talker.debug('Пишу в кэш $presetCityWeatherData');
    await setFileToCache(cacheManager, presetCityWeatherData);
    // print('#'*50);
  }

// =============================================================================

  Future<Map<String, dynamic>> fetchWeatherByCity(String city) async {
    try {
      Location location = await getLocationCoordinatesByCityName(city);

      Response response = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather'
        '?lat=${location.latitude}'
        '&lon=${location.longitude}'
        '&appid=$weatherApiKey'
        '&units=metric'
        '&lang=ru',
      );

      Map<String, dynamic> result = response.data;
      // talker.info('Запрос погоды в городе $city: $result');
      return result;
    } catch (e, st) {
      talker.handle(e, st);
      return emptyPreset;
    }
  }

  Future<Location> getLocationCoordinatesByCityName(String cityName) async {
    try {
      List<Location> locations = await locationFromAddress(cityName);
      if (locations.isNotEmpty) {
        return locations[0];
      } else {
        throw LocationException(
            'Ошибка: слишком много локаций или координаты для $cityName не найдены');
      }
    } catch (e, st) {
      talker.handle(e, st);
      throw LocationException('Ошибка при парсинге города в координаты');
    }
  }

// =============================================================================

  Future<void> dropWeatherPresetsCache(DefaultCacheManager cacheManager) async {
    talker.info('дропаю кэш пресетов');
    try {
      await cacheManager.emptyCache();
    } catch (e, st) {
      talker.handle(e, st);
      throw SentryException(type: 'minor', value: '$e /// $st');
    }
  }

  @action
  Future<void> getWeatherPresetsListFromCache() async {
    // TODO: рефактор в модель
    ObservableList<Map<String, dynamic>> weatherPresetsList =
        await getFileFromCache(cacheManager);

    talker.info('Данные из кэша: $weatherPresetsList');
    _appStoreWP.cityNamesStore.syncCityNamesWithBox();
    presetCityWeatherData = weatherPresetsList;
  }

  Future<void> setFileToCache(
    DefaultCacheManager cacheManager,
    // TODO: рефактор в модель
    ObservableList<Map<String, dynamic>> weatherPresetsList,
  ) async {
    talker.debug('пишу в кэш новые пресеты');
    String jsonData = jsonEncode(weatherPresetsList);
    await cacheManager.putFile(
      'weatherPresetsList',
      Uint8List.fromList(utf8.encode(jsonData)),
    );
  }

  // TODO: переосмыслить всю функцию
  Future<ObservableList<Map<String, dynamic>>> getFileFromCache(
    DefaultCacheManager cacheManager,
  ) async {
    // TODO: рефактор в модель
    ObservableList<Map<String, dynamic>> dataList =
        // TODO: рефактор в модель
        ObservableList<Map<String, dynamic>>.of([]);
    FileInfo? weatherPresetsList =
        await cacheManager.getFileFromCache('weatherPresetsList');

    if (weatherPresetsList != null) {
      // talker.debug('Кэш с потрохами, ОК $weatherPresetsList');
      String jsonData = await weatherPresetsList.file.readAsString();

      List<dynamic> jsonList = jsonDecode(jsonData);
      // TODO: рефактор в модель
      dataList = ObservableList<Map<String, dynamic>>.of(
        // TODO: рефактор в модель
        jsonList.map<Map<String, dynamic>>(
            // TODO: рефактор в модель
            (item) => Map<String, dynamic>.from(item)),
      );
      // talker.debug('Данные получились $dataList');
    } else {
      // talker.debug('Кэш нуловый, не ок $dataList');
      await fetchCityWeatherData();
      await setFileToCache(cacheManager, presetCityWeatherData);
      dataList = await getFileFromCache(cacheManager);
    }
    // talker.info('возвращаю данные $dataList');
    return dataList;
  }
}
