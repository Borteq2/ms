import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/feature/library/config/empty_weather_preset.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:mordor_suit/store/_stores.dart';

part 'weather_presets_store.g.dart';

class WeatherPresetsStore = _WeatherPresetsStore with _$WeatherPresetsStore;

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
  CityNamesStore cityNamesStore = CityNamesStore(talker: GetIt.I<Talker>());

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
    await cityNamesStore.cityNamesBox.add(city);
    cityNamesStore.syncCityNamesWithBox();

    Map<String, dynamic> cityData = await fetchWeatherByCity(city);
    presetCityWeatherData.add(cityData);
    await dropWeatherPresetsCache(cacheManager);
    await setFileToCache(cacheManager, presetCityWeatherData);
  }

  @action
  Future<void> removePreset(int index) async {
    talker.warning('Удаляю пресет $index');
    await cityNamesStore.cityNamesBox.deleteAt(index);
    await appStore.fullRefreshAndGetFromCache();
  }

  @action
  Future<void> fetchCityWeatherData() async {
    talker.info('Данные из сети');
    // talker.debug('очищаю данные пресетов в приложении');
    // talker.debug('дропаю кэш пресетов');
    // talker.debug('рефрешу кэш таймштампа (чаще чем примерно раз в минуту всё равно не сработает)');

    dropPresetWeatherData();
    // appStore.dropTimestampCache(appStore.cacheManager);
    // appStore.refreshTimestampCache(
    //   appStore.cacheManager,
    //   appStore.currentTime,
    //   appStore.ttlInMinutes,
    // );
    await dropWeatherPresetsCache(cacheManager);
    await appStore.timestampStore.refreshTimestampCache(
      appStore.timestampStore.cacheManager,
      appStore.timestampStore.currentTimestamp,
      appStore.timestampStore.ttlInMinutes,
    );

    cityNamesStore.syncCityNamesWithBox();

    for (String city in cityNamesStore.presetsCityNames) {
      Map<String, dynamic> cityData = await fetchWeatherByCity(city);
      presetCityWeatherData.add(cityData);
    }
    // talker.debug('Пишу в кэш $presetCityWeatherData');
    await setFileToCache(cacheManager, presetCityWeatherData);
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
        // double latitude = locations[0].latitude;
        // double longitude = locations[0].longitude;
        // talker.info('Координаты для $cityName: ($latitude, $longitude)');
        return locations[0];
      } else {
        throw Exception(
            'Ошибка: слишком много локаций или Координаты для $cityName не найдены');
      }
    } catch (e, st) {
      talker.handle(e, st);
      // talker.info('Удаляю последний добавленный пресет');
      // removePreset(cityNamesStore.cityNamesBox.length - 1);
      throw Exception('Ошибка при парсинге города в координаты');
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

  Future<void> checkStoragePermissions() async {
    var status = await Permission.storage.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.storage.request();
    }
    if (status.isGranted) {
      talker.debug('Разрешение на чтение файлов предоставлено');
    } else {
      talker.debug('Разрешение на чтение файлов не предоставлено');
      throw const PermissionDeniedException(
          'Разрешение на чтение файлов не предоставлено');
    }
  }

  @action
  Future<void> getWeatherPresetsListFromCache() async {
    // checkStoragePermissions();

    ObservableList<Map<String, dynamic>> weatherPresetsList =
        await getFileFromCache(cacheManager);

    talker.info('Данные из кэша: $weatherPresetsList');
    cityNamesStore.syncCityNamesWithBox();
    presetCityWeatherData = weatherPresetsList;
  }

  Future<void> setFileToCache(
    DefaultCacheManager cacheManager,
    ObservableList<Map<String, dynamic>> weatherPresetsList,
  ) async {
    talker.debug('пишу в кэш новые пресеты');
    String jsonData = jsonEncode(weatherPresetsList);
    await cacheManager.putFile(
      'weatherPresetsList',
      Uint8List.fromList(utf8.encode(jsonData)),
    );
  }

  Future<ObservableList<Map<String, dynamic>>> getFileFromCache(
    DefaultCacheManager cacheManager,
  ) async {
    ObservableList<Map<String, dynamic>> dataList =
        ObservableList<Map<String, dynamic>>.of([]);
    FileInfo? weatherPresetsList =
        await cacheManager.getFileFromCache('weatherPresetsList');

    if (weatherPresetsList != null) {
      // talker.debug('Кэш с потрохами, ОК $weatherPresetsList');
      String jsonData = await weatherPresetsList.file.readAsString();

      List<dynamic> jsonList = jsonDecode(jsonData);
      dataList = ObservableList<Map<String, dynamic>>.of(
        jsonList.map<Map<String, dynamic>>(
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
