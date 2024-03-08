import 'package:flutter/material.dart';

ThemeData mordorDarkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Colors.deepOrange,
    background: Colors.black54,
  ),
  primaryColor: Colors.deepOrange,
  disabledColor: Colors.grey,
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.transparent,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Colors.transparent,
    surfaceTintColor: Colors.grey,
  ),
  cardTheme: const CardTheme(
    surfaceTintColor: Colors.black54,
    elevation: 24,
  ),
  dialogTheme: const DialogTheme(
      // backgroundColor: Colors.black,
      // surfaceTintColor: Colors.black,
      ),
  useMaterial3: true,
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.grey),
    ),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Colors.grey),
    titleMedium: TextStyle(color: Colors.grey),
    titleSmall: TextStyle(color: Colors.grey),
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    displayLarge: TextStyle(color: Colors.grey),
    displayMedium: TextStyle(color: Colors.grey),
    displaySmall: TextStyle(color: Colors.grey),
  ),
);
