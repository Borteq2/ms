import 'package:flutter/material.dart';
import 'package:mordor_suit/store/_stores.dart';

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