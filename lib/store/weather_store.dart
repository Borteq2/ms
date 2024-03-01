import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
  late Position currentPosition;

  @observable
  String timestamp = '';

  @observable
  Icon weatherIcon = const Icon(Icons.question_mark, color: Colors.transparent);

  @observable
  Map<String, dynamic> weatherDataMap = {
    'name': '',
    'main': {'temp': ''}
  };

// =============================================================================

  @computed
  String get city => weatherDataMap['name'];

  @computed
  bool get isWeatherLoaded => city != '';
 
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
  Map<String, dynamic> get mapTemp => weatherDataMap['main'];

  @computed
  double get temperature => mapTemp.isNotEmpty ? mapTemp['temp'] : 999;

  @computed
  double get feelsLikeTemp =>  mapTemp.isNotEmpty ? mapTemp['feels_like'] : 999;

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
  void setTimestamp() {
    DateTime now = DateTime.now();

    int hours = now.hour;
    int minutes = now.minute;
    int seconds = now.second;

    timestamp = '$hours:$minutes:$seconds';
  }

  @action
  void dropCurrentWeatherData() {
    weatherDataMap = {
      'name': '',
      'main': {'temp': ''}
    };
  }

  @action
  Future<void> getLocationAndWeatherData() async {
    dropCurrentWeatherData();
    try {
      await getLocation();
      geoPermission = true;
      weatherDataMap = await fetchWeatherByLocation();
      setTimestamp();
      setIconByWeather();
    } catch (e) {
      geoPermission = false;
      talker.critical(e);
    }
  }

  @action
  void setIconByWeather() => weatherDataMap['weather'][0]['main'] == 'Clear'
      ? weatherIcon = const Icon(Icons.sunny)
      : weatherDataMap['weather'][0]['main'] == 'Clouds'
          ? weatherIcon = const Icon(Icons.cloud)
          : weatherDataMap['weather'][0]['main'] == 'Rain'
              ? weatherIcon = const Icon(Icons.water_drop)
              : weatherDataMap['weather'][0]['main'] == 'Snow'
                  ? weatherIcon = const Icon(Icons.cloudy_snowing)
                  : weatherDataMap['weather'][0]['main'] == 'Thunderstorm'
                      ? weatherIcon = const Icon(Icons.thunderstorm)
                      : weatherDataMap['weather'][0]['main'] == 'Mist'
                          ? weatherIcon = const Icon(Icons.waves)
                          : weatherDataMap['weather'][0]['main'] == 'Haze'
                              ? weatherIcon = const Icon(Icons.waves)
                              : weatherDataMap['weather'][0]['main'] == 'Sleet'
                                  ? weatherIcon = const Icon(Icons.snowing)
                                  : weatherDataMap['weather'][0]['main'] ==
                                          'Freezing rain'
                                      ? weatherIcon =
                                          const Icon(Icons.cloudy_snowing)
                                      : weatherIcon =
                                          const Icon(Icons.question_mark);

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

    currentPosition = result;

    return result;
  }

  Future<Map<String, dynamic>> fetchWeatherByLocation() async {
    Dio dio = GetIt.I<Dio>();

    Response response =
        await dio.get('https://api.openweathermap.org/data/2.5/weather'
            '?lat=${currentPosition.latitude}'
            '&lon=${currentPosition.longitude}'
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
