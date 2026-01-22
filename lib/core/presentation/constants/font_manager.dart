import 'package:flutter/widgets.dart';

class FontManagerWeight {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

class AppFontSize {
  static const fs = [12, 14, 16, 18, 20, 24, 26, 28, 30, 32];

  static double fsValidate(double value) {
    if (fs.contains(value)) return value;
    throw Exception('Font size value $value is not in the design system: $fs');
  }
}
