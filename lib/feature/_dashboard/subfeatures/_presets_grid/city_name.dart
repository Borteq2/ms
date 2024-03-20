import 'package:flutter/material.dart';
import 'package:mordor_suit/feature/_dashboard/subfeatures/_presets_grid/_widgets.dart';


class PresetCityName extends StatelessWidget {
  const PresetCityName({
    super.key,
    required this.widget,
    required this.index,
  });

  final PresetsGridWidget widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Text(
        '${widget.appStore.locationPresetsStore.presetCityWeatherData[index].name}',
        overflow: TextOverflow.ellipsis);
  }
}
