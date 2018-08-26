import 'dart:ui';

import 'package:flutter/material.dart';

class TextStyleFactory {
  static TextStyle h4({color: ColorConfig.FONT_PRIMARY}) => TextStyle(
      color: color, fontWeight: FontWeightConfig.REGULAR, fontSize: 34.0);

  static TextStyle h5({color: ColorConfig.FONT_PRIMARY}) => TextStyle(
      color: color, fontWeight: FontWeightConfig.MEDIUM, fontSize: 24.0);

  static TextStyle h6({color: ColorConfig.FONT_PRIMARY}) => TextStyle(
      color: color, fontWeight: FontWeightConfig.MEDIUM, fontSize: 20.0);

  static TextStyle subtitle1({color: ColorConfig.FONT_PRIMARY}) => TextStyle(
      color: color, fontWeight: FontWeightConfig.MEDIUM, fontSize: 16.0);

  static TextStyle subtitle2({color: ColorConfig.FONT_PRIMARY}) => TextStyle(
      color: color, fontWeight: FontWeightConfig.MEDIUM, fontSize: 14.0);

  static TextStyle body1({color: ColorConfig.FONT_PRIMARY}) => TextStyle(
      color: color, fontWeight: FontWeightConfig.REGULAR, fontSize: 16.0);

  static TextStyle body2({color: ColorConfig.FONT_PRIMARY}) => TextStyle(
      color: color, fontWeight: FontWeightConfig.REGULAR, fontSize: 14.0);

  static TextStyle button({color: ColorConfig.FONT_PRIMARY}) => TextStyle(
      color: ColorConfig.FONT_PRIMARY,
      fontWeight: FontWeightConfig.MEDIUM,
      fontSize: 14.0);

  static TextStyle caption({color: ColorConfig.FONT_PRIMARY}) => TextStyle(
      color: color, fontWeight: FontWeightConfig.REGULAR, fontSize: 12.0);

  static TextStyle overline({color: ColorConfig.FONT_PRIMARY}) => TextStyle(
      color: color, fontWeight: FontWeightConfig.REGULAR, fontSize: 14.0);
}

class FontSizeConfig {
  static const NORMAL = 14.0;
  static const MEDIUM = 16.0;
  static const LARGE = 18.0;
}

class FontWeightConfig {
  static const LIGHT = FontWeight.w100;
  static const REGULAR = FontWeight.w300;
  static const MEDIUM = FontWeight.w500;
  static const BOLD = FontWeight.w700;
  static const BLACK = FontWeight.w900;
}

class FontStyleConfig {
  static const NORMAL = FontStyle.normal;
  static const ITALIC = FontStyle.italic;
}

class PaddingSizeConfig {
  static const SMALL = 8.0;
  static const NORMAL = 10.0;
  static const MEDIUM = 14.0;
  static const LARGE = 18.0;
}

class ColorConfig {
  static const THEME_PRIMARY = Color.fromRGBO(254, 219, 208, 1.0);
  static const THEME_SECONDARY = Color.fromRGBO(254, 234, 230, 1.0);
  static const THEME_PRIMARY_DARK = Color.fromRGBO(68, 44, 46, 1.0);
  static const BACKGROUND = Color.fromRGBO(255, 251, 250, 1.0);
  static const DIVIDER = Color.fromRGBO(68, 44, 46, 0.3);
  static const FONT_PRIMARY = THEME_PRIMARY_DARK;
  static const FONT_HINT = Color.fromRGBO(68, 44, 46, 0.5);
  static const FONT_WHITE = Colors.white;
  static const LIGHT_GREY = Color.fromRGBO(224, 224, 224, 1.0);
}
