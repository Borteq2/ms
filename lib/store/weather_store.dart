import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'weather_store.g.dart';

enum TemperatureTypes {
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
  bool get isWeatherLoaded => weatherDataMap['name'] == '';

  @computed
  String get city => weatherDataMap['name'];

  @computed
  String get mapTemp => weatherDataMap['main']['temp'].toString();

  @computed
  String get weather {
    try {
      return weatherDataMap['weather'][0]['description']
              .toString()[0]
              .toUpperCase() +
          weatherDataMap['weather'][0]['description'].toString().substring(1);
    } catch (e) {
      talker.debug(e);
    }
    return '';
  }

  @computed
  double get temperature => mapTemp.isNotEmpty ? double.parse(mapTemp) : 999;

  @computed
  TemperatureTypes get currentTemperatureType {
    return temperature >= -15 && temperature < 0
        ? TemperatureTypes.cold
        : temperature >= 0 && temperature < 10
            ? TemperatureTypes.low
            : temperature >= 10 && temperature < 20
                ? TemperatureTypes.warm
                : temperature >= 25
                    ? TemperatureTypes.heat
                    : TemperatureTypes.notSupported;
  }

  @computed
  String get temperatureName => switch (currentTemperatureType) {
        TemperatureTypes.notSupported => 'Не поддерживается',
        TemperatureTypes.cold => 'Холодно',
        TemperatureTypes.low => 'Прохладно',
        TemperatureTypes.warm => 'Тепло',
        TemperatureTypes.heat => 'Жарко',
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
    // talker.info(weatherDataMap);
    talker.info(response.data);
    // locationMessage = 'Широта: ${position.latitude},\nДолгота: ${position.longitude}';

    return result;
  }
}
