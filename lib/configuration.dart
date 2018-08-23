import 'dart:ui';

import 'package:flutter/material.dart';

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
  static const DIVIDER = Color.fromRGBO(84, 110, 122, 0.3);
  static const FONT_PRIMARY = THEME_PRIMARY_DARK;
}
