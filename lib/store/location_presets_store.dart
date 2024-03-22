import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/models/_models.dart';
import 'package:mordor_suit/prebuilt/empty_weather_preset.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:mordor_suit/exceptions/_exceptions.dart';
import 'package:mordor_suit/store/_stores.dart';

part 'location_presets_store.g.dart';

class LocationPresetsStore = _LocationPresetsStore with _$LocationPresetsStore;

AppStore _appStoreLPS = GetIt.I<AppStore>();

abstract class _LocationPresetsStore with Store {
  _LocationPresetsStore({
    required this.talker,
  });

  final Talker talker;
  String weatherApiKey = dotenv.get('WEATHER_API_KEY');
  Dio dio = GetIt.I<Dio>();

  DefaultCacheManager cacheManager = DefaultCacheManager();

// =============================================================================

  @observable
  ObservableList<WeatherPreset> presetCityWeatherData = ObservableList();

// =============================================================================

  @computed
  int get presetCityWeatherDataCount => presetCityWeatherData.length;

  String? baseTemp(index) =>
      presetCityWeatherData[index].main?['temp'].toString();

  String? feelsLike(index) =>
      presetCityWeatherData[index].main?['feels_like'].toString();

  String? weather(index) => presetCityWeatherData[index].weather != null
      ? presetCityWeatherData[index].weather![0]['main'].toString()
      : null;

  String? description(index) =>
      presetCityWeatherData[index].weather?[0]['description'].toString();

  String? humidity(index) =>
      presetCityWeatherData[index].main?['humidity'].toString();

  String? wind(index) => presetCityWeatherData[index].wind?['speed'].toString();

// =============================================================================

  @action
  void dropPresetWeatherData() => presetCityWeatherData.clear();

  @action
  Future<void> addPreset(String city) async {
    await _appStoreLPS.cityNamesStore.cityNamesBox.add(city);
    _appStoreLPS.cityNamesStore.syncCityNamesWithBox();

    WeatherPreset cityData = await fetchWeatherByCity(city);
    presetCityWeatherData.add(cityData);
    await dropLocationPresetsCache(cacheManager);
    await setFileToCache(cacheManager, presetCityWeatherData);
  }

  @action
  Future<void> removePreset(int index) async {
    talker.info('Удаляю пресет $index');
    await _appStoreLPS.cityNamesStore.cityNamesBox.deleteAt(index);
    await _appStoreLPS.fullRefreshAndGetFromCache();
  }

  @action
  Future<void> fetchCityWeatherData() async {
    talker.info('Данные из сети');

    dropPresetWeatherData();
    await dropLocationPresetsCache(cacheManager);
    await _appStoreLPS.timestampStore.refreshTimestampCache(
      _appStoreLPS.timestampStore.cacheManager,
      DateTime.now(),
    );

    _appStoreLPS.cityNamesStore.syncCityNamesWithBox();

    for (String city in _appStoreLPS.cityNamesStore.presetsCityNames) {
      WeatherPreset cityData = await fetchWeatherByCity(city);
      presetCityWeatherData.add(cityData);
    }
    // talker.debug('Пишу в кэш $presetCityWeatherData');
    await setFileToCache(cacheManager, presetCityWeatherData);
    // print('#'*50);
  }

// =============================================================================

  Future<WeatherPreset> fetchWeatherByCity(String city) async {
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

      WeatherPreset result = WeatherPreset.fromJson(response.data);
      // talker.info('Запрос погоды в городе $city: $result');
      return result;
    } catch (e, st) {
      talker.handle(e, st);
      return emptyWeatherPreset;
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

  Future<void> dropLocationPresetsCache(
      DefaultCacheManager cacheManager) async {
    talker.info('дропаю кэш пресетов');
    try {
      await cacheManager.emptyCache();
    } catch (e, st) {
      talker.handle(e, st);
      throw SentryException(type: 'minor', value: '$e /// $st');
    }
  }

  @action
  Future<void> getLocationPresetsListFromCache() async {
    ObservableList<WeatherPreset> weatherPresetsList =
        await getFileFromCache(cacheManager);

    talker.info('Данные из кэша: $weatherPresetsList');
    _appStoreLPS.cityNamesStore.syncCityNamesWithBox();
    presetCityWeatherData = weatherPresetsList;
  }

  Future<void> setFileToCache(
    DefaultCacheManager cacheManager,
    ObservableList<WeatherPreset> weatherPresetsList,
  ) async {
    talker.debug('пишу в кэш новые пресеты');
    String jsonData = jsonEncode(weatherPresetsList);
    await cacheManager.putFile(
      'weatherPresetsList',
      Uint8List.fromList(utf8.encode(jsonData)),
    );
  }

  // TODO: переосмыслить всю функцию
  Future<ObservableList<WeatherPreset>> getFileFromCache(
    DefaultCacheManager cacheManager,
  ) async {
    ObservableList<WeatherPreset> dataList =
        ObservableList<WeatherPreset>.of([]);
    FileInfo? weatherPresetsList =
        await cacheManager.getFileFromCache('weatherPresetsList');

    if (weatherPresetsList != null) {
      // talker.debug('Кэш с потрохами, ОК $weatherPresetsList');
      String jsonData = await weatherPresetsList.file.readAsString();

      List<dynamic> jsonList = jsonDecode(jsonData);
      dataList = ObservableList<WeatherPreset>.of(
        jsonList.map<WeatherPreset>((item) => WeatherPreset.fromJson(item)),
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
