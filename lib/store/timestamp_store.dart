import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'timestamp_store.g.dart';

AppStore _appStoreTS = GetIt.I<AppStore>();

class TimestampStore = _TimestampStore with _$TimestampStore;

abstract class _TimestampStore with Store {
  _TimestampStore({
    required this.talker,
  });

  final Talker talker;
  DefaultCacheManager cacheManager = DefaultCacheManager();

  @observable
  DateTime currentTimestamp = DateTime.now();

  @observable
  DateTime? cachedTimestamp;

  @observable
  bool isNeedLoadData = false;

  @computed
  String get time =>
      '${cachedTimestamp?.hour ?? ''}:${cachedTimestamp?.minute ?? ''}:${cachedTimestamp?.second ?? ''}';

  @action
  Future<void> checkTimestampWithRefresh() async {
    try {
      FileInfo? timestampFile = await _getFileFromCache(cacheManager);

      if (timestampFile != null) {
        String timestampString = await timestampFile.file.readAsString();
        cachedTimestamp = DateTime.parse(timestampString);
        if (cachedTimestamp!
            .add(const Duration(minutes: 30))
            .isBefore(currentTimestamp)) {
          talker.debug('кэшированный таймштамп устарел');
          await refreshTimestampCache(cacheManager, currentTimestamp);
          isNeedLoadData = true;
        } else {
          talker.debug('Таймштамп валидный: $cachedTimestamp');
          talker.debug(
              'Истечёт: ${cachedTimestamp!.add(const Duration(minutes: 30))}');
        }
      } else {
        talker.debug('Таймштампа нет');
        await refreshTimestampCache(cacheManager, currentTimestamp);
        isNeedLoadData = true;
        await checkTimestampWithRefresh();
      }
    } catch (e, st) {
      talker.critical('Произошла ошибка при проверке таймштампа:');
      talker.handle(e, st);
    }
    talker.debug('Нужно ли грузить данные из сети: $isNeedLoadData');
  }

  Future<void> dropTimestampCache(DefaultCacheManager cacheManager) async {
    await cacheManager.emptyCache();
  }

  @action
  Future<void> refreshTimestampCache(
    DefaultCacheManager cacheManager,
    DateTime currentTime,
  ) async {
    await cacheManager.putFile(
      'timestamp',
      utf8.encode(currentTime.toString()),
    );
    // talker.info('УСТАНОВИЛ');
    talker.debug('рефрешу таймштамп');
    talker.debug('сейчас ${currentTime.toString()}');
    FileInfo? timestampFile = await _getFileFromCache(cacheManager);
    talker.debug('2: Получение таймштампа из кэша завершено');

    if (timestampFile != null) {
      String timestampString = await timestampFile.file.readAsString();
      talker.debug('3: Чтение таймштампа из файла завершено');
      cachedTimestamp = DateTime.parse(timestampString);
      talker.debug('3: Добытый шаймштамп: $cachedTimestamp');

      talker.debug('ОТРЕФРЕШЕНЫЙ ${DateTime.parse(timestampString)}');
    }
  }

  Future<FileInfo?> _getFileFromCache(DefaultCacheManager cacheManager) async {
    FileInfo? timestampFile = await cacheManager.getFileFromCache('timestamp');
    // talker.critical(await timestampFile!.file.readAsString());
    return timestampFile;
  }
}
