import 'dart:async';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/common/strings/local_storage_keys.dart';
import 'package:places/util/shared_preferences_helper.dart';

class SharedPrefsStorage {
  final SharedPreferencesHelper _sharedPreferencesHelper;

  SharedPrefsStorage(this._sharedPreferencesHelper);

  /// Получение настроек фильтра по типам мест
  Future<List<String>> getFilterPlaceTypes() async {
    return _sharedPreferencesHelper.get<List<String>>(
      LocalStorageKeys.filterPlaceTypes,
      PlaceType.values.map((e) => e.name).toList(),
    );
  }

  /// Запись настроек фильтра по типам мест
  Future<void> setFilterPlaceTypes(List<String> types) async {
    unawaited(_sharedPreferencesHelper.set(
      LocalStorageKeys.filterPlaceTypes,
      types,
    ));
  }

  /// Получение настроек фильтра по расстоянию
  Future<double> getFilterDistance() async {
    return _sharedPreferencesHelper.get<double>(
      LocalStorageKeys.filterDistance,
      30.0,
    );
  }

  /// Запись настроек фильтра по расстоянию
  Future<void> setFilterDistance(double distance) async {
    unawaited(_sharedPreferencesHelper.set(
      LocalStorageKeys.filterDistance,
      distance,
    ));
  }

  /// Чтение статуса онбординга
  Future<bool> getOnboardingStatus() async {
    return _sharedPreferencesHelper.get<bool>(
      LocalStorageKeys.onboardingStatus,
      false,
    );
  }

  /// Сохранение статуса онбординга
  Future<void> setOnboardingStatus({required bool isComplete}) async {
    unawaited(_sharedPreferencesHelper.set(
      LocalStorageKeys.onboardingStatus,
      isComplete,
    ));
  }

  /// Получение индекса таба
  Future<int> getTabIndex() async {
    return _sharedPreferencesHelper.get(LocalStorageKeys.mainTabIndex, 0);
  }

  /// Запись индекса таба
  Future<void> setTabIndex(int index) async {
    return _sharedPreferencesHelper.set(LocalStorageKeys.mainTabIndex, index);
  }

  /// Получение темы
  Future<bool> getTheme() async {
    return _sharedPreferencesHelper.get<bool>(LocalStorageKeys.themeKey, false);
  }

  /// Запись темы
  Future<void> setTheme({required bool isDark}) async {
    unawaited(_sharedPreferencesHelper.set(LocalStorageKeys.themeKey, isDark));
  }
}
