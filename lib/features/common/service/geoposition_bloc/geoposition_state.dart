part of 'geoposition_bloc.dart';

@freezed
class GeopositionState with _$GeopositionState {
  const factory GeopositionState.initial({
    @Default(GeopositionStatus.denied) final GeopositionStatus status,
    @Default(Geoposition.notReceived()) final Geoposition geoposition,
  }) = _InitialState;
  const factory GeopositionState.getStatusInProgress({
    @Default(GeopositionStatus.denied) final GeopositionStatus status,
    @Default(Geoposition.notReceived()) final Geoposition geoposition,
  }) = _GetStatusInProgressState;
  const factory GeopositionState.getPositionInProgress({
    required final GeopositionStatus status,
    @Default(Geoposition.notReceived()) final Geoposition geoposition,
  }) = _GetPositionInProgressState;

  const factory GeopositionState.succsess({
    required final GeopositionStatus status,
    required final Geoposition geoposition,
  }) = _SuccsessState;

  const factory GeopositionState.error({
    required final GeopositionStatus status,
    @Default(Geoposition.notReceived()) final Geoposition geoposition,
  }) = _ErrorState;
}
