import 'package:app_settings/app_settings.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mordor_suit/enums/_enums.dart';

import 'package:mordor_suit/store/_stores.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.appStore,
  });

  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    print(appStore.appErrors);
    return Observer(
      builder: (_) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  !appStore.hasLocationErrors
                      ? WeatherDetailWidget(appStore: appStore)
                      : TryRefreshWidget(appStore: appStore),
                  TitleCityNameWidget(appStore: appStore),
                ],
              ),
              !appStore.hasLocationErrors &&
                      appStore.localWeatherStore.isWeatherLoaded
                  ? TitleIconWidget(appStore: appStore)
                  : const SizedBox.shrink(),
              !appStore.hasLocationErrors
                  ? TitleTemperatureWidget(appStore: appStore)
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}

class TryRefreshWidget extends StatelessWidget {
  const TryRefreshWidget({
    super.key,
    required this.appStore,
  });

  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => appStore.appErrors.contains(ErrorType.geoServiceDisabled)
          ? IconButton(
              onPressed: () =>
                  AppSettings.openAppSettings(type: AppSettingsType.location),
              icon: const Icon(
                Icons.warning_amber_outlined,
                color: Colors.red,
              ))
          : appStore.appErrors.contains(ErrorType.noLocationPermissionForever)
              ? IconButton(
                  onPressed: () => AppSettings.openAppSettings(
                      type: AppSettingsType.settings),
                  icon: const Icon(
                    Icons.warning_amber_outlined,
                    color: Colors.yellow,
                  ))
              : (appStore.appErrors
                          .contains(ErrorType.noLocationPermissionTemporary) &&
                      !appStore.appErrors
                          .contains(ErrorType.noLocationPermissionForever))
                  ? IconButton(
                      onPressed: () => AppSettings.openAppSettings(
                          type: AppSettingsType.settings),
                      icon: const Icon(
                        Icons.warning_amber_outlined,
                        color: Colors.green,
                      ))
                  : IconButton(
                      onPressed: () => appStore.localWeatherStore
                          .getLocationAndWeatherData(),
                      icon: const Icon(Icons.refresh),
                    ),
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
      builder: (_) => !appStore.hasLocationErrors &&
              appStore.localWeatherStore.isWeatherLoaded
          ? PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.black.withOpacity(0.9),
              surfaceTintColor: Colors.transparent,
              icon: const Icon(Icons.list),
              offset: const Offset(-100, 50),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Обновлено: ${appStore.timestampStore.time}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Ощущается как: ${appStore.localWeatherStore.feelsLikeTemp} °С',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                            'Влажность: ${appStore.localWeatherStore.localWeatherDataMap['main']['humidity']}%',
                            style: const TextStyle(fontSize: 20),
                            overflow: TextOverflow.ellipsis),
                        Text(
                            'Ветер: ${appStore.localWeatherStore.localWeatherDataMap['wind']['speed']} м/с',
                            style: const TextStyle(fontSize: 20),
                            overflow: TextOverflow.ellipsis),
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

class TitleCityNameWidget extends StatelessWidget {
  const TitleCityNameWidget({
    super.key,
    required this.appStore,
  });

  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => !appStore.hasLocationErrors
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: AutoSizeText(
                appStore.localWeatherStore.city,
                maxLines: 1,
              ),
            )
          : SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: AutoSizeText(
                appStore.appErrors.contains(ErrorType.geoServiceDisabled)
                    ? 'Геолокация отключена'
                    : 'Не могу определить местоположение',
                maxLines: 1,
              ),
            ),
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
      builder: (_) => appStore.localWeatherStore.isWeatherLoaded
          ? Text('${appStore.localWeatherStore.temperature.toString()}°C')
          : const SizedBox.shrink(),
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
      builder: (_) => appStore.localWeatherStore.weatherIcon,
    );
  }
}
