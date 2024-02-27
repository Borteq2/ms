import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mordor_suit/feature/home.dart';
import 'package:mordor_suit/store/_stores.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "lib/.env");

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
      observers: [TalkerRouteObserver(GetIt.I<Talker>())],
      routes: [
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const MyHomePage(title: '');
          },
        )
      ],
    ),
  );

  // FlutterError.onError =
  //     (details) => GetIt.I<Talker>().handle(details.exception);

  runApp(const MyApp());
  // runZonedGuarded(() async {
  //
  //   WidgetsFlutterBinding.ensureInitialized();
  //
  //   await dotenv.load(fileName: "lib/.env");
  //
  //   final talker = Talker();
  //   final dio = Dio();
  //   dio.interceptors.add(
  //     TalkerDioLogger(
  //       talker: talker,
  //       settings: const TalkerDioLoggerSettings(printResponseData: false),
  //     ),
  //   );
  //
  //   GetIt.I.registerSingleton(talker);
  //   GetIt.I.registerSingleton(dio);
  //   GetIt.I.registerSingleton(AppStore());
  //   GetIt.I.registerSingleton(
  //     GoRouter(
  //       observers: [TalkerRouteObserver(GetIt.I<Talker>())],
  //       routes: [
  //         GoRoute(
  //           path: '/',
  //           builder: (BuildContext context, GoRouterState state) {
  //             return const MyHomePage(title: '');
  //           },
  //         )
  //       ],
  //     ),
  //   );
  //
  //   FlutterError.onError =
  //       (details) => GetIt.I<Talker>().handle(details.exception);
  //
  //   runApp(const MyApp());
  // }, (error, stack) => GetIt.I<Talker>().handle(error, stack));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GetIt.I<GoRouter>(),
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(primary: Colors.deepOrange),
        useMaterial3: true,
      ),
    );
  }
}
