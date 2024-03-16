import 'package:flutter/material.dart';

import 'package:mordor_suit/feature/_dashboard/subfeatures/_presets_grid/_widgets.dart';
import 'package:mordor_suit/feature/library/helpers/_helpers.dart';
import 'package:mordor_suit/store/_stores.dart';

class RemovePresetInfoWidget extends StatelessWidget {
  const RemovePresetInfoWidget({
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
    return Center(
      child: IconButton(
        iconSize: 40,
        onPressed: () {
          Report.map(
            event: 'Удаление пресета',
            map: {
              widget.appStore.weatherPresetsStore.cityNamesStore
                      .presetsCityNames[index]:
                  '${widget.appStore.weatherPresetsStore.presetCityWeatherData[index]}'
            },
          );
          appStore.weatherPresetsStore.removePreset(index);
        },
        icon: const Icon(Icons.delete_forever),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
