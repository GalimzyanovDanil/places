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
      floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
        backgroundColor: AppColors.whiteGreen,
      ),
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: AppColors.whiteBase,
        elevation: 0,
      ),
      scaffoldBackgroundColor: AppColors.whiteBase,
      indicatorColor: AppColors.whiteGreen,
      disabledColor: AppColors.inactiveBlack,
      primaryColor: AppColors.background,
    );
  }

  //Получение цветовой палитры для светлой темы
  static ColorScheme _ligthColorScheme(ThemeData base) {
    return base.colorScheme.copyWith(
        //TODO
        // background: AppColors.blackMain,
        // primary: AppColors.whiteBase,
        // onPrimary: AppColors.blackGreen,

        );
  }

  // Получение цветовой палитры текстов для светлой темы
  static TextTheme _lightTextTheme(ThemeData base) {
    return base.textTheme.copyWith(
        headline2: AppTypography.title.copyWith(color: AppColors.whiteMain),
        headline3: AppTypography.text.copyWith(color: AppColors.whiteSecondary),
        headline4: AppTypography.subtitle.copyWith(color: AppColors.whiteMain),
        subtitle1:
            AppTypography.small.copyWith(color: AppColors.whiteSecondary2),
        subtitle2: AppTypography.smallBold.copyWith(color: AppColors.whiteBase),
        button: AppTypography.button.copyWith(color: AppColors.whiteBase),
        caption: AppTypography.text.copyWith(color: AppColors.whiteGreen),
        overline:
            AppTypography.hintText.copyWith(color: AppColors.inactiveBlack));
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
      floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
        backgroundColor: AppColors.blackGreen,
      ),
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: AppColors.blackMain,
        elevation: 0,
      ),
      scaffoldBackgroundColor: AppColors.blackMain,
      indicatorColor: AppColors.blackGreen,
      disabledColor: AppColors.inactiveBlack,
      primaryColor: AppColors.blackDark,
    );
  }

  //Получение цветовой палитры для темной темы
  static ColorScheme _darkColorScheme(ThemeData base) {
    return base.colorScheme.copyWith(
        //TODO
        // background: AppColors.blackMain,
        // primary: AppColors.whiteBase,
        // onPrimary: AppColors.blackGreen,
        );
  }

  // Получение цветовой палитры текстов для темной темы
  static TextTheme _darkTextTheme(ThemeData base) {
    return base.textTheme.copyWith(
        headline2: AppTypography.title.copyWith(color: AppColors.whiteBase),
        headline3: AppTypography.text.copyWith(color: AppColors.whiteBase),
        headline4: AppTypography.subtitle.copyWith(color: AppColors.whiteBase),
        subtitle1:
            AppTypography.small.copyWith(color: AppColors.whiteSecondary2),
        subtitle2: AppTypography.smallBold.copyWith(color: AppColors.whiteBase),
        button: AppTypography.button.copyWith(color: AppColors.whiteBase),
        caption: AppTypography.text.copyWith(color: AppColors.blackGreen),
        overline:
            AppTypography.hintText.copyWith(color: AppColors.inactiveBlack));
  }
}
