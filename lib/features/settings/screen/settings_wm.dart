// ignore_for_file: avoid_positional_boolean_parameters

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/navigation/app_router.dart';
import 'package:places/features/settings/screen/settings_model.dart';
import 'package:places/features/settings/screen/settings_screen.dart';
import 'package:provider/provider.dart';

abstract class ISettingsWidgetModel extends IWidgetModel {
  ListenableState<bool> get themeState;
  ThemeData get theme;
  void changeTheme(bool isDark);
  void onTapInfo();
}

SettingsWidgetModel defaultSettingsWidgetModelFactory(BuildContext context) {
  final appScope = context.read<IAppScope>();
  final model = SettingsModel(appScope.appSettingsService);
  return SettingsWidgetModel(
    model: model,
    router: appScope.router,
  );
}

// TODO(me): cover with documentation
/// Default widget model for SettingsWidget
class SettingsWidgetModel extends WidgetModel<SettingsScreen, SettingsModel>
    implements ISettingsWidgetModel {
  final AppRouter router;
  final _themeState = StateNotifier<bool>();

  @override
  ListenableState<bool> get themeState => _themeState;

  @override
  ThemeData get theme => Theme.of(context);

  SettingsWidgetModel({required SettingsModel model, required this.router})
      : super(model);

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
    router.pushNamed(RoutesStrings.onboarding);
  }

  void _init() {
    final currentTheme = model.getTheme();
    _themeState.accept(currentTheme);
  }
}
