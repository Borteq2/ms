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
  frostPunk,
  cold,
  belowZero,
  aboveZero,
  low,
  warm,
  heat,
  melting
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
        TemperatureTypes.warm => 'Жарко"',
        TemperatureTypes.heat => 'Очень жарко',
        TemperatureTypes.melting => 'Жара',
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
