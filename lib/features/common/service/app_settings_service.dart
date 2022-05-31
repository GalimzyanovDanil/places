import 'dart:async';
import 'package:places/features/common/domain/repository/local_storage_repository.dart';
import 'package:places/features/common/strings/local_storage_keys.dart';

class AppSettingsService {
  final LocalStorageRepository _repository;
  AppSettingsService(this._repository) {
    _init();
  }

  /// Стрим для управления темой приложения
  final _themeStreamController = StreamController<bool>();

  /// Хранение текущего таба
  int? _tabIndex;

  /// Хранение текущей темы Темная-Светлая.  FALSE - Light, TRUE - Dark
  bool? _isDarkCurrentTheme;

  Stream<bool> get themeStream => _themeStreamController.stream;

  ///Получение локальной темы
  bool? getTheme() => _isDarkCurrentTheme;

  ///Запись темы
  void setTheme({required bool isDark}) {
    if (isDark == _isDarkCurrentTheme) return;
    _themeStreamController.add(isDark);
    _isDarkCurrentTheme = isDark;
    _setThemeToStorage(isDark: isDark);
  }

  /// Получение настроек фильтра по типам мест
  Future<List<String>?> getFilterPlaceTypes() async {
    return _repository
        .getValue<List<String>>(LocalStorageKeys.filterPlaceTypes);
  }

  /// Получение настроек фильтра по расстоянию
  Future<double?> getFilterDistance() async {
    return _repository.getValue<double>(LocalStorageKeys.filterDistance);
  }

  /// Запись настроек фильтра по типам мест
  Future<void> setFilterPlaceTypes(List<String> types) async {
    unawaited(_repository.setValue(types, LocalStorageKeys.filterPlaceTypes));
  }

  /// Запись настроек фильтра по расстоянию
  Future<void> setFilterDistance(double distance) async {
    unawaited(_repository.setValue(distance, LocalStorageKeys.filterDistance));
  }

  /// Сохранение статуса онбординга
  Future<void> setOnboardingStatus({required bool isComplete}) async {
    unawaited(
        _repository.setValue(isComplete, LocalStorageKeys.onboardingStatus));
  }

  /// Чтение статуса онбординга
  Future<bool?> getOnboardingStatus() async {
    return _repository.getValue<bool>(LocalStorageKeys.onboardingStatus);
  }

  /// Запись индекса таба
  void setTabIndex(int newIndex) {
    if (newIndex == _tabIndex) return;
    _tabIndex = newIndex;
    _setTabIndexToStorage(newIndex);
  }

  /// Получение индекса локального таба
  int? getTabIndex() => _tabIndex;

  Future<void> _init() async {
    _isDarkCurrentTheme = await _getThemeFromStorage();
    _themeStreamController.add(_isDarkCurrentTheme ?? false);
    _tabIndex = await _getTabIndexFromStorage();
  }

  /// Получение темы из хранилища
  Future<bool?> _getThemeFromStorage() async {
    return _repository.getValue<bool>(LocalStorageKeys.themeKey);
  }

  /// Запись темы в хранилище
  Future<void> _setThemeToStorage({required bool isDark}) async {
    unawaited(_repository.setValue(isDark, LocalStorageKeys.themeKey));
  }

  /// Запись индекса таба в хранилище
  Future<void> _setTabIndexToStorage(int index) async {
    return _repository.setValue(index, LocalStorageKeys.mainTabIndex);
  }

  /// Получение индекса таба из хранилища
  Future<int?> _getTabIndexFromStorage() async {
    return _repository.getValue(LocalStorageKeys.mainTabIndex);
  }

  void dispose() {
    _themeStreamController.close();
  }
}
