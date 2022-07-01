part of 'geoposition_bloc.dart';

@freezed
class GeopositionState with _$GeopositionState {
  Geoposition? get geoposition => whenOrNull(
        succsess: (_, geoposition) => geoposition,
      );
  const GeopositionState._();

  const factory GeopositionState.initial({
    @Default(GeopositionStatus.denied) final GeopositionStatus status,
    @Default(null) final Geoposition? geoposition,
  }) = _InitialState;
  const factory GeopositionState.getStatusInProgress({
    @Default(GeopositionStatus.denied) final GeopositionStatus status,
    @Default(null) final Geoposition? geoposition,
  }) = _GetStatusInProgressState;
  const factory GeopositionState.getPositionInProgress({
    required final GeopositionStatus status,
    @Default(null) final Geoposition? geoposition,
  }) = _GetPositionInProgressState;

  const factory GeopositionState.succsess({
    required final GeopositionStatus status,
    required final Geoposition geoposition,
  }) = _SuccsessState;

  const factory GeopositionState.error({
    required final GeopositionStatus status,
    @Default(null) final Geoposition? geoposition,
  }) = _ErrorState;
}
