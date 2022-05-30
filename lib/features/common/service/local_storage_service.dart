import 'dart:async';

import 'package:places/features/common/domain/repository/local_storage_repository.dart';
import 'package:places/features/common/strings/local_storage_keys.dart';

class LocalStorageService {
  final LocalStorageRepository _repository;
  LocalStorageService(this._repository);

  /// Получение темы Темная-Светлая. TRUE - Light, FALSE - Dark
  Future<bool?> getTheme() async {
    return _repository.getValue<bool>(LocalStorageKeys.themeKey);
  }

  /// Запись темы Темная-Светлая. TRUE - Light, FALSE - Dark
  Future<void> setTheme({required bool isLight}) async {
    unawaited(_repository.setValue(isLight, LocalStorageKeys.themeKey));
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
}
