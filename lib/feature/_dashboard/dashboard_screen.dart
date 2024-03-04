import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  // Future<void> validateTimestamp() async {
  //   talker.info('1');
  //   DateTime? cachedTimestamp = await TimestampService.getTimestamp();
  //   talker.info('2');
  //   if (cachedTimestamp == null) {
  //     talker.warning('штамп нул');
  //     isNeedLoadData = true;
  //     return;
  //   }
  //   talker.info('3');
  //   talker.warning(cachedTimestamp.difference(DateTime.now()).inMinutes > 3);
  //   talker.info(cachedTimestamp);
  //   talker.info(DateTime.now());
  //   if (cachedTimestamp.difference(DateTime.now()).inMinutes > 3) {
  //     talker.warning('штамп старый');
  //     isNeedLoadData = true;
  //   } else {
  //     talker.warning('штамп свежий');
  //     isNeedLoadData = false;
  //   }
  //   talker.info('4');
  //   if (isNeedLoadData) {
  //     talker.warning('штамп сохраняю дату загружаю');
  //     await TimestampService.saveTimestamp(DateTime.now());
  //     try {
  //       talker.info('5');
  //       cachedTimestamp = await TimestampService.getTimestamp();
  //       timestampNow = cachedTimestamp;
  //     } catch (e, st) {
  //       talker.critical(e, st);
  //     }
  //   } else {
  //     try {
  //       talker.info('6');
  //       talker.warning('штамп только достаю дату не гружу');
  //       cachedTimestamp = await TimestampService.getTimestamp();
  //       timestampNow = cachedTimestamp;
  //     } catch (e, st) {
  //       talker.critical(e, st);
  //     }
  //   }
  //   talker.info('7');
  //   setState(() {});
  // }

  Future<void> checkTimestamp() async {
    DefaultCacheManager cacheManager = DefaultCacheManager();
    DateTime now = DateTime.now();
    int ttlInSeconds = 1800;

    try {
      var status = await Permission.storage.status;
      if (status.isDenied || status.isPermanentlyDenied) {
        status = await Permission.storage.request();
      }
      if (status.isGranted) {
        talker.info('Разрешение на чтение файлов предоставлено');
      } else {
        talker.info('Разрешение на чтение файлов не предоставлено');
      }
      talker.info('1: Начало проверки таймштампа');
      FileInfo? timestampFile =
          await cacheManager.getFileFromCache('timestamp');
      talker.info('2: Получение таймштампа из кэша завершено');
      if (timestampFile != null) {
        String timestampString = await timestampFile.file.readAsString();
        talker.info('3: Чтение таймштампа из файла завершено');
        DateTime cachedTimestamp = DateTime.parse(timestampString);
        if (now.difference(cachedTimestamp).inMinutes > 30) {
          talker.info('СТАРЫЙ');
          await cacheManager.putFile(
            'timestamp',
            utf8.encode(now.toString()),
            maxAge: Duration(seconds: ttlInSeconds),
          );
          talker.info('УСТАНОВИЛ');
          talker.info('1: Начало проверки таймштампа');
          FileInfo? timestampFile =
              await cacheManager.getFileFromCache('timestamp');
          talker.info('2: Получение таймштампа из кэша завершено');
          String timestampString = await timestampFile!.file.readAsString();
          talker.info('3: Чтение таймштампа из файла завершено');
          DateTime cachedTimestamp = DateTime.parse(timestampString);
          time =
              '${cachedTimestamp.hour}:${cachedTimestamp.minute}:${cachedTimestamp.second}';
          isNeedLoadData = true;
        } else {
          talker.info('СВЕЖИЙ');
          time =
              '${cachedTimestamp.hour}:${cachedTimestamp.minute}:${cachedTimestamp.second}';
          isNeedLoadData = false;
        }
      } else {
        await cacheManager.putFile(
          'timestamp',
          utf8.encode(now.toString()),
          maxAge: Duration(seconds: ttlInSeconds),
        );
        talker.info('УСТАНОВИЛ');
        talker.info('1: Начало проверки таймштампа');
        FileInfo? timestampFile =
            await cacheManager.getFileFromCache('timestamp');
        talker.info('2: Получение таймштампа из кэша завершено');
        String timestampString = await timestampFile!.file.readAsString();
        talker.info('3: Чтение таймштампа из файла завершено');
        DateTime cachedTimestamp = DateTime.parse(timestampString);
        time =
            '${cachedTimestamp.hour}:${cachedTimestamp.minute}:${cachedTimestamp.second}';
      }
    } catch (e, st) {
      talker.info('Произошла ошибка при проверке таймштампа:');
      talker.handle(e, st);
    }
  }

  @override
  void initState() {
    super.initState();
    appStore.currentWeatherStore.geoPermission = true;
    // appStore.weatherStore.getLocationAndWeatherData();
    // appStore.weatherPresetsStore.fetchCityWeatherData();

    // validateTimestamp();

    checkTimestamp().then((_) => setState(() {}));
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
        body: Placeholder(),
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
