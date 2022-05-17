import 'package:flutter/material.dart';

ColorScheme _colorScheme = ColorScheme(
    primary: Colors.green.shade900,
    secondary: Colors.blueAccent.shade700,
    background: Colors.grey,
    surface: Colors.grey,
    onBackground: Colors.white,
    error: Colors.redAccent,
    onError: Colors.redAccent,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.grey.shade800,
    brightness: Brightness.light,
);

ThemeData defaultTheme = ThemeData(
    colorScheme: _colorScheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: _colorScheme.secondary,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: _colorScheme.secondary,
      ),
    ),
);
