part of 'geoposition_bloc.dart';

@freezed
class GeopositionEvent with _$GeopositionEvent {
  const factory GeopositionEvent.checkAndRequestPermission() =
      _CheckAndRequestPermissionEvent;
  const factory GeopositionEvent.getGeoposition() = _GetGeopositionEvent;
}
