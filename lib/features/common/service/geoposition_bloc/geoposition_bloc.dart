import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_transformer;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:places/features/common/domain/entity/geoposition.dart';

part 'geoposition_event.dart';
part 'geoposition_state.dart';
part 'geoposition_bloc.freezed.dart';

class GeopositionBloc extends Bloc<GeopositionEvent, GeopositionState> {
  GeopositionBloc() : super(const _InitialState()) {
    on<GeopositionEvent>(
      (event, emit) async {
        await event.map<Future<void>>(
          checkAndRequestPermission: (value) =>
              _onCheckAndRequestPermission(event, emit),
          getGeoposition: (event) => _onGetGeoposition(event, emit),
        );
      },
      transformer: bloc_transformer.droppable(),
    );
  }

  Future<void> _onCheckAndRequestPermission(
    GeopositionEvent event,
    Emitter<GeopositionState> emit,
  ) async {
    if (state.status == GeopositionStatus.ok && state.geoposition != null) {
      emit(GeopositionState.succsess(
        status: state.status,
        geoposition: state.geoposition!,
      ));
      return;
    }
    emit(const GeopositionState.getStatusInProgress());
    LocationPermission permission;
    GeopositionStatus status;
    permission = await Geolocator.checkPermission();
    status = _mapPermissionToStatus(permission);

    if (status == GeopositionStatus.denied ||
        status == GeopositionStatus.deniedForever) {
      permission = await Geolocator.requestPermission();
      status = _mapPermissionToStatus(permission);
    }

    switch (status) {
      case GeopositionStatus.denied:
        emit(const GeopositionState.error(
          status: GeopositionStatus.denied,
        ));
        break;
      case GeopositionStatus.deniedForever:
        emit(const GeopositionState.error(
          status: GeopositionStatus.deniedForever,
        ));
        break;
      case GeopositionStatus.ok:
        await _onGetGeoposition(event, emit);
        break;
      case GeopositionStatus.firstDenied:
        throw UnimplementedError();
    }
  }

  Future<void> _onGetGeoposition(
    GeopositionEvent event,
    Emitter<GeopositionState> emit,
  ) async {
    emit(const GeopositionState.getPositionInProgress(
      status: GeopositionStatus.ok,
    ));
    final isServiceEnbled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnbled) {
      await Geolocator.openLocationSettings();
    }

    final geoposition = await _getCurrentPosition();
    if (geoposition != null) {
      emit(GeopositionState.succsess(
        status: state.status,
        geoposition: geoposition,
      ));
    } else {
      emit(const GeopositionState.error(
        status: GeopositionStatus.denied,
      ));
    }
  }

  Future<Geoposition?> _getCurrentPosition() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );

      return Geoposition(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } on Object catch (_) {
      return null;
    }
  }
}

enum GeopositionStatus { denied, firstDenied, ok, deniedForever }

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
