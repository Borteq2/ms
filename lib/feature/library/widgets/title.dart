import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mordor_suit/store/_stores.dart';

// enum WeatherTypes {
//   clear,
//   clouds,
//   rain,
//   snow,
//   thunderstorm,
//   mist,
//   haze,
//   sleet,
//   freezingRain,
//   dust,
//   sand,
//   ash,
//   volcanicAsh,
// }

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.appStore,
  });

  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                WeatherDetailWidget(appStore: appStore),
                TitleCityNameWidget(appStore: appStore),
              ],
            ),
            TitleIconWidget(appStore: appStore),
            TitleTemperatureWidget(appStore: appStore),
          ],
        ),
      ],
    );
  }
}

class TitleTemperatureWidget extends StatelessWidget {
  const TitleTemperatureWidget({
    super.key,
    required this.appStore,
  });

  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => appStore.currentWeatherStore.isWeatherLoaded
          ? Text('${appStore.currentWeatherStore.temperature.toString()}°C')
          : SizedBox.shrink(),
    );
  }
}

class TitleCityNameWidget extends StatelessWidget {
  const TitleCityNameWidget({
    super.key,
    required this.appStore,
  });

  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Text(
          appStore.currentWeatherStore.city,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class TitleIconWidget extends StatelessWidget {
  const TitleIconWidget({
    super.key,
    required this.appStore,
  });

  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => appStore.currentWeatherStore.weatherIcon,
    );
  }
}

class WeatherDetailWidget extends StatelessWidget {
  const WeatherDetailWidget({
    super.key,
    required this.appStore,
  });

  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => appStore.currentWeatherStore.isWeatherLoaded
          ? PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              icon: const Icon(Icons.list),
              offset: const Offset(-100, 50),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Обновлено: ${appStore.time}'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ощущается как: ${appStore.currentWeatherStore.feelsLikeTemp}',
                        ),
                      ],
                    ),
                  ),
                ];
              },
            )
          : const CircularProgressIndicator(),
    );
  }
}
