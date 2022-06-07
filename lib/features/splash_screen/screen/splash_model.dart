import 'dart:async';
import 'package:elementary/elementary.dart';
import 'package:places/features/common/service/app_settings_service.dart';

// TODO: cover with documentation
/// Default Elementary model for Splash module
class SplashModel extends ElementaryModel {
  final AppSettingsService _appSettingsService;

  SplashModel({required AppSettingsService appSettingsService})
      : _appSettingsService = appSettingsService;

  Future<bool> getOnboardingStatus() async =>
      _appSettingsService.getOnboardingStatus();
}
