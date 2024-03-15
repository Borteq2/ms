import 'package:flutter/material.dart';
import 'package:mordor_suit/feature/_presets_grid/_widgets.dart';

class PresetWindWidget extends StatelessWidget {
  const PresetWindWidget({
    super.key,
    required this.widget,
    required this.index,
  });

  final PresetsGridWidget widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Text('Ветер: ${widget.appStore.weatherPresetsStore.wind(index)} м/с',
        overflow: TextOverflow.ellipsis);
  }
}
