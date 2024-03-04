import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mordor_suit/feature/_dashboard/widgets/_widgets.dart';
import 'package:mordor_suit/feature/library/logic/timestamp.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Talker talker = GetIt.I<Talker>();
  AppStore appStore = GetIt.I<AppStore>();

  bool isNeedLoadData = true;
  String time = '';

  @override
  void initState() {
    super.initState();
    appStore.currentWeatherStore.geoPermission = true;
    // appStore.weatherStore.getLocationAndWeatherData();
    // appStore.weatherPresetsStore.fetchCityWeatherData();

    // validateTimestamp();

    checkTimestamp().then((_) => setState(() {}));
  }

  Future<void> checkTimestamp() async {
    DefaultCacheManager cacheManager = DefaultCacheManager();
    DateTime currentTime = DateTime.now();
    int ttlInMinutes = 30;

    _drop(cacheManager);

    try {
      await _checkStoragePermissions();

      FileInfo? timestampFile = await _getFileFromCache(cacheManager);

      if (timestampFile != null) {
        String timestampString = await timestampFile.file.readAsString();
        if (timestampFile.validTill.isBefore(currentTime)) {
          talker.warning('Таймштамп протух, дропаю кэш');
          _drop(cacheManager);
          await _refreshTimestampCache(cacheManager, currentTime, ttlInMinutes);
        }
        DateTime cachedTimestamp = DateTime.parse(timestampString);
        time = '${cachedTimestamp.hour}:${cachedTimestamp.minute}:${cachedTimestamp.second}';
      } else {
        await _refreshTimestampCache(cacheManager, currentTime, ttlInMinutes);
      }
    } catch (e, st) {
      talker.info('Произошла ошибка при проверке таймштампа:');
      talker.handle(e, st);
    }
  }

  void _drop(DefaultCacheManager cacheManager) {
    cacheManager.emptyCache();
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
      throw const PermissionDeniedException('Разрешение на чтение файлов не предоставлено');
    }
  }

  Future<void> _refreshTimestampCache(DefaultCacheManager cacheManager, DateTime currentTime, int ttlInMinutes) async {
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
    FileInfo? timestampFile =
    await cacheManager.getFileFromCache('timestamp');
    return timestampFile;
  }

  @override
  Widget build(BuildContext context) {
    talker.debug(
        appStore.weatherPresetsStore.cityNamesStore.presetsCityNames.length);
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          // title: TitleWidget(appStore: appStore, time: time),
          title: Row(
            children: [
              Text(time),
              Text(isNeedLoadData.toString()),
            ],
          ),
        ),
        body: const Placeholder(),
        // PresetsGridWidget(appStore: appStore),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          child: FloatingActionButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AddPresetModal(appStore: appStore),
            ),
            tooltip: 'Как экипироваться по погоде?',
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              'assets/images/favicon.svg',
              width: 60,
              height: 60,
            ),
          ),
        ),
        floatingActionButtonLocation: appStore.fabLocation,
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BottomAppBar(
            surfaceTintColor:
                Theme.of(context).bottomAppBarTheme.surfaceTintColor,
            shape: const CircularNotchedRectangle(),
            height: 64,
            notchMargin: 8.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  tooltip: 'Обновить',
                  icon: const Icon(Icons.refresh, size: 28),
                  onPressed: () {
                    appStore.currentWeatherStore.getLocation();
                    appStore.currentWeatherStore.getLocationAndWeatherData();
                  },
                ),
                IconButton(
                  onPressed: () =>
                      appStore.weatherPresetsStore.fetchCityWeatherData(),
                  icon: const Icon(Icons.play_arrow),
                ),
                if (appStore.centerLocations.contains(appStore.fabLocation))
                  const Spacer(),
                IconButton(
                  onPressed: () {},
                  tooltip: 'Отправить баг-репорт',
                  icon: const Icon(Icons.bug_report_outlined, size: 28),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddPresetModal extends StatefulWidget {
  final AppStore appStore;

  const AddPresetModal({
    Key? key,
    required this.appStore,
  }) : super(key: key);

  @override
  _AddPresetModalState createState() => _AddPresetModalState();
}

class _AddPresetModalState extends State<AddPresetModal> {
  late TextEditingController _cityNameController;

  @override
  void initState() {
    super.initState();
    _cityNameController = TextEditingController();
  }

  @override
  void dispose() {
    _cityNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppStore appStore = widget.appStore;

    return AlertDialog(
      title: const Text('Добавить локацию'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _cityNameController,
              decoration: const InputDecoration(labelText: 'Город'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            appStore.weatherPresetsStore.addPreset(_cityNameController.text);
            Navigator.of(context).pop();
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}


