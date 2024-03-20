import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/library/helpers/_helpers.dart';
import 'package:mordor_suit/models/_models.dart';
import 'package:mordor_suit/prebuilt/empty_weather_preset.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../enums/_enums.dart';

part 'preset_weather_store.g.dart';

AppStore _appStorePWS = GetIt.I<AppStore>();

class PresetWeatherStore = _PresetWeatherStore with _$PresetWeatherStore;

abstract class _PresetWeatherStore with Store {
  _PresetWeatherStore({
    required this.talker,
  });

  final Talker talker;

  String weatherApiKey = dotenv.get('WEATHER_API_KEY');
  Dio dio = GetIt.I<Dio>();

  @observable
  Icon defaultOrUnknownWeatherIcon =
      const Icon(Icons.question_mark, color: Colors.transparent);

  @observable
  WeatherPreset weatherDataMap = emptyWeatherPreset;

// =============================================================================

  @computed
  String? get city => weatherDataMap.name;

  @computed
  bool get isWeatherLoaded => city != null;

  @computed
  String? get weather {
    try {
      return StringHelper.capitalizeFirstSymbol(
          weatherDataMap.weather?[0]['description']);
    } catch (e) {
      talker.debug(e);
      return null;
    }
  }

  @computed
  Map<String, dynamic>? get mapTemp => weatherDataMap.main;

  @computed
  num get temperature => mapTemp != null ? mapTemp!['temp'] : 999;

  @computed
  num get feelsLikeTemp => mapTemp != null ? mapTemp!['feels_like'] : 999;

  @computed
  TemperatureTypes get currentTemperatureType =>
      TempHelper.mapTempToTempType(temperature: temperature);

  @computed
  String get temperatureName =>
      TempHelper.mapTempToName(temperature: currentTemperatureType);

// =============================================================================

  @action
  void dropPresetWeatherData() => weatherDataMap = emptyWeatherPreset;

  @action
  void setSuitByWeatherManually(WeatherPreset weatherPreset) {
    dropPresetWeatherData();
    weatherDataMap = weatherPreset;
  }
}
