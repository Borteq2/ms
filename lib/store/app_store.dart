import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:geolocator/geolocator.dart';
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

  DefaultCacheManager cacheManager = DefaultCacheManager();
  DateTime currentTime = DateTime.now();
  int ttlInMinutes = 30;

  Talker talker = GetIt.I<Talker>();

  @observable
  CurrentWeatherStore currentWeatherStore =
      CurrentWeatherStore(talker: GetIt.I<Talker>());

  @observable
  SuitStore suitStore = SuitStore(talker: GetIt.I<Talker>());

  @observable
  WeatherPresetsStore weatherPresetsStore =
      WeatherPresetsStore(talker: GetIt.I<Talker>());

  @observable
  String time = '';

  @observable
  bool isNeedLoadData = false;

// =============================================================================

  // @computed

// =============================================================================

  @action
  Future<void> checkTimestamp() async {


    try {
      await _checkStoragePermissions();

      FileInfo? timestampFile = await _getFileFromCache(cacheManager);

      if (timestampFile != null) {
        String timestampString = await timestampFile.file.readAsString();
        if (timestampFile.validTill.isBefore(currentTime)) {
          talker.warning('Таймштамп протух, дропаю кэш');
          dropTimestampCache(cacheManager);
          talker.critical('рефрешу таймштамп');
          await refreshTimestampCache(cacheManager, currentTime, ttlInMinutes);
          isNeedLoadData = true;
        } else {
          talker.critical('таймштамп свежий');
          DateTime cachedTimestamp = DateTime.parse(timestampString);
          time =
              '${cachedTimestamp.hour}:${cachedTimestamp.minute}:${cachedTimestamp.second}';
          isNeedLoadData = false;
        }
      } else {
        await refreshTimestampCache(cacheManager, currentTime, ttlInMinutes);
        isNeedLoadData = true;
      }
    } catch (e, st) {
      talker.critical('Произошла ошибка при проверке таймштампа:');
      talker.handle(e, st);
    }
    talker.critical('итого: $isNeedLoadData');
  }

// =============================================================================

  Future<void> goToAppSettings() async {
    await openAppSettings();
  }

  Future<void> dropTimestampCache(DefaultCacheManager cacheManager) async {
    await cacheManager.emptyCache();
  }

  Future<void> _checkStoragePermissions() async {
    var status = await Permission.storage.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.storage.request();
    }
    if (status.isGranted) {
      talker.info('Разрешение на чтение файлов предоставлено');
    } else {
      talker.info('Разрешение на чтение файлов не предоставлено');
      throw const PermissionDeniedException(
          'Разрешение на чтение файлов не предоставлено');
    }
  }

  Future<void> refreshTimestampCache(
    DefaultCacheManager cacheManager,
    DateTime currentTime,
    int ttlInMinutes,
  ) async {
    await cacheManager.putFile(
      'timestamp',
      utf8.encode(currentTime.toString()),
      maxAge: Duration(minutes: ttlInMinutes),
    );
    talker.info('УСТАНОВИЛ');
    talker.warning('рефрешу таймштамп');
    FileInfo? timestampFile = await _getFileFromCache(cacheManager);
    talker.info('2: Получение таймштампа из кэша завершено');

    if (timestampFile != null) {
      String timestampString = await timestampFile.file.readAsString();
      talker.info('3: Чтение таймштампа из файла завершено');
      DateTime cachedTimestamp = DateTime.parse(timestampString);
      time =
          '${cachedTimestamp.hour}:${cachedTimestamp.minute}:${cachedTimestamp.second}';
      talker.info('ОТРЕФРЕШЕНЫЙ');
    }
  }

  Future<FileInfo?> _getFileFromCache(DefaultCacheManager cacheManager) async {
    FileInfo? timestampFile = await cacheManager.getFileFromCache('timestamp');
    return timestampFile;
  }
}
