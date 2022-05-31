import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:places/features/common/service/app_settings_service.dart';
import 'package:places/features/common/service/geoposition_service.dart';

// TODO: cover with documentation
/// Default Elementary model for Splash module
class SplashModel extends ElementaryModel {
  SplashModel(
      {required AppSettingsService appSettingsService,
      required GeopositionService geopositionService})
      : _appSettingsService = appSettingsService,
        _geopositionService = geopositionService,
        super();

  final AppSettingsService _appSettingsService;
  final GeopositionService _geopositionService;

  Future<bool> getOnboardingStatus() async =>
      _appSettingsService.getOnboardingStatus();

  Future<void> checkPermission() => _geopositionService.checkPermission();
}
