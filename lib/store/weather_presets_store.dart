import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'weather_presets_store.g.dart';

class WeatherPresetsStore = _WeatherPresetsStore with _$WeatherPresetsStore;

abstract class _WeatherPresetsStore with Store {
  _WeatherPresetsStore({
    required this.talker,
  });

  final Talker talker;
  String weatherApiKey = dotenv.get('WEATHER_API_KEY');
  Dio dio = GetIt.I<Dio>();

// =============================================================================

  @observable
  CityNamesStore cityNamesStore = CityNamesStore(talker: GetIt.I<Talker>());

  @observable
  ObservableList<Map<String, dynamic>> presetCityWeatherData = ObservableList();

// =============================================================================

  @computed
  int get presetCityWeatherDataCount => presetCityWeatherData.length;

  String baseTemp(index) => presetCityWeatherData[index]['main']['temp'].toString();

  String feelsLike(index) => presetCityWeatherData[index]['main']['feels_like'].toString();

  String weather(index) => presetCityWeatherData[index]['weather'][0]['main'].toString();

  String description(index) => presetCityWeatherData[index]['main']['temp'].toString();

  String humidity(index) => presetCityWeatherData[index]['main']['humidity'].toString();

  String wind(index) => presetCityWeatherData[index]['wind']['speed'].toString();

// =============================================================================

  @action
  void dropPresetWeatherData() => presetCityWeatherData.clear();

  @action
  Future<void> addPreset(String city) async {
    await cityNamesStore.cityNamesBox.add(city);
    cityNamesStore.syncCityNamesWithBox();

    Map<String, dynamic> cityData = await fetchWeatherByCity(city);
    presetCityWeatherData.add(cityData);
  }

  @action
  void removePreset(int index) {
    talker.warning('Удаляю пресет $index');
    cityNamesStore.cityNamesBox.deleteAt(index);
    cityNamesStore.syncCityNamesWithBox();

    presetCityWeatherData.removeAt(index);
  }

  @action
  Future<void> fetchCityWeatherData() async {
    dropPresetWeatherData();
    cityNamesStore.syncCityNamesWithBox();
    talker.critical(cityNamesStore.presetsCityNames);
    for (String city in cityNamesStore.presetsCityNames) {
      talker.critical(city);
      Map<String, dynamic> cityData = await fetchWeatherByCity(city);
      presetCityWeatherData.add(cityData);
      talker.critical(presetCityWeatherData.length);
    }
  }

// =============================================================================

  Future<Map<String, dynamic>> fetchWeatherByCity(String city) async {
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
    talker.info('Запрос погоды в городе $city: $result');
    return result;
  }

  Future<Location> getLocationCoordinatesByCityName(String cityName) async {
    try {
      List<Location> locations = await locationFromAddress(cityName);
      if (locations.isNotEmpty) {
        double latitude = locations[0].latitude;
        double longitude = locations[0].longitude;
        print('Координаты для $cityName: ($latitude, $longitude)');
        return locations[0];
      } else {
        talker.critical('Координаты для $cityName не найдены');
        throw Exception('Ошибка: слишком много локаций');
      }
    } catch (e, st) {
      talker.handle(e, st);
      throw Exception('Ошибка при парсинге города в координаты');
    }
  }
}
