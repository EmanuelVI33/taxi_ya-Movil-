import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.indigo;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primary,

    // Scaffol
    scaffoldBackgroundColor: Colors.grey[300],
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: primary,
    ),

    // Floating
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.indigo,
      elevation: 0,
    ),

    // TextButton
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary),
    ),

    // Icon
    iconTheme: const IconThemeData(
      color: Colors.indigo,
    ),

    // ElevateButton
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      foregroundColor: primary,
      shape: const StadiumBorder(), // Border redondiados
      elevation: 0,
    )),
  );
}
