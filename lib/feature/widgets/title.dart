import 'package:flutter/material.dart';
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
        Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                appStore.weatherStore.city,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: _getIconByWeather(),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                appStore.weatherStore.temperature == 999
                    ? ''
                    : '${appStore.weatherStore.temperature}°C',
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Align(alignment: Alignment.topLeft, child: Text('${appStore
                .weatherStore.weatherDataMap['wind']['speed']} м/с'),
            ),
            Align(alignment: Alignment.center,
              child: Text(appStore.weatherStore.weather),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text('≈${appStore
                  .weatherStore.weatherDataMap['main']['feels_like']}°C'),
            ),
          ],
        ),
      ],
    );
  }

  Icon _getIconByWeather() =>
      appStore.weatherStore.weatherDataMap['weather'][0]['main'] == 'Clear'
          ? const Icon(Icons.sunny)
          : appStore.weatherStore.weatherDataMap['weather'][0]['main'] == 'Clouds'
          ? const Icon(Icons.cloud)
          : appStore.weatherStore.weatherDataMap['weather'][0]['main'] == 'Rain'
          ? const Icon(Icons.water_drop)
          : appStore.weatherStore.weatherDataMap['weather'][0]['main'] == 'Snow'
          ? const Icon(Icons.cloudy_snowing)
          : appStore.weatherStore.weatherDataMap['weather'][0]['main'] == 'Thunderstorm'
          ? const Icon(Icons.thunderstorm)
          : appStore.weatherStore.weatherDataMap['weather'][0]['main'] == 'Mist'
          ? const Icon(Icons.waves)
          :appStore.weatherStore.weatherDataMap['weather'][0]['main'] == 'Haze'
          ? const Icon(Icons.waves)
          : appStore.weatherStore.weatherDataMap['weather'][0]['main'] == 'Sleet'
          ? const Icon(Icons.snowing)
          : appStore.weatherStore.weatherDataMap['weather'][0]['main'] == 'Freezing rain'
          ? const Icon(Icons.cloudy_snowing)
          : const Icon(Icons.question_mark);
}
