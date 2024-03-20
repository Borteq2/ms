import 'package:flutter/material.dart';

import 'package:mordor_suit/library/helpers/_helpers.dart';
import 'package:mordor_suit/store/_stores.dart';

class PresetWeatherDescriptionWidget extends StatelessWidget {
  const PresetWeatherDescriptionWidget({
    super.key,
    required this.index,
    required this.appStore,
  });

  final int index;
  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    return Text(
      StringHelper.capitalizeFirstSymbol(
              appStore.locationPresetsStore.description(index)) ??
          '',
      overflow: TextOverflow.ellipsis,
    );
  }
}
