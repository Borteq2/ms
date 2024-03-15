import 'package:flutter/material.dart';
import 'package:mordor_suit/feature/_presets_grid/_widgets.dart';

class PresetTempFeelsLikeWidget extends StatelessWidget {
  const PresetTempFeelsLikeWidget({
    super.key,
    required this.widget,
    required this.index,
  });

  final PresetsGridWidget widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Text(
        'Ощущается как: ${widget.appStore.weatherPresetsStore.feelsLike(index)}°С',
        overflow: TextOverflow.ellipsis);
  }
}