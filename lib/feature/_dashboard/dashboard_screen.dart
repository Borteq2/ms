import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mordor_suit/enums/_enums.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:mordor_suit/feature/_dashboard/subfeatures/_subfeatures_widgets.dart';
import 'package:mordor_suit/feature/_dashboard/widgets/_widgets.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:mordor_suit/library/helpers/_helpers.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Talker talker = GetIt.I<Talker>();
  AppStore appStore = GetIt.I<AppStore>();

  Future<void> loadLocalData() async {
    await appStore.requestPermissionsAndLoadDataIfNeeded();
    await appStore.localWeatherStore.getLocationAndWeatherData();
    if (!appStore.appErrors.contains(ErrorType.noStoragePermission)) {
      await appStore.weatherPresetsStore.fetchCityWeatherData();
    }
  }

  @override
  void initState() {
    super.initState();
    loadLocalData();

    Report.map(
      event: 'Открыт экран пресетов погоды',
      map: {
        'Количество пресетов': appStore.cityNamesStore.presetsCityNamesCount
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
        bottomNavigationBar: BotAppBarWidget(appStore: appStore),
      ),
    );
  }
}
