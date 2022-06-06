import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:places/features/common/domain/entity/geoposition.dart';

enum GeopositionStatus { denied, firstDenied, ok, deniedForever }

class GeopositionRepository {
  // Получение текущей геопозиции
  Future<Geoposition> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return Geoposition(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  // Проверка включен ли GPS
  Future<bool> isLocationServiceEnabled() async {
    final isServiceEnable = await Geolocator.isLocationServiceEnabled();
    return isServiceEnable;
  }

  //Проверка дано ли разрешение
  Future<GeopositionStatus> checkPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    return _mapPermissionToStatus(permission);
  }

  // Запрос разрешения. В ответ получаем статус
  Future<GeopositionStatus> requsetAndCheckPermission() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    return _mapPermissionToStatus(permission);
  }

  // Открыть настройки GPS
  Future<void> openLocationSettings() async {
    unawaited(Geolocator.openLocationSettings());
  }

  // Маппер из enum пакета в enum приложения
  GeopositionStatus _mapPermissionToStatus(LocationPermission permission) {
    switch (permission) {
      case LocationPermission.denied:
      case LocationPermission.unableToDetermine:
        return GeopositionStatus.denied;
      case LocationPermission.whileInUse:
      case LocationPermission.always:
        return GeopositionStatus.ok;
      case LocationPermission.deniedForever:
        return GeopositionStatus.deniedForever;
    }
  }
}
