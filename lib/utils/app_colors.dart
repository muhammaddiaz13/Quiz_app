import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color deepSpaceBlue = Color(0xFF080B24);
  static const Color starlightWhite = Color(0xFFF4F2FF);
  static const Color nebulaPurple = Color(0xFF8B5CF6);
  static const Color cosmicBlue = Color(0xFF263A72);
  static const Color daylightInk = Color(0xFF172554);
  static const Color daylightSky = Color(0xFFF1F5FF);

  static final ColorScheme darkScheme = ColorScheme.fromSeed(
    seedColor: nebulaPurple,
    brightness: Brightness.dark,
  ).copyWith(
    primary: nebulaPurple,
    onPrimary: starlightWhite,
    secondary: starlightWhite,
    surface: deepSpaceBlue,
    onSurface: starlightWhite,
    surfaceContainerHighest: cosmicBlue,
  );

  static final ColorScheme lightScheme = ColorScheme.fromSeed(
    seedColor: cosmicBlue,
    brightness: Brightness.light,
  ).copyWith(
    primary: nebulaPurple,
    onPrimary: starlightWhite,
    secondary: cosmicBlue,
    surface: starlightWhite,
    onSurface: daylightInk,
    surfaceContainerHighest: daylightSky,
  );
}
