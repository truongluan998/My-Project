import 'package:flutter/material.dart';
import 'package:netflix_clone/const/constants.dart';

import 'netflix_clone_color.dart';

mixin NetflixCloneTheme {
  static ThemeData buildTheme() => ThemeData(
        scaffoldBackgroundColor: NetflixCloneColor.netflixCloneColor,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: DimensionConstant.ELEVATION_0),
        fontFamily: 'NetflixSans',
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 32,
            color: NetflixCloneColor.textWhiteColor,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
          headline2: TextStyle(
            fontSize: 26,
            color: NetflixCloneColor.textWhiteColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
          headline3: TextStyle(
            fontSize: 22,
            color: NetflixCloneColor.textWhiteColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
          headline4: TextStyle(
            fontSize: 20,
            color: NetflixCloneColor.netflixCloneColor,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
          bodyText1: TextStyle(
            fontSize: 17,
            color: NetflixCloneColor.textWhiteColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.1,
          ),
          bodyText2: TextStyle(
            fontSize: 18,
            color: NetflixCloneColor.textWhiteDarkColor,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.1,
          ),
          button: TextStyle(
            fontSize: 18,
            color: NetflixCloneColor.textWhiteColor,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.1,
          ),
          subtitle1: TextStyle(
            fontSize: 14,
            color: NetflixCloneColor.brownLightColor,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.1,
          ),
          subtitle2: TextStyle(
            fontSize: 13,
            color: NetflixCloneColor.brownLightColor,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.1,
          ),
        ),
      );
}
