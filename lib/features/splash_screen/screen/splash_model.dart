import 'dart:async';
import 'package:elementary/elementary.dart';
import 'package:places/features/common/service/app_settings_service.dart';
import 'package:places/features/common/service/geoposition_service.dart';

// TODO: cover with documentation
/// Default Elementary model for Splash module
class SplashModel extends ElementaryModel {
  final AppSettingsService _appSettingsService;
  final GeopositionService _geopositionService;

  SplashModel(
      {required AppSettingsService appSettingsService,
      required GeopositionService geopositionService})
      : _appSettingsService = appSettingsService,
        _geopositionService = geopositionService,
        super();

  Future<bool> getOnboardingStatus() async =>
      _appSettingsService.getOnboardingStatus();

  Future<bool> isLocationServiceEnabled() =>
      _geopositionService.isLocationServiceEnabled();

  Future<GeopositionStatus> isCheckPermission() =>
      _geopositionService.checkPermission();

  Future<GeopositionStatus> requsetAndIsCheckPermission() =>
      _geopositionService.requsetAndCheckPermission();

  Future<void> openSettings() => _geopositionService.openLocationSettings();
}
