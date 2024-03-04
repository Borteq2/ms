import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';







// class TimestampService {
//   static const String timestampKey = 'timestamp';
//
//
//   static Future<DateTime?> getTimestamp() async {
//     Talker talker = GetIt.I<Talker>();
//     final Box box = GetIt.I<Box<DateTime>>(instanceName: 'timestamps_box');
//
//
//     final DateTime? stamp = await box.get(0);
//     // talker.info(stamp);
//     // await box.close();
//
//     if (stamp != null) {
//       talker.info('достал штамп $stamp');
//       return stamp;
//     }
//     talker.critical('обосрался, штамп $stamp');
//     throw Exception();
//   }
//
//   static Future<void> saveTimestamp(DateTime timestamp) async {
//     Talker talker = GetIt.I<Talker>();
//       final Box box = GetIt.I<Box<DateTime>>(instanceName: 'timestamps_box');
//
//     // talker.warning(box.keys);
//     talker.warning(box.values);
//
//     talker.info('пытаюсь сохранить штамп $timestamp');
//
//     await box.putAt(0, timestamp);
//     // await box.close();
//   }
// }
