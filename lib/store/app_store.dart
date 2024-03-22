import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:mordor_suit/enums/_enums.dart';
import 'package:mordor_suit/exceptions/_exceptions.dart';
import 'package:mordor_suit/exceptions/location_permission_flat.dart';
import 'package:mordor_suit/library/helpers/_helpers.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:mordor_suit/store/local_weather_store.dart';

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

  @observable
  PresetWeatherStore presetWeatherStore =
      PresetWeatherStore(talker: GetIt.I<Talker>());

  @observable
  SuitStore suitStore = SuitStore(talker: GetIt.I<Talker>());

  @observable
  LocationPresetsStore locationPresetsStore =
      LocationPresetsStore(talker: GetIt.I<Talker>());

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

  @computed
  bool get hasLocationErrors =>
      (appErrors.contains(ErrorType.noLocationPermissionTemporary) ||
          appErrors.contains(ErrorType.noLocationPermissionForever) ||
          appErrors.contains(
            ErrorType.geoServiceDisabled,
          ));

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
    talker.warning('fullRefreshAndGetFromCache');
    talker.info('Полный рефреш данных (кроме локальной погоды)');
    talker.info(
        'Буду грузить ${timestampStore.isNeedLoadData ? 'Из сети' : 'Из кэша'}');
    await locationPresetsStore
        .dropLocationPresetsCache(locationPresetsStore.cacheManager);
    locationPresetsStore.dropPresetWeatherData();
    cityNamesStore.syncCityNamesWithBox();
    needLoadDataSolution();
    // await appStore.weatherPresetsStore.getWeatherPresetsListFromCache();
    // talker.critical(cityNamesStore.presetsCityNamesCount);
  }

  Future<void> requestPermissionsAndLoadDataIfNeeded() async {
    talker.critical('requestPermissionsAndLoadDataIfNeeded');
    // talker.warning('запросил пермишны');
    Map<Permission, PermissionStatus> permissions = await [
      Permission.location,
      // Permission.storage,
    ].request();

    // talker.warning('проверяю пермишны');
    await checkPermissions(permissions);
    // await checkGeoService();
    // talker.warning('решаю надо ли грузить данные из сети');
    await needLoadDataSolution();
  }

  Future<void> needLoadDataSolution() async {
    talker.warning('needLoadDataSolution');
    timestampStore.isNeedLoadData
        ? await locationPresetsStore.fetchCityWeatherData()
        : await locationPresetsStore.getLocationPresetsListFromCache();
  }

  List<PermissionStatus> statusesOK = [
    PermissionStatus.granted,
    PermissionStatus.limited,
    PermissionStatus.restricted
  ];

  @action
  Future<void> checkPermissions(
      Map<Permission, PermissionStatus> permissions) async {
    talker.warning('checkPermissions');
    await checkGeoService();

    // talker.critical(permissions[Permission.location]);

    // TODO: после удаления стораж пермишна что-то из этого избыточно
    if (statusesOK.contains(permissions[Permission.location])) {
      // пермишны в порядке, удаляю ошибки
      dropAllErrors();

      await timestampStore.checkTimestampWithRefresh();
    } else {
      if (permissions[Permission.location] == PermissionStatus.granted) {
        removeError(ErrorType.noLocationPermissionTemporary);
        removeError(ErrorType.noLocationPermissionForever);
      }
      try {
        // проверяю пермишн локации
        if (permissions[Permission.location] != PermissionStatus.granted) {
          // пермишн не дан временно
          if (permissions[Permission.location] == PermissionStatus.denied) {
            addError(ErrorType.noLocationPermissionTemporary);
          } else {
            // пермишн не дан навсегда
            if (permissions[Permission.location] ==
                PermissionStatus.permanentlyDenied) {
              addError(ErrorType.noLocationPermissionForever);
            }
          }
        }
      } catch (e) {
        throw LocationPermissionFlatException(e.toString());
      }

      Report.map(
        event: 'Не даны разрешения',
        map: {
          'Локация': '${permissions[Permission.location]}',
        },
      );
      Report.error(
          message: 'Не даны разрешения',
          descriptionMessage: 'Локация: ${permissions[Permission.location]}',
          type: 'Некорректное взаимодействие с приложеннием');
    }
  }

  Future<void> checkGeoService() async {
    talker.warning('checkGeoService');
    talker.debug('Проверяю геосервис');
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      talker.debug('Геосервис отключён');
      addError(ErrorType.geoServiceDisabled);
      throw LocationServiceException('Геолокация недоступна');
    } else {
      talker.debug('Геосервис включён');
      removeError(ErrorType.geoServiceDisabled);
    }
  }
}
