import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/settings/screen/settings_wm.dart';

// TODO: cover with documentation
/// Main widget for Settings module
class SettingsScreen extends ElementaryWidget<ISettingsWidgetModel> {
  const SettingsScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultSettingsWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISettingsWidgetModel wm) {
    return const Scaffold(
      body: Center(
        child: Text('SETTINGS'),
      ),
    );
  }
}
