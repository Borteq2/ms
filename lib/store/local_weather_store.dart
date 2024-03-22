import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/models/_models.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:mordor_suit/store/_stores.dart';
import 'package:mordor_suit/enums/_enums.dart';
import 'package:mordor_suit/library/helpers/_helpers.dart';
import 'package:mordor_suit/prebuilt/empty_weather_preset.dart';

part 'local_weather_store.g.dart';

AppStore _appStoreLWS = GetIt.I<AppStore>();

class LocalWeatherStore = _LocalWeatherStore with _$LocalWeatherStore;

abstract class _LocalWeatherStore with Store {
  _LocalWeatherStore({
    required this.talker,
  });

  final Talker talker;
  String weatherApiKey = dotenv.get('WEATHER_API_KEY');
  Dio dio = GetIt.I<Dio>();

  @observable
  late Position currentPosition;

  @observable
  Icon weatherIcon =
      const Icon(Icons.question_mark, color: Colors.transparent);

  @observable
  WeatherPreset localWeatherData = emptyWeatherPreset;

// =============================================================================

  @computed
  String? get city => localWeatherData.name;

  @computed
  bool get isWeatherLoaded => city != null;

  @computed
  String? get weather {
    try {
      String? result = StringHelper.capitalizeFirstSymbol(
          localWeatherData.weather?[0]['description']);
      return result;
    } catch (e) {
      talker.critical(e);
      return null;
    }
  }

  @computed
  Map<String, dynamic>? get mapTemp => localWeatherData.main;

  @computed
  num? get temperature => mapTemp?['temp'];

  @computed
  num? get feelsLikeTemp => mapTemp?['feels_like'];

  @computed
  TemperatureTypes get currentTemperatureType =>
      TempHelper.mapTempToTempType(temperature: temperature ?? 10000);

  @computed
  String? get temperatureName =>
      TempHelper.mapTempToName(temperature: currentTemperatureType);

// =============================================================================

  @action
  void dropLocalWeatherData() => localWeatherData = emptyWeatherPreset;

  @action
  void setSuitByWeatherManually(WeatherPreset weatherPreset) {
    dropLocalWeatherData();
    localWeatherData = weatherPreset;
  }

  @action
  Future<void> getLocationAndWeatherData() async {
    talker.warning('getLocationAndWeatherData');
    dropLocalWeatherData();
    try {
      await getLocalLocation();
      localWeatherData = await fetchWeatherByLocalLocation();
      // talker.warning(localWeatherDataMap);
      weatherIcon =
          IconHelper.getIconByWeather(localWeatherData.weather?[0]['main']);
    } catch (e) {
      talker.critical(e);
      {}
    }
  }

// =============================================================================

  Future<Position> getLocalLocation() async {
    talker.warning('getLocalLocation');
    talker.debug('Запрашиваю локальную локацию');
    _appStoreLWS.requestPermissionsAndLoadDataIfNeeded();

    Position result = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentPosition = result;
    return result;
  }

  Future<WeatherPreset> fetchWeatherByLocalLocation() async {
    talker.warning('fetchWeatherByLocalLocation');
    Dio dio = GetIt.I<Dio>();

    Response response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather'
      '?lat=${currentPosition.latitude}'
      '&lon=${currentPosition.longitude}'
      '&appid=$weatherApiKey'
      '&units=metric'
      '&lang=ru',
    );

    WeatherPreset result = WeatherPreset.fromJson(response.data);
    return result;
  }
}
