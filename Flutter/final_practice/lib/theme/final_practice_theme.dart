import 'package:flutter/material.dart';

import 'final_practice_color.dart';

mixin FinalPracticeTheme {
  static ThemeData buildTheme() => ThemeData(
        scaffoldBackgroundColor: FinalPracticeColor.whiteColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: FinalPracticeColor.whiteColor,
          elevation: 0,
        ),
        fontFamily: 'SFProText',
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 36,
            color: FinalPracticeColor.whiteColor,
          ),
          headline3: TextStyle(
            fontSize: 28,
            color: FinalPracticeColor.whiteColor,
          ),
          bodyText1: TextStyle(
            fontSize: 20,
            color: FinalPracticeColor.textBlackLightColor,
          ),
          bodyText2: TextStyle(
            fontSize: 14,
            color: FinalPracticeColor.textBlackLightColor,
          ),
          subtitle1: TextStyle(
            fontSize: 20,
            color: FinalPracticeColor.whiteColor,
          ),
          subtitle2: TextStyle(
            fontSize: 15,
            color: FinalPracticeColor.labelColor,
          ),
          button: TextStyle(
            fontSize: 20,
            color: FinalPracticeColor.whiteColor,
          ),
        ),
      );
}
