import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/foundation.dart';
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

    if (permissions[Permission.location] == PermissionStatus.granted &&
        permissions[Permission.storage] == PermissionStatus.granted) {
      await appStore.timestampStore.checkTimestampWithRefresh();

      await appStore.localWeatherStore.getLocationAndWeatherData();
    } else {
      talker.critical('Не удалось получить все необходимые разрешения');
      appStore.localWeatherStore.localWeatherDataMap = {
        'name': 'Не могу определить местоположение'
      };
      if (kReleaseMode) {
        AppMetrica.reportEventWithMap('Не даны разрешения', {
          'Локация': '${permissions[Permission.location]}',
          'Хранилище': '${permissions[Permission.storage]}'
        });
        AppMetrica.reportError(
          message: 'Не даны разрешения',
          errorDescription: AppMetricaErrorDescription.fromCurrentStackTrace(
              message: 'Локация: ${permissions[Permission.location]}, '
                  'Хранилище: ${permissions[Permission.storage]}',
              type: 'Некорректное взаимодействие с приложеннием'),
        ).ignore();
      }
    }
    appStore.timestampStore.isNeedLoadData
        ? await appStore.weatherPresetsStore.fetchCityWeatherData()
        : await appStore.weatherPresetsStore.getWeatherPresetsListFromCache();
  }

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    if (kReleaseMode) {
      AppMetrica.reportEvent('Открыт экран пресетов погоды');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(title: TitleWidget(appStore: appStore)),
        body: PresetsGridWidget(appStore: appStore),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            color: Colors.black,
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
            itemBuilder: (context) {
              if (kReleaseMode) {
                AppMetrica.reportEvent('Открыто меню FAB');
              }
              return <PopupMenuItem>[
                PopupMenuItem(
                  value: 1,
                  onTap: () {
                    if (kReleaseMode) {
                      AppMetrica.reportEvent(
                          'Нажата кнопка создания локации по названию города');
                    }
                    showDialog(
                        context: context,
                        builder: (context) =>
                            AddPresetModal(appStore: appStore));
                  },
                  child: const Text(
                    'Добавить город',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: CustomPopupMenuItem(),
                ),
              ];
            },
          ),
        ),
        floatingActionButtonLocation: appStore.fabLocation,
        bottomNavigationBar: BotAppBar(appStore: appStore),
      ),
    );
  }
}

class CustomPopupMenuItem extends StatefulWidget {
  const CustomPopupMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  _CustomPopupMenuItemState createState() => _CustomPopupMenuItemState();
}

class _CustomPopupMenuItemState extends State<CustomPopupMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListTile(
        trailing: appStore.localWeatherStore.isWeatherLoaded
            ? const SizedBox.shrink()
            : const SizedBox(
                width: 10,
                height: 10,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
        enabled: appStore.localWeatherStore.isWeatherLoaded,
        onTap: () {
          if (kReleaseMode) {
            AppMetrica.reportEvent('Нажата кнопка "Одеться здесь и сейчас');
          }
          appStore.currentWeatherStore.setSuitByWeatherManually(
              appStore.localWeatherStore.localWeatherDataMap);
          Navigator.pop(context);
          context.go(
            '/set',
            extra: appStore.currentWeatherStore.weatherDataMap,
          );
        },
        title: Text(
          appStore.localWeatherStore.isWeatherLoaded
              ? 'Одеться здесь и сейчас'
              : 'Загрузка текущей локации...',
          style: TextStyle(
            color: appStore.localWeatherStore.isWeatherLoaded
                ? Colors.deepOrange
                : Colors.grey,
          ),
        ),
      ),
    );
  }
}
