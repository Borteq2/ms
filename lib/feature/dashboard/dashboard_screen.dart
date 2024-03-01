import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: TitleWidget(appStore: appStore),
        ),
        body: appStore.weatherStore.isWeatherLoaded
            ? WeatherGridWidget(appStore: appStore)
            : LoadingWidget(appStore: appStore),
        floatingActionButton: appStore.weatherStore.city.toString().isEmpty ||
                appStore.suitStore.layersWithItemsCount > 0
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
                      appStore.suitStore.setSuitByTemperatureType(),
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
                        // color: Theme.of(context).textTheme.bodyMedium?.color,
                        tooltip: 'Обновить',
                        icon: const Icon(Icons.refresh, size: 28),
                        onPressed: () {
                          if (appStore.suitStore.layersWithItemsCount == 0) {
                            appStore.weatherStore.getLocation();
                            appStore.weatherStore.getLocationAndWeatherData();
                          } else {
                            appStore.weatherStore.getLocation();
                            appStore.weatherStore.getLocationAndWeatherData();
                            appStore.suitStore.refreshSuitData();
                          }
                        },
                      ),
                      IconButton(
                        // color: Theme.of(context).textTheme.bodyMedium?.color,
                        onPressed: () {},
                        tooltip: '',
                        icon: const Icon(Icons.question_mark, size: 28),
                      ),
                      if (appStore.centerLocations
                          .contains(appStore.fabLocation))
                        const Spacer(),
                      IconButton(
                        // color: Theme.of(context).textTheme.bodyMedium?.color,
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

class WeatherGridWidget extends StatelessWidget {
  const WeatherGridWidget({
    super.key,
    required this.appStore,
  });

  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Данные обновлены: ${appStore.weatherStore.timestamp}'),
        const SizedBox(height: 8),
        Expanded(
          child: GridView.builder(
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: 10,
            itemBuilder: (context, index) => InkWell(
              onTap: () => context.go('/set'),
              child: const Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Название города', overflow: TextOverflow.ellipsis),
                    Icon(Icons.cloudy_snowing),
                    Text('Пасмурно с прояснениями'),
                    Text('10 *C'),
                    Text('Ощущается как 11*C'),
                    Text('Влажность 15%'),
                    Text('Ветер 3 м/с')
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
