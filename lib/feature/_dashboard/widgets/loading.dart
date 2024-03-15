import 'package:flutter/material.dart';
import 'package:mordor_suit/store/_stores.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    required this.appStore,
  });

  final AppStore appStore;

  CurrentWeatherStore get currentWeatherStore => appStore.currentWeatherStore;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          const Center(child: CircularProgressIndicator()),
          currentWeatherStore.geoPermission
              ? const SizedBox.shrink()
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Разрешение на геолокацию'),
                      IconButton(
                        iconSize: 24,
                        tooltip: 'Доступ к геолокации',
                        onPressed: () => appStore.goToAppSettings(),
                        icon: const Icon(Icons.settings),
                        color: Colors.deepOrange,
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
