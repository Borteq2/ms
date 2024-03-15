
import 'package:flutter/material.dart';
import 'package:mordor_suit/feature/_presets_grid/_widgets.dart';

class ErrorPresetInfoWidget extends StatelessWidget {
  const ErrorPresetInfoWidget({
    super.key,
    required this.widget,
    required this.index,
  });

  final PresetsGridWidget widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        const Text('Ошибка загрузки'),
        Text(
          'Город ${widget.appStore.weatherPresetsStore.cityNamesStore.presetsCityNames[index]} не найден',
          maxLines: 5,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}