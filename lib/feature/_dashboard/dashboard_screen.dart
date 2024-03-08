import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:mordor_suit/feature/_dashboard/widgets/_widgets.dart';
import 'package:mordor_suit/feature/library/widgets/_widgets.dart';
import 'package:mordor_suit/store/_stores.dart';

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

    // TODO: вернуть проверку таймштампа

    if (permissions[Permission.location] == PermissionStatus.granted &&
        permissions[Permission.storage] == PermissionStatus.granted) {
      await appStore.timestampStore.checkTimestampWithRefresh();

      // await appStore.weatherPresetsStore.dropWeatherPresetsCache(appStore.weatherPresetsStore.cacheManager);

      // appStore.weatherPresetsStore.cityNamesStore.syncCityNamesWithBox();

      // await appStore.timestampStore.dropTimestampCache(appStore.timestampStore.cacheManager);

      appStore.timestampStore.isNeedLoadData
          ? await appStore.weatherPresetsStore.fetchCityWeatherData()
          : await appStore.weatherPresetsStore.getWeatherPresetsListFromCache();
      await appStore.localWeatherStore.getLocationAndWeatherData();

    } else {
      talker.critical('Не удалось получить все необходимые разрешения');
    }
  }

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(title: TitleWidget(appStore: appStore)),
        body: PresetsGridWidget(appStore: appStore),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          child: PopupMenuButton(
            icon: SvgPicture.asset(
              'assets/images/favicon.svg',
              width: 40,
              height: 40,
            ),
            color: Colors.black.withOpacity(0.9),
            surfaceTintColor: Colors.transparent,
            offset: const Offset(-50, -125),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                onTap: () => showDialog(
                    context: context,
                    builder: (context) => AddPresetModal(appStore: appStore)),
                child: const Text(
                  'Добавить город',
                  style: TextStyle(color: Colors.deepOrange),
                ),
              ),
              PopupMenuItem(
                value: 2,
                onTap: () {
                  appStore.currentWeatherStore.setSuitByWeatherManually(
                      appStore.localWeatherStore.localWeatherDataMap);
                  context.go(
                    '/set',
                    extra: appStore.currentWeatherStore.weatherDataMap,
                  );
                },
                child: const Text(
                  'Одеться здесь и сейчас',
                  style: TextStyle(color: Colors.deepOrange),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: appStore.fabLocation,
        bottomNavigationBar: BotAppBar(appStore: appStore),
      ),
    );
  }
}
