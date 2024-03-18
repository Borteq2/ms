import 'package:flutter/material.dart';

import 'package:mordor_suit/library/helpers/report.dart';
import 'package:mordor_suit/store/_stores.dart';

class MenuDashboardWidget extends StatelessWidget {
  const MenuDashboardWidget({
    super.key,
    required this.appStore,
  });

  final AppStore appStore;
  TimestampStore get timestampStore => appStore.timestampStore;

  @override
  Widget build(BuildContext context) {
    Report.event(event: 'Открыто меню деталей локальной погоды');

    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      icon: const Icon(Icons.list),
      offset: const Offset(-100, 50),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Обновлено: ${appStore.timestampStore.cachedTimestamp}'),
              ],
            ),
          ),
          PopupMenuItem(
            value: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ощущается как: ${appStore.localWeatherStore.feelsLikeTemp}',
                ),
              ],
            ),
          ),
        ];
      },
    );
  }
}
