import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          surfaceTintColor: Colors.transparent,
          title: TitleWidget(appStore: appStore),
        ),
        body: appStore.weatherStore.city.isEmpty
            ? LoadingWidget(appStore: appStore)
            : PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: appStore.suitStore.equipCount,
                itemBuilder: (context, index) => Center(
                    child: Text(appStore.suitStore.equipList[index].name)),
              ),
        floatingActionButton: appStore.weatherStore.city.toString().isEmpty
            ? const SizedBox.shrink()
            : FloatingActionButton(
                onPressed: () => appStore.suitStore.setSuitByTemperatureType(),
                tooltip: 'Что надеть?',
                child: const Icon(Icons.add),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.appStore,
  });

  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appStore.weatherStore.city,
        ),
        Text(appStore.weatherStore.weather),
        Text(
          (appStore.weatherStore.temperature == 999)
              ? ''
              : '${appStore.weatherStore.temperature}°C',
        )
      ],
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    required this.appStore,
  });

  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          const Center(child: CircularProgressIndicator()),
          appStore.weatherStore.geoPermission
              ? const SizedBox.shrink()
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Разрешение на геолокацию'),
                      IconButton(
                        iconSize: 24,
                        tooltip: 'Доступ к геолокации',
                        onPressed: () => appStore.goToAppSettings(),
                        icon: const Icon(Icons.settings),
                        color: Colors.deepOrange,
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
