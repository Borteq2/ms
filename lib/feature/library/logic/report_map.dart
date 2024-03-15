import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/foundation.dart';

class Report {
  static Future<void> map(
    int index,
    String event,
    Map<String, Object> map,
  ) async {
    kReleaseMode ? AppMetrica.reportEventWithMap(event, map) : null;
  }
}
