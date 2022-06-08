import 'package:elementary/elementary.dart';
import 'package:places/features/common/service/app_settings_service.dart';

// TODO(me): cover with documentation
/// Default Elementary model for Settings module
class SettingsModel extends ElementaryModel {
  final AppSettingsService _appSettingsService;

  SettingsModel(
    this._appSettingsService,
  );

  void setTheme({required bool isDark}) =>
      _appSettingsService.setTheme(isDark: isDark);

  bool getTheme() => _appSettingsService.getTheme();
}
