import 'package:flutter/material.dart';

import 'package:mordor_suit/feature/_dashboard/subfeatures/_presets_grid/_widgets.dart';

class PresetTempWidget extends StatelessWidget {
  const PresetTempWidget({
    super.key,
    required this.widget,
    required this.index,
  });

  final PresetsGridWidget widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Text(
        'Температура: ${widget.appStore.locationPresetsStore.baseTemp(index)}°С',
        overflow: TextOverflow.ellipsis);
  }
}