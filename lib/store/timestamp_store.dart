import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mobx/mobx.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'timestamp_store.g.dart';

class TimestampStore = _TimestampStore with _$TimestampStore;

abstract class _TimestampStore with Store {
  _TimestampStore({
    required this.talker,
  });

  final Talker talker;
  DefaultCacheManager cacheManager = DefaultCacheManager();
  int ttlInMinutes = 30;

  @observable
  DateTime currentTimestamp = DateTime.now();

  @observable
  DateTime? cachedTimestamp;

  @observable
  bool isNeedLoadData = false;
  // => cachedTimestamp == null
  //     ? true
  //     : cachedTimestamp!.isAfter(currentTimestamp)
  //         ? false
  //         : true;

  @action
  Future<void> checkTimestampWithRefresh() async {
    try {

      FileInfo? timestampFile = await _getFileFromCache(cacheManager);

      if (timestampFile != null) {
        String timestampString = await timestampFile.file.readAsString();
        cachedTimestamp = DateTime.parse(timestampString);
        if (cachedTimestamp!.add(Duration(minutes: ttlInMinutes)).isBefore(currentTimestamp)) {
          talker.warning('кэшированный таймштамп устарел');
          await refreshTimestampCache(cacheManager, currentTimestamp, ttlInMinutes);
          isNeedLoadData = true;
        } else {
          talker.debug('Таймштамп валидный: $cachedTimestamp');
          talker.debug('Истечёт: ${cachedTimestamp!.add(Duration(minutes: ttlInMinutes))}');
        }
      } else {
        talker.warning('Таймштампа нет');
        await refreshTimestampCache(cacheManager, currentTimestamp, ttlInMinutes);
        // isNeedLoadData = true;
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
    int ttlInMinutes,
  ) async {
    await cacheManager.putFile(
      'timestamp',
      utf8.encode(currentTime.toString()),
      maxAge: Duration(minutes: ttlInMinutes),
    );
    // talker.info('УСТАНОВИЛ');
    talker.warning('рефрешу таймштамп');
    talker.warning('сейчас ${currentTime.toString()}');
    FileInfo? timestampFile = await _getFileFromCache(cacheManager);
    talker.info('2: Получение таймштампа из кэша завершено');

    if (timestampFile != null) {
      String timestampString = await timestampFile.file.readAsString();
      talker.info('3: Чтение таймштампа из файла завершено');
      cachedTimestamp = DateTime.parse(timestampString);

      talker.info('ОТРЕФРЕШЕНЫЙ ${DateTime.parse(timestampString)}');
    }
  }

  Future<FileInfo?> _getFileFromCache(DefaultCacheManager cacheManager) async {
    FileInfo? timestampFile = await cacheManager.getFileFromCache('timestamp');
    return timestampFile;
  }
}
