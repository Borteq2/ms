import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:mordor_suit/app.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:mordor_suit/models/_models.dart';

import 'package:mordor_suit/feature/_set/set_screen.dart';
import 'package:mordor_suit/feature/_dashboard/dashboard_screen.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await dotenv.load(fileName: "lib/.env");
    await Hive.initFlutter();

    Hive.registerAdapter(ClothingAdapter());
    Hive.registerAdapter(AccessoryAdapter());

    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    final clothingBox = await Hive.openBox<Clothing>('clothing_box');
    final accessoryBox = await Hive.openBox<Accessory>('accessory_box');
    final cityNamesBox = await Hive.openBox<String>('city_names_box');
    final timeStampsBox = await Hive.openBox<DateTime>('timestamps_box');

    Hive.init(appDocumentDir.path);

    final talker = Talker();
    final dio = Dio();
    dio.interceptors.add(TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(printResponseData: false),
    ));

    GetIt.I.registerSingleton(talker);
    GetIt.I.registerSingleton(dio);
    GetIt.I.registerSingleton(clothingBox, instanceName: 'clothing_box');
    GetIt.I.registerSingleton(accessoryBox, instanceName: 'accessory_box');
    GetIt.I.registerSingleton(cityNamesBox, instanceName: 'city_names_box');
    GetIt.I.registerSingleton(timeStampsBox, instanceName: 'timestamps_box');
    GetIt.I.registerSingleton(AppStore());
    GetIt.I.registerSingleton(
      GoRouter(
        observers: [
          TalkerRouteObserver(GetIt.I<Talker>()),
          SentryNavigatorObserver(),
        ],
        routes: [
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return const DashboardScreen();
            },
            routes: [
              GoRoute(
                path: 'set',
                builder: (BuildContext context, GoRouterState state) {
                  return const SetScreen();
                },
              ),
            ],
          )
        ],
      ),
    );

    // await SentryFlutter.init(
    //   (options) {
    //     options.dsn =
    //         'https://23755c9480e743f8a853ddb54b4a93c2@sentry.mateline.ru/6';
    //     options.tracesSampleRate = 1.0;
    //   },
    //   appRunner: () =>
          runApp(const MyApp());
    // ,
    // );

    // try {
    //   throw Exception('тест 2');
    // } catch (e, st) {
    //   talker.critical('швыряю в сентрю');
    //   await Sentry.captureException(
    //     e,
    //     stackTrace: st,
    //   );
    // }

  }, (exception, stack) async {
    // await Sentry.captureException(exception, stackTrace: stack);
    GetIt.I<Talker>().handle(exception, stack);
  });
}
