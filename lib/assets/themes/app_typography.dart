import 'package:flutter/material.dart';

/// Текстовые стили
class AppTypography {
  // Базовый стиль текста с указанием шрифта
  static const _base = TextStyle(fontFamily: 'Roboto');

  static TextStyle get largeTitle => _base.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.125,
      );

  static TextStyle get title => _base.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.2,
      );

  static TextStyle get subtitle => _base.copyWith(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        height: 1.33,
      );

  static TextStyle get text => _base.copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        height: 1.25,
      );

  static TextStyle get smallBold => _base.copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w700,
        height: 1.29,
      );

  static TextStyle get small => _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.29,
      );

  static TextStyle get superSmall => _base.copyWith(
        fontSize: 12.0,
        height: 1.33,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get button => _base.copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w700,
        height: 1.29,
        letterSpacing: 0.3,
      );
}
