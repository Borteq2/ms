import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:mordor_suit/store/_stores.dart';

import 'package:mordor_suit/app.dart';
import 'package:mordor_suit/feature/dashboard/dashboard_screen.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await dotenv.load(fileName: "lib/.env");

    // await SentryFlutter.init(
    //       (options) {
    //     options.dsn = 'https://example@sentry.io/add-your-dsn-here';
    //   },
    // );

    final talker = Talker();
    final dio = Dio();
    dio.interceptors.add(
      TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(printResponseData: false),
      ),
    );

    GetIt.I.registerSingleton(talker);
    GetIt.I.registerSingleton(dio);
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
                  return const Placeholder();
                },
              ),
            ],
          )
        ],
      ),
    );

    // FlutterError.onError =
    //     (details) => GetIt.I<Talker>().handle(details.exception);

    runApp(const MyApp());
  }, (exception, stack) async {
    await Sentry.captureException(exception, stackTrace: stack);
  });
}
