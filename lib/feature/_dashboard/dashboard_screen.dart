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
      talker.critical(
          permissions[Permission.location] == PermissionStatus.granted);
      talker.critical(
          permissions[Permission.storage] == PermissionStatus.granted);
      appStore.localWeatherStore.getLocationAndWeatherData();
      await appStore.weatherPresetsStore.dropWeatherPresetsCache(appStore.cacheManager);
      // appStore.weatherPresetsStore.cityNamesStore.syncCityNamesWithBox();
      await appStore.weatherPresetsStore.getWeatherPresetsListFromCache();
    } else {
      talker.critical('Не удалось получить все необходимые разрешения');
    }
  }

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  // // appStore.currentWeatherStore.geoPermission = true;
  // appStore.currentWeatherStore.dropCurrentWeatherData();
  // // appStore.currentWeatherStore.getLocation();
  // appStore.currentWeatherStore.getLocationAndWeatherData();
  //
  // if (appStore.currentWeatherStore.geoPermission == true) {
  //   // Если разрешение получено, записываем данные в кэш
  //   appStore.checkTimestamp().then((_) => setState(() {}));
  //   if (appStore.isNeedLoadData) {
  //     appStore.weatherPresetsStore.fetchCityWeatherData();
  //   } else {
  //     appStore.weatherPresetsStore.dropPresetWeatherData();
  //     appStore.weatherPresetsStore.cityNamesStore.syncCityNamesWithBox();
  //     talker.critical('Беру данные из кэша');
  //     appStore.weatherPresetsStore.getWeatherPresetsListFromCache();
  //   }
  //   setState(() {});
  // } else {
  //   // Если разрешение не получено, обрабатываем это
  //   // Например, показываем пользователю сообщение о том, что без доступа к геолокации приложение работает ограниченно
  //   print('Доступ к геолокации не получен');
  // }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        talker.warning(appStore.weatherPresetsStore.cityNamesStore.presetsCityNamesCount);
        talker.warning(appStore.weatherPresetsStore.presetCityWeatherData.length);
        for (Map<String, dynamic >i in appStore.weatherPresetsStore.presetCityWeatherData) {
          talker.warning(i['name']);
        }
        return Scaffold(
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
        );
      },
    );
  }
}
