import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/features/common/domain/entity/geoposition.dart';
import 'package:places/features/common/domain/repository/geoposition_repository.dart';

part 'geoposition_event.dart';
part 'geoposition_state.dart';
part 'geoposition_bloc.freezed.dart';

class GeopositionBloc extends Bloc<GeopositionEvent, GeopositionState> {
  final GeopositionRepository _geopositionRepository;
  GeopositionBloc(this._geopositionRepository) : super(const _InitialState()) {
    on<GeopositionEvent>((event, emit) async {
      await event.map<Future<void>>(
        checkAndRequestPermission: (value) =>
            _onCheckAndRequestPermission(event, emit),
        getGeoposition: (event) => _onGetGeoposition(event, emit),
      );
    });
  }

  Future<void> _onCheckAndRequestPermission(
      GeopositionEvent event, Emitter<GeopositionState> emit) async {
    if (state.status == GeopositionStatus.ok) {
      emit(GeopositionState.succsess(
        status: state.status,
        geoposition: state.geoposition,
      ));
      return;
    }
    emit(const GeopositionState.getStatusInProgress());
    GeopositionStatus status;
    status = await _geopositionRepository.checkPermission();

    if (status == GeopositionStatus.denied ||
        status == GeopositionStatus.deniedForever) {
      status = await _geopositionRepository.requsetAndCheckPermission();
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
        emit(const GeopositionState.getPositionInProgress(
          status: GeopositionStatus.ok,
        ));
        final isServiceEnbled =
            await _geopositionRepository.isLocationServiceEnabled();
        if (!isServiceEnbled) {
          await _geopositionRepository.openLocationSettings();
        }
        final geoposition = await _geopositionRepository.getCurrentPosition();
        emit(GeopositionState.succsess(
          status: state.status,
          geoposition: geoposition,
        ));
        break;
      case GeopositionStatus.firstDenied:
        throw UnimplementedError();
    }
  }

  Future<void> _onGetGeoposition(
      GeopositionEvent event, Emitter<GeopositionState> emit) async {
    emit(GeopositionState.succsess(
      status: state.status,
      geoposition: state.geoposition,
    ));
  }
}
