import 'package:flutter/material.dart';

class FinalPracticeColor {
  static const MaterialColor finalPracticeColor =
      MaterialColor(_finalpracticecolorPrimaryValue, <int, Color>{
        50: Color(0xFFE1F2F4),
        100: Color(0xFFB3DFE4),
        200: Color(0xFF81CAD2),
        300: Color(0xFF4EB4C0),
        400: Color(0xFF28A4B3),
        500: Color(_finalpracticecolorPrimaryValue),
        600: Color(0xFF028C9D),
        700: Color(0xFF018193),
        800: Color(0xFF01778A),
        900: Color(0xFF016579),
  });
  static const int _finalpracticecolorPrimaryValue = 0xFF0294A5;

  static const MaterialColor finalpracticecolorAccent =
      MaterialColor(_finalpracticecolorAccentValue, <int, Color>{
        100: Color(0xFFA7EDFF),
        200: Color(_finalpracticecolorAccentValue),
        400: Color(0xFF41D9FF),
        700: Color(0xFF27D4FF),
  });
  static const int _finalpracticecolorAccentValue = 0xFF74E3FF;

  static const Color orangeDarkColor = Color(0xFFE5481B);
  static const Color orangeLightColor = Color(0xFFFF671B);
  static const Color blueDarkColor = Color(0xFF25469B);
  static const Color labelColor = Color(0xFFA19D95);
  static const Color textBlackLightColor = Color(0xFF4A4A4A);
  static const Color textBlackColor = Color(0xFF151C26);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color brownLightColor = Color(0xFFF7F7F7);
  static const Color primaryButtonColor = Color(0xFF0294A5);
  static const Color backgroundScaffoldColor = Color(0xFFEEEEEE);
  static const Color backgroundSearchColor = Color(0xFFE5E5E5);
  static const Color searchIconColor = Color(0xFF98989C);
}
