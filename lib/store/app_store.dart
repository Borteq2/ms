import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/store/_stores.dart';

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

  @observable
  WeatherStore weatherStore = WeatherStore(talker: GetIt.I<Talker>());

  @observable
  SuitStore suitStore = SuitStore(talker: GetIt.I<Talker>());

  @observable
  WeatherPresetsStore weatherPresetsStore =
      WeatherPresetsStore(talker: GetIt.I<Talker>());

// =============================================================================

  // @computed

// =============================================================================

  // @action

// =============================================================================

  Future<void> goToAppSettings() async {
    await openAppSettings();
  }
}
