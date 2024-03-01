import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:mordor_suit/feature/dashboard/widgets/_widgets.dart';
import 'package:mordor_suit/feature/widgets/_widgets.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Talker talker = GetIt.I<Talker>();
  AppStore appStore = GetIt.I<AppStore>();

  @override
  void initState() {
    super.initState();
    appStore.weatherStore.geoPermission = true;
    appStore.weatherStore.getLocationAndWeatherData();
    appStore.weatherPresetsStore.fetchCityWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: TitleWidget(appStore: appStore),
        ),
        body: appStore.weatherStore.isWeatherLoaded
            ? PresetsGridWidget(appStore: appStore)
            : LoadingWidget(appStore: appStore),
        floatingActionButton: appStore.weatherStore.city.toString().isEmpty
            ? const SizedBox.shrink()
            : Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                child: FloatingActionButton(
                  onPressed: () =>
                      appStore.weatherPresetsStore.addPreset('Сызрань'),
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
        bottomNavigationBar: appStore.weatherStore.city.toString().isEmpty
            ? const SizedBox.shrink()
            : ClipRRect(
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
                          appStore.weatherStore.getLocation();
                          appStore.weatherStore.getLocationAndWeatherData();
                        },
                      ),
                      IconButton(
                        onPressed: () =>
                            appStore.weatherPresetsStore.fetchCityWeatherData(),
                        icon: const Icon(Icons.play_arrow),
                      ),
                      if (appStore.centerLocations
                          .contains(appStore.fabLocation))
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
