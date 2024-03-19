import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
              if (appStore.centerLocations.contains(appStore.fabLocation))
                const Spacer(),
              // appStore.isHasPermissionErrors ||
              //         appStore.localWeatherStore.isHasError
              //     ? const OpenAppSettingsWidget()
              //     : const SizedBox.shrink(),
              // appStore.isHasPermissionErrors || appStore.localWeatherStore.isHasError
              //     ? const TalkerScreenWidget()
              //     : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
