import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/enums/_enums.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:mordor_suit/store/local_weather_store.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];
  FloatingActionButtonLocation fabLocation =
      FloatingActionButtonLocation.centerDocked;

  Talker talker = GetIt.I<Talker>();

  //TODO: эксперимент DI
  @observable
  PresetWeatherStore presetWeatherStore =
      PresetWeatherStore(talker: GetIt.I<Talker>());

  @observable
  SuitStore suitStore = SuitStore(talker: GetIt.I<Talker>());

  @observable
  WeatherPresetsStore weatherPresetsStore =
      WeatherPresetsStore(talker: GetIt.I<Talker>());

  @observable
  CityNamesStore cityNamesStore = CityNamesStore(talker: GetIt.I<Talker>());

  @observable
  TimestampStore timestampStore = TimestampStore(talker: GetIt.I<Talker>());

  @observable
  LocalWeatherStore localWeatherStore =
      LocalWeatherStore(talker: GetIt.I<Talker>());

  @observable
  ClothingMemoryStore clothingMemoryStore =
      ClothingMemoryStore(talker: GetIt.I<Talker>());

  @observable
  ObservableSet<ErrorType> appErrors = ObservableSet.of(<ErrorType>[]);

// =============================================================================

  @computed
  bool get hasErrors => appErrors.isNotEmpty;

// =============================================================================

  @action
  void addError(ErrorType error) => appErrors.add(error);

  @action
  void removeError(ErrorType error) => appErrors.remove(error);

// =============================================================================

  Future<void> fullRefreshAndGetFromCache() async {
    talker.info('Полный рефреш данных (кроме локальной погоды)');
    talker.info(
        'Буду грузить ${timestampStore.isNeedLoadData ? 'Из сети' : 'Из кэша'}');
    await weatherPresetsStore
        .dropWeatherPresetsCache(weatherPresetsStore.cacheManager);
    weatherPresetsStore.dropPresetWeatherData();
    cityNamesStore.syncCityNamesWithBox();
    timestampStore.isNeedLoadData
        ? await weatherPresetsStore.fetchCityWeatherData()
        : await weatherPresetsStore.getWeatherPresetsListFromCache();
    // await appStore.weatherPresetsStore.getWeatherPresetsListFromCache();
    // talker.critical(cityNamesStore.presetsCityNamesCount);
  }

  Future<void> goToAppSettings() async {
    await openAppSettings();
  }
}
