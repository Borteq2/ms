import 'package:app_settings/app_settings.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mordor_suit/enums/_enums.dart';
import 'package:mordor_suit/feature/_dashboard/subfeatures/_bot_app_bar/_widgets.dart';

import 'package:mordor_suit/store/_stores.dart';

class BotAppBarWidget extends StatelessWidget {
  const BotAppBarWidget({
    super.key,
    required this.appStore,
  });

  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BottomAppBar(
          elevation: 20,
          surfaceTintColor:
              Theme.of(context).bottomAppBarTheme.surfaceTintColor,
          shape: const CircularNotchedRectangle(),
          height: 64,
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (appStore.appErrors
                          .contains(ErrorType.noLocationPermissionTemporary) &&
                      !appStore.appErrors
                          .contains(ErrorType.noLocationPermissionForever))
                  ? IconButton(
                      icon: const Icon(
                        Icons.warning_amber_outlined,
                        color: Colors.green,
                      ),
                      onPressed: () =>
                          ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const AutoSizeText(
                            'Нужно разрешение',
                            maxLines: 1,
                          ),
                          action: SnackBarAction(
                            label: 'Настройки',
                            textColor: Colors.deepOrange,
                            onPressed: () => AppSettings.openAppSettings(
                                type: AppSettingsType.settings),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              appStore.appErrors.contains(ErrorType.noLocationPermissionForever)
                  ? IconButton(
                      icon: const Icon(
                        Icons.warning_amber_outlined,
                        color: Colors.yellow,
                      ),
                      onPressed: () =>
                          ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              const Expanded(
                                child: AutoSizeText(
                                    'Нужно разрешение на геолокацию в настройках',
                                    maxLines: 2),
                              ),
                              IconButton(
                                  onPressed: () => AppSettings.openAppSettings(
                                      type: AppSettingsType.settings),
                                  color: Theme.of(context).primaryColor,
                                  icon: const Icon(Icons.settings))
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              appStore.appErrors.contains(ErrorType.geoServiceDisabled)
                  ? IconButton(
                      icon: const Icon(
                        Icons.warning_amber_outlined,
                        color: Colors.red,
                      ),
                      onPressed: () =>
                          ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              const Expanded(
                                child: AutoSizeText(
                                    'Включите службу геолокации',
                                    maxLines: 2),
                              ),
                              IconButton(
                                  onPressed: () => AppSettings.openAppSettings(
                                      type: AppSettingsType.location),
                                  color: Theme.of(context).primaryColor,
                                  icon: const Icon(Icons.settings))
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              if (appStore.centerLocations.contains(appStore.fabLocation))
                const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
