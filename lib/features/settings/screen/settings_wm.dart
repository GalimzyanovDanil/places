import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/settings/screen/settings_model.dart';
import 'package:places/features/settings/screen/settings_screen.dart';

abstract class ISettingsWidgetModel extends IWidgetModel {}

SettingsWidgetModel defaultSettingsWidgetModelFactory(BuildContext context) {
  final model = SettingsModel();
  return SettingsWidgetModel(model);
}

// TODO: cover with documentation
/// Default widget model for SettingsWidget
class SettingsWidgetModel extends WidgetModel<SettingsScreen, SettingsModel>
    implements ISettingsWidgetModel {
  SettingsWidgetModel(SettingsModel model) : super(model);
}
