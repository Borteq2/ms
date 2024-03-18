import 'package:flutter/material.dart';

import 'package:mordor_suit/feature/_dashboard/subfeatures/_presets_grid/_widgets.dart';
import 'package:mordor_suit/library/helpers/_helpers.dart';
import 'package:mordor_suit/store/_stores.dart';

class CorrectPresetInfoWidget extends StatelessWidget {
  const CorrectPresetInfoWidget({
    super.key,
    required this.widget,
    required this.index,
    required this.appStore,
  });

  final PresetsGridWidget widget;
  final int index;
  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        PresetLocationName(widget: widget, index: index),
        PresetCityName(widget: widget, index: index),
        IconHelper.getIconByWeather(
            widget.appStore.weatherPresetsStore.weather(index)),
        PresetWeatherDescriptionWidget(index: index, appStore: appStore),
        PresetTempWidget(widget: widget, index: index),
        PresetTempFeelsLikeWidget(widget: widget, index: index),
        PresetHumidityWidget(widget: widget, index: index),
        PresetWindWidget(widget: widget, index: index),
        const Spacer(),
      ],
    );
  }
}
