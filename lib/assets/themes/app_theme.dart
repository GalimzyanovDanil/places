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
      sliderTheme: base.sliderTheme.copyWith(
        inactiveTrackColor: AppColors.inactiveBlack,
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
      primary: AppColors.whiteGreen,
      onPrimary: AppColors.whiteBase,
      outline: AppColors.inactiveBlack,
      tertiary: AppColors.whiteMain,
      onTertiary: AppColors.whiteBase,
    );
  }

  // Получение цветовой палитры текстов для светлой темы
  static TextTheme _lightTextTheme(ThemeData base) {
    return base.textTheme.copyWith(
      headline2: AppTypography.title.copyWith(color: AppColors.whiteMain),
      headline3: AppTypography.text.copyWith(color: AppColors.whiteSecondary),
      headline4: AppTypography.subtitle.copyWith(color: AppColors.whiteMain),
      headline5:
          AppTypography.superSmall.copyWith(color: AppColors.whiteSecondary),
      headline6:
          AppTypography.superSmall.copyWith(color: AppColors.inactiveBlack),
      subtitle1: AppTypography.small.copyWith(color: AppColors.whiteSecondary2),
      subtitle2: AppTypography.smallBold.copyWith(color: AppColors.whiteBase),
      bodyText1: AppTypography.hintText.copyWith(color: AppColors.whiteMain),
      bodyText2:
          AppTypography.hintText.copyWith(color: AppColors.whiteSecondary2),
      button: AppTypography.button.copyWith(color: AppColors.whiteBase),
      caption: AppTypography.text.copyWith(color: AppColors.whiteGreen),
      overline: AppTypography.hintText.copyWith(color: AppColors.inactiveBlack),
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
      floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
        backgroundColor: AppColors.blackGreen,
      ),
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: AppColors.blackMain,
        elevation: 0,
      ),
      sliderTheme: base.sliderTheme.copyWith(
        inactiveTrackColor: AppColors.inactiveBlack,
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
      primary: AppColors.blackGreen,
      onPrimary: AppColors.whiteBase,
      outline: AppColors.inactiveBlack,
      tertiary: AppColors.whiteBase,
      onTertiary: AppColors.blackMain,
    );
  }

  // Получение цветовой палитры текстов для темной темы
  static TextTheme _darkTextTheme(ThemeData base) {
    return base.textTheme.copyWith(
      headline2: AppTypography.title.copyWith(color: AppColors.whiteBase),
      headline3: AppTypography.text.copyWith(color: AppColors.whiteBase),
      headline4: AppTypography.subtitle.copyWith(color: AppColors.whiteBase),
      headline5: AppTypography.superSmall.copyWith(color: AppColors.whiteBase),
      headline6:
          AppTypography.superSmall.copyWith(color: AppColors.inactiveBlack),
      subtitle1: AppTypography.small.copyWith(color: AppColors.blackSecondary2),
      subtitle2: AppTypography.smallBold.copyWith(color: AppColors.whiteBase),
      bodyText1: AppTypography.hintText.copyWith(color: AppColors.whiteBase),
      bodyText2:
          AppTypography.hintText.copyWith(color: AppColors.blackSecondary2),
      button: AppTypography.button.copyWith(color: AppColors.whiteBase),
      caption: AppTypography.text.copyWith(color: AppColors.blackGreen),
      overline: AppTypography.hintText.copyWith(color: AppColors.inactiveBlack),
    );
  }
}
