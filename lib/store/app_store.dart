import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/enums/_enums.dart';
import 'package:mordor_suit/library/helpers/_helpers.dart';
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

  @action
  void dropAllErrors() => appErrors.clear();

// =============================================================================

  Future<void> goToAppSettings() async {
    await openAppSettings();
  }

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

  void requestPermissions() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.location,
      Permission.storage,
    ].request();

    await checkPermissions(permissions);
    await needLoadDataSolution();
  }

  Future<void> needLoadDataSolution() async {
    timestampStore.isNeedLoadData
        ? await weatherPresetsStore.fetchCityWeatherData()
        : await weatherPresetsStore.getWeatherPresetsListFromCache();
  }

  Future<void> checkPermissions(
      Map<Permission, PermissionStatus> permissions) async {
    if (permissions[Permission.location] == PermissionStatus.granted &&
        permissions[Permission.storage] == PermissionStatus.granted) {
      // appStore.changeIsHasPermissionErrors(false);
      removeError(ErrorType.noLocationPermission);
      removeError(ErrorType.noStoragePermission);
      await timestampStore.checkTimestampWithRefresh();
      await localWeatherStore.getLocationAndWeatherData();
    } else {
      talker.critical('Не удалось получить все необходимые разрешения');
      if (permissions[Permission.location] != PermissionStatus.granted) {
        addError(ErrorType.noLocationPermission);
      }
      if (permissions[Permission.storage] == PermissionStatus.granted) {
        addError(ErrorType.noStoragePermission);
      }

      Report.map(
        event: 'Не даны разрешения',
        map: {
          'Локация': '${permissions[Permission.location]}',
          'Хранилище': '${permissions[Permission.storage]}'
        },
      );
      Report.error(
          message: 'Не даны разрешения',
          descriptionMessage:
              'Локация: ${permissions[Permission.location]}, Хранилище: ${permissions[Permission.storage]}',
          type: 'Некорректное взаимодействие с приложеннием');
    }
  }
}
