import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mordor_suit/feature/_dashboard/widgets/_widgets.dart';
import 'package:mordor_suit/feature/library/helpers/report.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:mordor_suit/store/local_weather_store.dart';

class FABMenuWidget extends StatelessWidget {
  const FABMenuWidget({
    super.key,
    required this.appStore,
  });

  final AppStore appStore;

  LocalWeatherStore get localWeatherStore => appStore.localWeatherStore;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
      ),
      child: PopupMenuButton(
        icon: SvgPicture.asset(
          'assets/images/favicon.svg',
          width: 40,
          height: 40,
        ),
        color: Colors.black.withOpacity(0.9),
        surfaceTintColor: Colors.transparent,
        offset: const Offset(-50, -125),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        itemBuilder: (context) {
          Report.map(
            event: 'Открыто меню FAB',
            map: {
              'Локальная погода получена': localWeatherStore.isWeatherLoaded &&
                  !localWeatherStore.isHasError
            },
          );

          return <PopupMenuItem>[
            PopupMenuItem(
              value: 1,
              onTap: () {
                Report.map(
                  event: 'Нажата кнопка создания локации по названию города',
                  map: {
                    'Локальная погода получена':
                        localWeatherStore.isWeatherLoaded &&
                            !localWeatherStore.isHasError
                  },
                );

                showDialog(
                    context: context,
                    builder: (context) => AddPresetModal(appStore: appStore));
              },
              child: const Text(
                'Добавить город',
                style: TextStyle(color: Colors.deepOrange),
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: CustomPopupMenuItem(appStore: appStore),
            ),
          ];
        },
      ),
    );
  }
}
