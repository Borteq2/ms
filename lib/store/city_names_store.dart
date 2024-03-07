import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'city_names_store.g.dart';

class CityNamesStore = _CityNamesStore with _$CityNamesStore;

abstract class _CityNamesStore with Store {
  _CityNamesStore({
    required this.talker,
  });

  final Talker talker;
  String weatherApiKey = dotenv.get('WEATHER_API_KEY');
  Dio dio = GetIt.I<Dio>();
  Box cityNamesBox = GetIt.I<Box<String>>(instanceName: 'city_names_box');

// =============================================================================

  @observable
  ObservableList<String> presetsCityNames = ObservableList();

// =============================================================================

  @computed
  int get presetsCityNamesCount => presetsCityNames.length;

// =============================================================================

  @action
  void syncCityNamesWithBox() => presetsCityNames =
      ObservableList.of(cityNamesBox.values.cast<String>().toList());

  @action
  void dropPresetsCityNames() => presetsCityNames.clear();

  @action
  void deleteLastCityName() => cityNamesBox.deleteAt(cityNamesBox.length -1);

// =============================================================================



// =============================================================================
}
