import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'weather_store.g.dart';

enum WeatherTypes {
  notSupported,
  cold,
  low,
  warm,
  heat,
}

class WeatherStore = _WeatherStore with _$WeatherStore;

abstract class _WeatherStore with Store {
  _WeatherStore({
    required this.talker,
  });

  final Talker talker;
  String weatherApiKey = dotenv.get('WEATHER_API_KEY');

  @observable
  bool geoPermission = false;

  @observable
  Map<String, dynamic> weatherDataMap = {
    'name': '',
    'main': {'temp': ''}
  };

// =============================================================================

  @computed
  String get city => weatherDataMap['name'];

  @computed
  String get mapTemp => weatherDataMap['main']['temp'].toString();

  @computed
  double get temp => mapTemp.isNotEmpty ? double.parse(mapTemp) : 999;

  @computed
  WeatherTypes get currentWeatherType {
    return temp >= -10 && temp < 0
        ? WeatherTypes.cold
        : temp >= 0 && temp < 10
            ? WeatherTypes.low
            : temp >= 10 && temp < 20
                ? WeatherTypes.warm
                : temp >= 25
                    ? WeatherTypes.heat
                    : WeatherTypes.notSupported;
  }

  @computed
  String get weatherName => switch (currentWeatherType) {
        WeatherTypes.notSupported => 'Не поддерживается',
        WeatherTypes.cold => 'Холодно',
        WeatherTypes.low => 'Прохладно',
        WeatherTypes.warm => 'Тепло',
        WeatherTypes.heat => 'Жарко',
      };

// =============================================================================

  @action
  Future<void> getLocationAndWeatherData() async {
    // talker.info(temp);
    try {
      Position position = await getLocation();
      geoPermission = true;
      weatherDataMap = await fetchWeatherByLocation(position);
    } catch (e) {
      geoPermission = false;
      talker.critical(e);
    }

  }

// =============================================================================

  Future<Position> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // locationMessage = 'Пожалуйста, включите службу геолокации';
      throw Exception('Геолокация не включена');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Разрешения нет сейчас');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Разрешения нет навсегда');
    }

    Position result = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return result;
  }

  Future<Map<String, dynamic>> fetchWeatherByLocation(Position position) async {
    Dio dio = GetIt.I<Dio>();

    Response response =
        await dio.get('https://api.openweathermap.org/data/2.5/weather'
            '?lat=${position.latitude}'
            '&lon=${position.longitude}'
            '&appid=$weatherApiKey'
            '&units=metric'
            '&lang=ru');
    Map<String, dynamic> result = response.data;
    talker.info(weatherDataMap);

    // locationMessage = 'Широта: ${position.latitude},\nДолгота: ${position.longitude}';

    return result;
  }
}
