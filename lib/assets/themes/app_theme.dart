// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:places/assets/colors/app_colors.dart';
import 'package:places/assets/themes/app_typography.dart';

///Темы приложения
class AppTheme {
  static ThemeData get lightTheme => _getLigthTheme();
  static ThemeData get darkTheme => _getDarkTheme();

  AppTheme._();

  // Получение глобальной светлой темы
  static ThemeData _getLigthTheme() {
    final base = ThemeData.light();
    return base.copyWith(
      colorScheme: _ligthColorScheme(base),
      textTheme: _lightTextTheme(base),
      iconTheme: base.iconTheme.copyWith(
        color: AppColors.whiteMain,
      ),
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: AppColors.whiteGreen,
      ),
    );
  }

  // Получение глобальной темной темы
  static ThemeData _getDarkTheme() {
    final base = ThemeData.dark();
    return base.copyWith(
      colorScheme: _darkColorScheme(base),
      textTheme: _darkTextTheme(base),
      iconTheme: base.iconTheme.copyWith(
        color: AppColors.whiteBase,
      ),
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: AppColors.blackGreen,
      ),
    );
  }

  //Получение цветовой палитры для светлой темы
  static ColorScheme _ligthColorScheme(ThemeData base) {
    return base.colorScheme.copyWith(
      background: AppColors.whiteBase,
      primary: AppColors.whiteBase,
      onPrimary: AppColors.whiteGreen,
    );
  }

  // Получение цветовой палитры текстов для светлой темы
  static TextTheme _lightTextTheme(ThemeData base) {
    return base.textTheme.copyWith(
      headline2: AppTypography.title.copyWith(
        color: AppColors.whiteMain,
      ),
      subtitle1: AppTypography.small.copyWith(
        color: AppColors.whiteSecondary2,
      ),
    );
  }

  //Получение цветовой палитры для темной темы
  static ColorScheme _darkColorScheme(ThemeData base) {
    return base.colorScheme.copyWith(
      background: AppColors.blackMain,
      primary: AppColors.blackMain,
      onPrimary: AppColors.blackGreen,
    );
  }

  // Получение цветовой палитры текстов для темной темы
  static TextTheme _darkTextTheme(ThemeData base) {
    return base.textTheme.copyWith(
      headline2: AppTypography.title.copyWith(
        color: AppColors.whiteBase,
      ),
      subtitle1: AppTypography.small.copyWith(
        color: AppColors.blackSecondary2,
      ),
    );
  }
}
