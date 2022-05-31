// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/settings/screen/settings_wm.dart';
import 'package:places/features/settings/strings/settings_strings.dart';

// TODO: cover with documentation
/// Main widget for Settings module
class SettingsScreen extends ElementaryWidget<ISettingsWidgetModel> {
  const SettingsScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultSettingsWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISettingsWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          SettingsStrings.title,
          style: wm.theme.textTheme.headline4,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ThemeChangeWidget(
              themeState: wm.themeState,
              theme: wm.theme,
              onChange: wm.changeTheme,
            ),
            Divider(color: wm.theme.colorScheme.outline),
            _ShowOnboardingWidget(theme: wm.theme, onTapInfo: wm.onTapInfo),
            Divider(color: wm.theme.colorScheme.outline),
          ],
        ),
      ),
    );
  }
}

class _ThemeChangeWidget extends StatelessWidget {
  const _ThemeChangeWidget({
    required this.onChange,
    required this.theme,
    required this.themeState,
    Key? key,
  }) : super(key: key);

  final ValueChanged<bool> onChange;
  final ThemeData theme;
  final ListenableState<bool> themeState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = theme.colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          SettingsStrings.darkTheme,
          style: theme.textTheme.bodyText1,
        ),
        StateNotifierBuilder<bool>(
          listenableState: themeState,
          builder: (_, value) => CupertinoSwitch(
              value: value ?? false,
              trackColor: colorScheme.outline,
              activeColor: colorScheme.primary,
              onChanged: onChange),
        ),
      ],
    );
  }
}

class _ShowOnboardingWidget extends StatelessWidget {
  const _ShowOnboardingWidget({
    required this.theme,
    required this.onTapInfo,
    Key? key,
  }) : super(key: key);

  final ThemeData theme;
  final VoidCallback onTapInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          SettingsStrings.watchOnboarding,
          style: theme.textTheme.bodyText1,
        ),
        IconButton(
            onPressed: onTapInfo,
            splashRadius: 15,
            icon: SvgPicture.asset(
              AppAssets.iconInfo,
              color: theme.colorScheme.primary,
            )),
      ],
    );
  }
}
