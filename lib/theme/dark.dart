import 'package:flutter/material.dart';

ThemeData mordorDarkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Colors.deepOrange,
    background: Colors.black54,
  ),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.transparent,
  ),
  cardTheme: const CardTheme(
    surfaceTintColor: Colors.black54,
    elevation: 24,
  ),
  useMaterial3: true,
);
