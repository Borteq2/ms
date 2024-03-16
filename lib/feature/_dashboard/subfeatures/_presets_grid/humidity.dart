import 'package:flutter/material.dart';

import 'package:mordor_suit/feature/_dashboard/subfeatures/_presets_grid/_widgets.dart';

class PresetHumidityWidget extends StatelessWidget {
  const PresetHumidityWidget({
    super.key,
    required this.widget,
    required this.index,
  });

  final PresetsGridWidget widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Text(
        'Влажность: ${widget.appStore.weatherPresetsStore.humidity(index)}%',
        overflow: TextOverflow.ellipsis);
  }
}