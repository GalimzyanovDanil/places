import 'dart:async';
import 'package:places/features/common/domain/repository/shared_prefs_storage.dart';

class AppSettingsService {
  final SharedPrefsStorage _sharedPrefsStorage;
  AppSettingsService(this._sharedPrefsStorage) {
    _init();
  }

  /// Стрим для управления темой приложения
  final _themeStreamController = StreamController<bool>();

  /// Хранение текущего таба
  int _tabIndex = 0;

  /// Хранение текущей темы Темная-Светлая.  FALSE - Light, TRUE - Dark
  bool _isDarkCurrentTheme = false;

  Stream<bool> get themeStream => _themeStreamController.stream;

  ///Получение локальной темы
  bool getTheme() => _isDarkCurrentTheme;

  ///Запись темы
  void setTheme({required bool isDark}) {
    if (isDark == _isDarkCurrentTheme) return;
    _themeStreamController.add(isDark);
    _isDarkCurrentTheme = isDark;
    _sharedPrefsStorage.setTheme(isDark: isDark);
  }

  /// Получение индекса локального таба
  int getTabIndex() => _tabIndex;

  /// Запись индекса таба
  void setTabIndex(int newIndex) {
    if (newIndex == _tabIndex) return;
    _tabIndex = newIndex;
    _sharedPrefsStorage.setTabIndex(newIndex);
  }

  /// Получение настроек фильтра по типам мест
  Future<List<String>> getFilterPlaceTypes() async =>
      _sharedPrefsStorage.getFilterPlaceTypes();

  /// Получение настроек фильтра по расстоянию
  Future<double> getFilterDistance() async =>
      _sharedPrefsStorage.getFilterDistance();

  /// Запись настроек фильтра по типам мест
  Future<void> setFilterPlaceTypes(List<String> types) async =>
      _sharedPrefsStorage.setFilterPlaceTypes(types);

  /// Запись настроек фильтра по расстоянию
  Future<void> setFilterDistance(double distance) async =>
      _sharedPrefsStorage.setFilterDistance(distance);

  /// Сохранение статуса онбординга
  Future<void> setOnboardingStatus({required bool isComplete}) async =>
      _sharedPrefsStorage.setOnboardingStatus(isComplete: isComplete);

  /// Чтение статуса онбординга
  Future<bool> getOnboardingStatus() async =>
      _sharedPrefsStorage.getOnboardingStatus();

  Future<void> _init() async {
    _isDarkCurrentTheme = await _sharedPrefsStorage.getTheme();
    _themeStreamController.add(_isDarkCurrentTheme);
    _tabIndex = await _sharedPrefsStorage.getTabIndex();
  }

  void dispose() {
    _themeStreamController.close();
  }
}
