import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mordor_suit/feature/widgets/_widgets.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:talker_flutter/talker_flutter.dart';

class PresetsGridWidget extends StatelessWidget {
  const PresetsGridWidget({
    super.key,
    required this.appStore,
  });

  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        children: [
          Text('Данные обновлены: ${appStore.weatherStore.timestamp}'),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: appStore.weatherPresetsStore.presetsCityNamesCount,
              itemBuilder: (context, index) => FutureBuilder(
                  future: appStore.weatherPresetsStore.fetchWeatherByCity(
                      appStore.weatherPresetsStore.presetsCityNames[index]),
                  builder: (context, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                      ? const Center(child: CircularProgressIndicator())
                      : GestureDetector(
                    onLongPress: () =>
                        appStore.weatherPresetsStore.removePreset(index),
                    onTap: () => context.go('/set',
                        extra: appStore.weatherPresetsStore
                            .presetCityWeatherData[index]),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              appStore.weatherPresetsStore.presetsCityNames[index],
                              overflow: TextOverflow.ellipsis),
                          appStore.weatherStore.getIconByWeather(appStore
                              .weatherPresetsStore
                              .presetCityWeatherData[index]['weather']
                          [0]['main']),
                          Text(appStore.weatherPresetsStore
                              .presetCityWeatherData[index]['weather']
                          [0]['description']),
                          Text(
                              '${appStore.weatherPresetsStore.presetCityWeatherData[index]['main']['temp']}°C'),
                          Text(
                              'Ощущается как ${appStore.weatherPresetsStore.presetCityWeatherData[index]['main']['feels_like']}°C'),
                          Text(
                              'Влажность ${appStore.weatherPresetsStore.presetCityWeatherData[index]['main']['humidity']}%'),
                          Text(
                              'Ветер ${appStore.weatherPresetsStore.presetCityWeatherData[index]['wind']['speed']} м/с'),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}