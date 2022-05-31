import 'package:elementary/elementary.dart';
import 'package:places/features/common/service/app_settings_service.dart';

// TODO: cover with documentation
/// Default Elementary model for Splash module
class SplashModel extends ElementaryModel {
  SplashModel(
    this._appSettingsService,
  ) : super();

  final AppSettingsService _appSettingsService;

  Future<bool?> getOnboardingStatus() async {
    return _appSettingsService.getOnboardingStatus();
  }
}
