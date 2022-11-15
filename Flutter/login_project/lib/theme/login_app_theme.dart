import 'package:flutter/material.dart';
import 'package:login_project/constants/constants.dart';
import 'package:login_project/theme/login_app_color.dart';

class LoginAppTheme {
  static ThemeData buildTheme() => ThemeData(
        scaffoldBackgroundColor: LoginAppColor.whiteColor,
        fontFamily: 'IBMPlexSans',
        textTheme: const TextTheme(
          headline2: TextStyle(
              fontSize: Dimens.size40,
              color: LoginAppColor.textLightBlackColor,
              fontWeight: FontWeight.w400),
          headline3: TextStyle(
              fontSize: Dimens.size36,
              color: LoginAppColor.blackColor,
              fontWeight: FontWeight.w600),
          headline6: TextStyle(
              fontSize: Dimens.size16,
              color: LoginAppColor.hintTextColor,
              fontWeight: FontWeight.w400),
          bodyText1: TextStyle(
              fontSize: Dimens.size16,
              color: LoginAppColor.textBlackColor,
              fontWeight: FontWeight.w400),
          bodyText2: TextStyle(
              fontSize: Dimens.size14,
              color: LoginAppColor.textGrayColor,
              fontWeight: FontWeight.w400),
          subtitle1: TextStyle(
              fontSize: Dimens.size17,
              color: LoginAppColor.hintTextColor,
              fontWeight: FontWeight.w400),
          subtitle2: TextStyle(
              fontSize: Dimens.size12,
              color: LoginAppColor.blackColor,
              fontWeight: FontWeight.w700),
        ),
        inputDecorationTheme: _buildInputDecorationTheme(),
      );

  static InputDecorationTheme _buildInputDecorationTheme() =>
      InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: LoginAppColor.textFormFieldBorder,
          ),
          borderRadius: BorderRadius.circular(Dimens.size10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: LoginAppColor.textFormFieldBorder,
          ),
          borderRadius: BorderRadius.circular(Dimens.size10),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: LoginAppColor.textFormFieldBorder,
          ),
          borderRadius: BorderRadius.circular(Dimens.size10),
        ),
      );
}
