// ignore_for_file: avoid_positional_boolean_parameters

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/navigation/domain/entity/app_coordinate.dart';
import 'package:places/features/navigation/service/coordinator.dart';
import 'package:places/features/settings/screen/settings_model.dart';
import 'package:places/features/settings/screen/settings_screen.dart';
import 'package:provider/provider.dart';

abstract class ISettingsWidgetModel extends IWidgetModel {
  ListenableState<bool> get themeState;
  void changeTheme(bool isDark);
  void onTapInfo();
  ThemeData get theme;
}

SettingsWidgetModel defaultSettingsWidgetModelFactory(BuildContext context) {
  final appScope = context.read<IAppScope>();
  final model = SettingsModel(appScope.appSettingsService);
  return SettingsWidgetModel(
    model: model,
    coordinator: appScope.coordinator,
  );
}

// TODO: cover with documentation
/// Default widget model for SettingsWidget
class SettingsWidgetModel extends WidgetModel<SettingsScreen, SettingsModel>
    implements ISettingsWidgetModel {
  SettingsWidgetModel({required SettingsModel model, required this.coordinator})
      : super(model);

  final Coordinator coordinator;
  final _themeState = StateNotifier<bool>();

  @override
  ThemeData get theme => Theme.of(context);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  @override
  void changeTheme(bool isDark) {
    model.setTheme(isDark: isDark);
    _themeState.accept(isDark);
  }

  @override
  void onTapInfo() {
    coordinator.navigate(
      context,
      AppCoordinate.onboardingScreen,
    );
  }

  @override
  ListenableState<bool> get themeState => _themeState;

  void _init() {
    final currentTheme = model.getTheme();
    _themeState.accept(currentTheme);
  }
}
