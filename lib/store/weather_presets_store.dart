import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
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
  ObservableList<String> presetsCityNames =
      ObservableList.of(['Москва', 'Волгоград', 'Кишинёв']);

  @observable
  ObservableList<Map<String, dynamic>> presetCityWeatherData =
      ObservableList.of([
    {
      'name': '',
      'main': {'temp': ''}
    },
  ]);

// =============================================================================

  @computed
  int get presetsCount => presetsCityNames.length;

// =============================================================================

  @action
  void dropPresetWeatherData() {
    presetCityWeatherData.clear();
  }

  @action
  void removePreset(int index) {
    talker.warning('Удаляю пресет $index');
    presetsCityNames.removeAt(index);
    presetCityWeatherData.removeAt(index);
  }

  @action
  Future<void> fetchCityWeatherData() async {
    dropPresetWeatherData();
    for (String city in presetsCityNames) {
      Map<String, dynamic> cityData = await fetchWeatherByCity(city);
      presetCityWeatherData.add(cityData);
      talker.warning(cityData);
      talker.critical(presetCityWeatherData);
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
    talker.info(result);
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
        print('Координаты для $cityName не найдены');
        throw Exception('Ошибка: слишком много локаций');
      }
    } catch (e) {
      print('Ошибка при получении координат: $e');
      throw Exception('Ошибка при парсинге города в координаты');
    }
  }
}
