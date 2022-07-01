import 'dart:async';
import 'package:elementary/elementary.dart';
import 'package:places/features/common/service/app_settings_service.dart';
import 'package:places/features/common/service/geoposition_bloc/geoposition_bloc.dart';

// TODO(me): cover with documentation
/// Default Elementary model for Splash module
class SplashModel extends ElementaryModel {
  final AppSettingsService _appSettingsService;
  final GeopositionBloc _geopositionBloc;

  Stream<GeopositionState> get geopositionStream => _geopositionBloc.stream;

  SplashModel({
    required AppSettingsService appSettingsService,
    required GeopositionBloc geopositionBloc,
  })  : _appSettingsService = appSettingsService,
        _geopositionBloc = geopositionBloc;

  @override
  void init() {
    super.init();
    _geopositionBloc.add(const GeopositionEvent.checkAndRequestPermission());
  }

  Future<bool> getOnboardingStatus() async =>
      _appSettingsService.getOnboardingStatus();
}
