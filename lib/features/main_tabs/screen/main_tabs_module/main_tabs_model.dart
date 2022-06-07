import 'package:elementary/elementary.dart';
import 'package:places/features/common/service/app_settings_service.dart';

// TODO: cover with documentation
/// Default Elementary model for Settings module
class MainTabsModel extends ElementaryModel {
  MainTabsModel(this._appSettingsService);

  final AppSettingsService _appSettingsService;

  /// Запись индекса таба
  void setTabIndex(int index) {
    return _appSettingsService.setTabIndex(index);
  }

  /// Получение индекса таба
  int? getTabIndex() {
    return _appSettingsService.getTabIndex();
  }
}
