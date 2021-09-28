
import 'dart:ui';
import 'package:flutter/material.dart';

const primaryColor = Color(0xFF473F97);
const secondaryColor = Color(0xFFE5E5E5);
const contentColorLightTheme = Color(0xFF1D1D35);
const contentColorDarkTheme = Color(0xFFF5FCF9);

const defaultPadding = 16.0;

Text buildTitle(String title, Color color) {
  return Text(
    title,
    style: TextStyle(
        color: color, fontSize: 18, fontWeight: FontWeight.w600),
  );
}
