import 'package:flutter/material.dart';

class NetflixCloneColor {
  static const MaterialColor netflixCloneColor =
      MaterialColor(_netflixCloneColorPrimaryValue, <int, Color>{
    50: Color(0xFFE0E0E0),
    100: Color(0xFFB3B3B3),
    200: Color(0xFF808080),
    300: Color(0xFF4D4D4D),
    400: Color(0xFF262626),
    500: Color(_netflixCloneColorPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  });
  static const int _netflixCloneColorPrimaryValue = 0xFF000000;

  static const MaterialColor netflixCloneColorAccent =
      MaterialColor(_netflixCloneColorAccentValue, <int, Color>{
    100: Color(0xFFA6A6A6),
    200: Color(_netflixCloneColorAccentValue),
    400: Color(0xFF737373),
    700: Color(0xFF666666),
  });
  static const int _netflixCloneColorAccentValue = 0xFF8C8C8C;

  static const Color redColor = Color(0xFFF40612);
  static const Color backgroundBottomSheetColor = Color(0xFF181818);
  static const Color brownLightColor = Color(0xFF757575);
  static const Color textWhiteDarkColor = Color(0xFFE0E0E0);
  static const Color brownColor = Color(0xFF666666);
  static const Color textWhiteColor = Color(0xFFFFFFFF);
}
