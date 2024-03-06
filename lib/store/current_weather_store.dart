import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/feature/library/logic/capitalize_first_symbol.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'current_weather_store.g.dart';

enum TemperatureTypes {
  notSupported,
  cold,
  low,
  warm,
  heat,
}

class CurrentWeatherStore = _CurrentWeatherStore with _$CurrentWeatherStore;

abstract class _CurrentWeatherStore with Store {
  _CurrentWeatherStore({
    required this.talker,
  });

  final Talker talker;
  String weatherApiKey = dotenv.get('WEATHER_API_KEY');
  Dio dio = GetIt.I<Dio>();

  @observable
  bool geoPermission = false;

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
      return StringHelper.capitalizeFirstSymbol(
          weatherDataMap['weather'][0]['description']);
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
  double get feelsLikeTemp => mapTemp.isNotEmpty ? mapTemp['feels_like'] : 999;

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
  void dropCurrentWeatherData() {
    weatherDataMap = {
      'name': '',
      'main': {'temp': ''}
    };
  }

  @action
  void setSuitByWeatherManually(Map<String, dynamic> weather) {
    dropCurrentWeatherData();
    weatherDataMap = weather;
  }
}
