import 'package:flutter/material.dart';

class ThemeConfig {
  static late ThemeData _theme;
  static late TextTheme textTheme;

  void init(BuildContext context) {
    _theme = Theme.of(context);
    textTheme = _theme.textTheme;
  }
}