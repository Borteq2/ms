import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
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

  // TODO: зачем?
  @observable
  bool geoPermission = false;

  @observable
  late Position currentPosition;

  @observable
  Icon weatherIcon = const Icon(Icons.question_mark, color: Colors.transparent);

  // TODO: рефактор в модель
  @observable
  Map<String, dynamic> localWeatherDataMap = emptyWeatherPreset;

// =============================================================================

  @computed
  String get city => localWeatherDataMap['name'];

  // TODO: рефактор в модель
  @computed
  bool get isWeatherLoaded => city != '';

  @computed
  String get weather {
    try {
      String result = StringHelper.capitalizeFirstSymbol(
          localWeatherDataMap['weather'][0]['description']);
      return result;
    } catch (e) {
      talker.critical(e);
    }
    // TODO: рефактор в модель
    return '';
  }

  // TODO: рефактор в модель
  @computed
  Map<String, dynamic> get mapTemp => localWeatherDataMap['main'];

  // TODO: рефактор в модель
  @computed
  num get temperature => mapTemp.isNotEmpty ? mapTemp['temp'] : 999;

  // TODO: рефактор в модель
  @computed
  num get feelsLikeTemp => mapTemp.isNotEmpty ? mapTemp['feels_like'] : 999;

  @computed
  TemperatureTypes get currentTemperatureType =>
      TempHelper.mapTempToTempType(temperature: temperature);

  @computed
  String get temperatureName =>
      TempHelper.mapTempToName(temperature: currentTemperatureType);

// =============================================================================

  @action
  void dropLocalWeatherData() => localWeatherDataMap = emptyWeatherPreset;

  @action
  void setSuitByWeatherManually(Map<String, dynamic> weather) {
    dropLocalWeatherData();
    localWeatherDataMap = weather;
  }

  @action
  Future<void> getLocationAndWeatherData() async {
    dropLocalWeatherData();
    try {
      await getLocalLocation();
      localWeatherDataMap = await fetchWeatherByLocalLocation();
      // talker.warning(localWeatherDataMap);
      weatherIcon = IconHelper.getIconByWeather(
          localWeatherDataMap['weather'][0]['main']);
    } catch (e) {
      talker.critical(e);
    }
  }

// =============================================================================

  Future<Position> getLocalLocation() async {
    talker.debug('Запрашиваю локальную локацию');
    _appStoreLWS.requestPermissionsAndLoadDataIfNeeded();

    Position result = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentPosition = result;
    return result;
  }

  Future<Map<String, dynamic>> fetchWeatherByLocalLocation() async {
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
    return result;
  }
}
