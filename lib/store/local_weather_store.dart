import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/feature/library/logic/capitalize_first_symbol.dart';
import 'package:mordor_suit/feature/library/logic/map_weather_to_icon.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'local_weather_store.g.dart';

enum TemperatureTypes {
  notSupported,
  frostPunk,
  cold,
  belowZero,
  aboveZero,
  low,
  warm,
  heat,
  melting
}

class LocalWeatherStore = _LocalWeatherStore with _$LocalWeatherStore;

abstract class _LocalWeatherStore with Store {
  _LocalWeatherStore({
    required this.talker,
  });

  final Talker talker;
  String weatherApiKey = dotenv.get('WEATHER_API_KEY');
  Dio dio = GetIt.I<Dio>();

  @observable
  bool geoPermission = false;

  @observable
  late Position currentPosition;

  @observable
  Icon weatherIcon = const Icon(Icons.question_mark, color: Colors.transparent);

  @observable
  Map<String, dynamic> localWeatherDataMap = {
    'name': '',
    'main': {'temp': ''}
  };

// =============================================================================

  @computed
  String get city => localWeatherDataMap['name'];

  @computed
  bool get isWeatherLoaded => city != '';

  @computed
  String get weather {
    try {
      return StringHelper.capitalizeFirstSymbol(
          localWeatherDataMap['weather'][0]['description']);
    } catch (e) {
      talker.critical(e);
    }
    return '';
  }

  @computed
  Map<String, dynamic> get mapTemp => localWeatherDataMap['main'];

  @computed
  num get temperature => mapTemp.isNotEmpty ? mapTemp['temp'] : 999;

  @computed
  num get feelsLikeTemp => mapTemp.isNotEmpty ? mapTemp['feels_like'] : 999;

  @computed
  TemperatureTypes get currentTemperatureType {
    return temperature >= -15 && temperature < -10
        ? TemperatureTypes.frostPunk
        : temperature >= -10 && temperature < -5
            ? TemperatureTypes.cold
            : temperature >= -5 && temperature < 0
                ? TemperatureTypes.belowZero
                : temperature >= 0 && temperature < 5
                    ? TemperatureTypes.aboveZero
                    : temperature >= 5 && temperature < 10
                        ? TemperatureTypes.low
                        : temperature >= 10 && temperature < 15
                            ? TemperatureTypes.warm
                            : temperature >= 15 && temperature < 20
                                ? TemperatureTypes.heat
                                : temperature > 20
                                    ? TemperatureTypes.melting
                                    : TemperatureTypes.notSupported;
  }

  @computed
  String get temperatureName => switch (currentTemperatureType) {
        TemperatureTypes.notSupported => 'Не поддерживается',
        TemperatureTypes.frostPunk => 'Дубак',
        TemperatureTypes.cold => 'Холодно',
        TemperatureTypes.belowZero => 'Чуть ниже нуля',
        TemperatureTypes.aboveZero => 'Чуть выше нуля',
        TemperatureTypes.low => 'Прохладно',
        TemperatureTypes.warm => 'Тепло',
        TemperatureTypes.heat => 'Жарко',
        TemperatureTypes.melting => 'Жарища',
      };

// =============================================================================

  @action
  void dropCurrentWeatherData() {
    localWeatherDataMap = {
      'name': '',
      'main': {'temp': ''}
    };
  }

  @action
  void setSuitByWeatherManually(Map<String, dynamic> weather) {
    dropCurrentWeatherData();
    localWeatherDataMap = weather;
  }

  @action
  Future<void> getLocationAndWeatherData() async {
    dropCurrentWeatherData();
    try {
      await getLocation();
      geoPermission = true;
      localWeatherDataMap = await fetchWeatherByLocation();
      // setTimestamp();
      weatherIcon = IconHelper.getIconByWeather(
          localWeatherDataMap['weather'][0]['main']);
    } catch (e) {
      geoPermission = false;
      talker.critical(e);
    }
  }

// =============================================================================

  Future<Position> getLocation() async {
    talker.debug('Запрашиваю локацию');
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
    // talker.info(currentPosition);

    return result;
  }

  Future<Map<String, dynamic>> fetchWeatherByLocation() async {
    Dio dio = GetIt.I<Dio>();

    Response response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather'
      '?lat=${currentPosition.latitude}'
      '&lon=${currentPosition.longitude}'
      '&appid=$weatherApiKey'
      '&units=metric'
      '&lang=ru',
    );
    Map<String, dynamic> result = response.data;
    // talker.info(weatherDataMap);
    // talker.info(response.data);
    // locationMessage = 'Широта: ${position.latitude},\nДолгота: ${position.longitude}';
    return result;
  }
}
