import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

class OpenAppSettingsWidget extends StatelessWidget {
  const OpenAppSettingsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        AppSettings.openAppSettings(type: AppSettingsType.location);
      },
      tooltip: '',
      icon: const Icon(Icons.settings, size: 28),
    );
  }
}