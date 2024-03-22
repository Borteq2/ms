import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/foundation.dart';

class Report {
  static Future<void> event({int? index, required String event}) async =>
      AppMetrica.reportEvent(event);

  static Future<void> map({
    int? index,
    required String event,
    required Map<String, Object> map,
  }) async =>
      kReleaseMode ? AppMetrica.reportEventWithMap(event, map) : null;

  static void error({
    required String message,
    required String descriptionMessage,
    required String type,
  }) =>
      kReleaseMode
          ? AppMetrica.reportError(
              message: message,
              errorDescription:
                  AppMetricaErrorDescription.fromCurrentStackTrace(
                message: descriptionMessage,
                type: type,
              ),
            ).ignore()
          : null;
}
