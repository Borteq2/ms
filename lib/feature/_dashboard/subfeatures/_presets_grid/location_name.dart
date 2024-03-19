import 'package:flutter/material.dart';

import 'package:mordor_suit/feature/_dashboard/subfeatures/_presets_grid/_widgets.dart';

class PresetLocationName extends StatelessWidget {
  const PresetLocationName({
    super.key,
    required this.widget,
    required this.index,
  });

  final PresetsGridWidget widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Text(
        'Локация: ${widget.appStore.cityNamesStore.presetsCityNames[index]}',
        overflow: TextOverflow.ellipsis);
  }
}
