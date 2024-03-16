import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:mordor_suit/feature/_dashboard/widgets/_widgets.dart';
import 'package:mordor_suit/feature/library/helpers/report.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:mordor_suit/feature/_dashboard/subfeatures/_subfeatures_widgets.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Talker talker = GetIt.I<Talker>();
  AppStore appStore = GetIt.I<AppStore>();

  void _requestPermissions() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.location,
      Permission.storage,
    ].request();

    if (permissions[Permission.location] == PermissionStatus.granted &&
        permissions[Permission.storage] == PermissionStatus.granted) {
      await appStore.timestampStore.checkTimestampWithRefresh();

      await appStore.localWeatherStore.getLocationAndWeatherData();
    } else {
      talker.critical('Не удалось получить все необходимые разрешения');
      appStore.localWeatherStore.localWeatherDataMap = {
        'name': 'Не могу определить местоположение'
      };
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
    appStore.timestampStore.isNeedLoadData
        ? await appStore.weatherPresetsStore.fetchCityWeatherData()
        : await appStore.weatherPresetsStore.getWeatherPresetsListFromCache();
  }

  @override
  void initState() {
    super.initState();
    _requestPermissions();

    Report.map(
      event: 'Открыт экран пресетов погоды',
      map: {
        'Количество пресетов':
            appStore.weatherPresetsStore.cityNamesStore.presetsCityNamesCount
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(title: TitleWidget(appStore: appStore)),
        body: PresetsGridWidget(appStore: appStore),
        floatingActionButton: FABMenuWidget(appStore: appStore),
        floatingActionButtonLocation: appStore.fabLocation,
        bottomNavigationBar: BotAppBar(appStore: appStore),
      ),
    );
  }
}




