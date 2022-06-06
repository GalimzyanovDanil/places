// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'geoposition_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GeopositionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAndRequestPermission,
    required TResult Function() getGeoposition,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? checkAndRequestPermission,
    TResult Function()? getGeoposition,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAndRequestPermission,
    TResult Function()? getGeoposition,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAndRequestPermissionEvent value)
        checkAndRequestPermission,
    required TResult Function(_GetGeopositionEvent value) getGeoposition,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_CheckAndRequestPermissionEvent value)?
        checkAndRequestPermission,
    TResult Function(_GetGeopositionEvent value)? getGeoposition,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAndRequestPermissionEvent value)?
        checkAndRequestPermission,
    TResult Function(_GetGeopositionEvent value)? getGeoposition,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeopositionEventCopyWith<$Res> {
  factory $GeopositionEventCopyWith(
          GeopositionEvent value, $Res Function(GeopositionEvent) then) =
      _$GeopositionEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$GeopositionEventCopyWithImpl<$Res>
    implements $GeopositionEventCopyWith<$Res> {
  _$GeopositionEventCopyWithImpl(this._value, this._then);

  final GeopositionEvent _value;
  // ignore: unused_field
  final $Res Function(GeopositionEvent) _then;
}

/// @nodoc
abstract class _$$_CheckAndRequestPermissionEventCopyWith<$Res> {
  factory _$$_CheckAndRequestPermissionEventCopyWith(
          _$_CheckAndRequestPermissionEvent value,
          $Res Function(_$_CheckAndRequestPermissionEvent) then) =
      __$$_CheckAndRequestPermissionEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_CheckAndRequestPermissionEventCopyWithImpl<$Res>
    extends _$GeopositionEventCopyWithImpl<$Res>
    implements _$$_CheckAndRequestPermissionEventCopyWith<$Res> {
  __$$_CheckAndRequestPermissionEventCopyWithImpl(
      _$_CheckAndRequestPermissionEvent _value,
      $Res Function(_$_CheckAndRequestPermissionEvent) _then)
      : super(_value, (v) => _then(v as _$_CheckAndRequestPermissionEvent));

  @override
  _$_CheckAndRequestPermissionEvent get _value =>
      super._value as _$_CheckAndRequestPermissionEvent;
}

/// @nodoc

class _$_CheckAndRequestPermissionEvent
    implements _CheckAndRequestPermissionEvent {
  const _$_CheckAndRequestPermissionEvent();

  @override
  String toString() {
    return 'GeopositionEvent.checkAndRequestPermission()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CheckAndRequestPermissionEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAndRequestPermission,
    required TResult Function() getGeoposition,
  }) {
    return checkAndRequestPermission();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? checkAndRequestPermission,
    TResult Function()? getGeoposition,
  }) {
    return checkAndRequestPermission?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAndRequestPermission,
    TResult Function()? getGeoposition,
    required TResult orElse(),
  }) {
    if (checkAndRequestPermission != null) {
      return checkAndRequestPermission();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAndRequestPermissionEvent value)
        checkAndRequestPermission,
    required TResult Function(_GetGeopositionEvent value) getGeoposition,
  }) {
    return checkAndRequestPermission(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_CheckAndRequestPermissionEvent value)?
        checkAndRequestPermission,
    TResult Function(_GetGeopositionEvent value)? getGeoposition,
  }) {
    return checkAndRequestPermission?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAndRequestPermissionEvent value)?
        checkAndRequestPermission,
    TResult Function(_GetGeopositionEvent value)? getGeoposition,
    required TResult orElse(),
  }) {
    if (checkAndRequestPermission != null) {
      return checkAndRequestPermission(this);
    }
    return orElse();
  }
}

abstract class _CheckAndRequestPermissionEvent implements GeopositionEvent {
  const factory _CheckAndRequestPermissionEvent() =
      _$_CheckAndRequestPermissionEvent;
}

/// @nodoc
abstract class _$$_GetGeopositionEventCopyWith<$Res> {
  factory _$$_GetGeopositionEventCopyWith(_$_GetGeopositionEvent value,
          $Res Function(_$_GetGeopositionEvent) then) =
      __$$_GetGeopositionEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_GetGeopositionEventCopyWithImpl<$Res>
    extends _$GeopositionEventCopyWithImpl<$Res>
    implements _$$_GetGeopositionEventCopyWith<$Res> {
  __$$_GetGeopositionEventCopyWithImpl(_$_GetGeopositionEvent _value,
      $Res Function(_$_GetGeopositionEvent) _then)
      : super(_value, (v) => _then(v as _$_GetGeopositionEvent));

  @override
  _$_GetGeopositionEvent get _value => super._value as _$_GetGeopositionEvent;
}

/// @nodoc

class _$_GetGeopositionEvent implements _GetGeopositionEvent {
  const _$_GetGeopositionEvent();

  @override
  String toString() {
    return 'GeopositionEvent.getGeoposition()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_GetGeopositionEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAndRequestPermission,
    required TResult Function() getGeoposition,
  }) {
    return getGeoposition();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? checkAndRequestPermission,
    TResult Function()? getGeoposition,
  }) {
    return getGeoposition?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAndRequestPermission,
    TResult Function()? getGeoposition,
    required TResult orElse(),
  }) {
    if (getGeoposition != null) {
      return getGeoposition();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAndRequestPermissionEvent value)
        checkAndRequestPermission,
    required TResult Function(_GetGeopositionEvent value) getGeoposition,
  }) {
    return getGeoposition(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_CheckAndRequestPermissionEvent value)?
        checkAndRequestPermission,
    TResult Function(_GetGeopositionEvent value)? getGeoposition,
  }) {
    return getGeoposition?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAndRequestPermissionEvent value)?
        checkAndRequestPermission,
    TResult Function(_GetGeopositionEvent value)? getGeoposition,
    required TResult orElse(),
  }) {
    if (getGeoposition != null) {
      return getGeoposition(this);
    }
    return orElse();
  }
}

abstract class _GetGeopositionEvent implements GeopositionEvent {
  const factory _GetGeopositionEvent() = _$_GetGeopositionEvent;
}

/// @nodoc
mixin _$GeopositionState {
  GeopositionStatus get status => throw _privateConstructorUsedError;
  Geoposition get geoposition => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        initial,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        getStatusInProgress,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        getPositionInProgress,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        succsess,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        initial,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getStatusInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getPositionInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        succsess,
    TResult Function(GeopositionStatus status, Geoposition geoposition)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        initial,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getStatusInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getPositionInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        succsess,
    TResult Function(GeopositionStatus status, Geoposition geoposition)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initial,
    required TResult Function(_GetStatusInProgressState value)
        getStatusInProgress,
    required TResult Function(_GetPositionInProgressState value)
        getPositionInProgress,
    required TResult Function(_SuccsessState value) succsess,
    required TResult Function(_ErrorState value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_GetStatusInProgressState value)? getStatusInProgress,
    TResult Function(_GetPositionInProgressState value)? getPositionInProgress,
    TResult Function(_SuccsessState value)? succsess,
    TResult Function(_ErrorState value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_GetStatusInProgressState value)? getStatusInProgress,
    TResult Function(_GetPositionInProgressState value)? getPositionInProgress,
    TResult Function(_SuccsessState value)? succsess,
    TResult Function(_ErrorState value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GeopositionStateCopyWith<GeopositionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeopositionStateCopyWith<$Res> {
  factory $GeopositionStateCopyWith(
          GeopositionState value, $Res Function(GeopositionState) then) =
      _$GeopositionStateCopyWithImpl<$Res>;
  $Res call({GeopositionStatus status, Geoposition geoposition});
}

/// @nodoc
class _$GeopositionStateCopyWithImpl<$Res>
    implements $GeopositionStateCopyWith<$Res> {
  _$GeopositionStateCopyWithImpl(this._value, this._then);

  final GeopositionState _value;
  // ignore: unused_field
  final $Res Function(GeopositionState) _then;

  @override
  $Res call({
    Object? status = freezed,
    Object? geoposition = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GeopositionStatus,
      geoposition: geoposition == freezed
          ? _value.geoposition
          : geoposition // ignore: cast_nullable_to_non_nullable
              as Geoposition,
    ));
  }
}

/// @nodoc
abstract class _$$_InitialStateCopyWith<$Res>
    implements $GeopositionStateCopyWith<$Res> {
  factory _$$_InitialStateCopyWith(
          _$_InitialState value, $Res Function(_$_InitialState) then) =
      __$$_InitialStateCopyWithImpl<$Res>;
  @override
  $Res call({GeopositionStatus status, Geoposition geoposition});
}

/// @nodoc
class __$$_InitialStateCopyWithImpl<$Res>
    extends _$GeopositionStateCopyWithImpl<$Res>
    implements _$$_InitialStateCopyWith<$Res> {
  __$$_InitialStateCopyWithImpl(
      _$_InitialState _value, $Res Function(_$_InitialState) _then)
      : super(_value, (v) => _then(v as _$_InitialState));

  @override
  _$_InitialState get _value => super._value as _$_InitialState;

  @override
  $Res call({
    Object? status = freezed,
    Object? geoposition = freezed,
  }) {
    return _then(_$_InitialState(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GeopositionStatus,
      geoposition: geoposition == freezed
          ? _value.geoposition
          : geoposition // ignore: cast_nullable_to_non_nullable
              as Geoposition,
    ));
  }
}

/// @nodoc

class _$_InitialState implements _InitialState {
  const _$_InitialState(
      {this.status = GeopositionStatus.denied,
      this.geoposition = const Geoposition.notReceived()});

  @override
  @JsonKey()
  final GeopositionStatus status;
  @override
  @JsonKey()
  final Geoposition geoposition;

  @override
  String toString() {
    return 'GeopositionState.initial(status: $status, geoposition: $geoposition)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InitialState &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.geoposition, geoposition));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(geoposition));

  @JsonKey(ignore: true)
  @override
  _$$_InitialStateCopyWith<_$_InitialState> get copyWith =>
      __$$_InitialStateCopyWithImpl<_$_InitialState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        initial,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        getStatusInProgress,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        getPositionInProgress,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        succsess,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        error,
  }) {
    return initial(status, geoposition);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        initial,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getStatusInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getPositionInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        succsess,
    TResult Function(GeopositionStatus status, Geoposition geoposition)? error,
  }) {
    return initial?.call(status, geoposition);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        initial,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getStatusInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getPositionInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        succsess,
    TResult Function(GeopositionStatus status, Geoposition geoposition)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(status, geoposition);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initial,
    required TResult Function(_GetStatusInProgressState value)
        getStatusInProgress,
    required TResult Function(_GetPositionInProgressState value)
        getPositionInProgress,
    required TResult Function(_SuccsessState value) succsess,
    required TResult Function(_ErrorState value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_GetStatusInProgressState value)? getStatusInProgress,
    TResult Function(_GetPositionInProgressState value)? getPositionInProgress,
    TResult Function(_SuccsessState value)? succsess,
    TResult Function(_ErrorState value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_GetStatusInProgressState value)? getStatusInProgress,
    TResult Function(_GetPositionInProgressState value)? getPositionInProgress,
    TResult Function(_SuccsessState value)? succsess,
    TResult Function(_ErrorState value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _InitialState implements GeopositionState {
  const factory _InitialState(
      {final GeopositionStatus status,
      final Geoposition geoposition}) = _$_InitialState;

  @override
  GeopositionStatus get status => throw _privateConstructorUsedError;
  @override
  Geoposition get geoposition => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_InitialStateCopyWith<_$_InitialState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_GetStatusInProgressStateCopyWith<$Res>
    implements $GeopositionStateCopyWith<$Res> {
  factory _$$_GetStatusInProgressStateCopyWith(
          _$_GetStatusInProgressState value,
          $Res Function(_$_GetStatusInProgressState) then) =
      __$$_GetStatusInProgressStateCopyWithImpl<$Res>;
  @override
  $Res call({GeopositionStatus status, Geoposition geoposition});
}

/// @nodoc
class __$$_GetStatusInProgressStateCopyWithImpl<$Res>
    extends _$GeopositionStateCopyWithImpl<$Res>
    implements _$$_GetStatusInProgressStateCopyWith<$Res> {
  __$$_GetStatusInProgressStateCopyWithImpl(_$_GetStatusInProgressState _value,
      $Res Function(_$_GetStatusInProgressState) _then)
      : super(_value, (v) => _then(v as _$_GetStatusInProgressState));

  @override
  _$_GetStatusInProgressState get _value =>
      super._value as _$_GetStatusInProgressState;

  @override
  $Res call({
    Object? status = freezed,
    Object? geoposition = freezed,
  }) {
    return _then(_$_GetStatusInProgressState(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GeopositionStatus,
      geoposition: geoposition == freezed
          ? _value.geoposition
          : geoposition // ignore: cast_nullable_to_non_nullable
              as Geoposition,
    ));
  }
}

/// @nodoc

class _$_GetStatusInProgressState implements _GetStatusInProgressState {
  const _$_GetStatusInProgressState(
      {this.status = GeopositionStatus.denied,
      this.geoposition = const Geoposition.notReceived()});

  @override
  @JsonKey()
  final GeopositionStatus status;
  @override
  @JsonKey()
  final Geoposition geoposition;

  @override
  String toString() {
    return 'GeopositionState.getStatusInProgress(status: $status, geoposition: $geoposition)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetStatusInProgressState &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.geoposition, geoposition));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(geoposition));

  @JsonKey(ignore: true)
  @override
  _$$_GetStatusInProgressStateCopyWith<_$_GetStatusInProgressState>
      get copyWith => __$$_GetStatusInProgressStateCopyWithImpl<
          _$_GetStatusInProgressState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        initial,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        getStatusInProgress,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        getPositionInProgress,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        succsess,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        error,
  }) {
    return getStatusInProgress(status, geoposition);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        initial,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getStatusInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getPositionInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        succsess,
    TResult Function(GeopositionStatus status, Geoposition geoposition)? error,
  }) {
    return getStatusInProgress?.call(status, geoposition);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        initial,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getStatusInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getPositionInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        succsess,
    TResult Function(GeopositionStatus status, Geoposition geoposition)? error,
    required TResult orElse(),
  }) {
    if (getStatusInProgress != null) {
      return getStatusInProgress(status, geoposition);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initial,
    required TResult Function(_GetStatusInProgressState value)
        getStatusInProgress,
    required TResult Function(_GetPositionInProgressState value)
        getPositionInProgress,
    required TResult Function(_SuccsessState value) succsess,
    required TResult Function(_ErrorState value) error,
  }) {
    return getStatusInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_GetStatusInProgressState value)? getStatusInProgress,
    TResult Function(_GetPositionInProgressState value)? getPositionInProgress,
    TResult Function(_SuccsessState value)? succsess,
    TResult Function(_ErrorState value)? error,
  }) {
    return getStatusInProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_GetStatusInProgressState value)? getStatusInProgress,
    TResult Function(_GetPositionInProgressState value)? getPositionInProgress,
    TResult Function(_SuccsessState value)? succsess,
    TResult Function(_ErrorState value)? error,
    required TResult orElse(),
  }) {
    if (getStatusInProgress != null) {
      return getStatusInProgress(this);
    }
    return orElse();
  }
}

abstract class _GetStatusInProgressState implements GeopositionState {
  const factory _GetStatusInProgressState(
      {final GeopositionStatus status,
      final Geoposition geoposition}) = _$_GetStatusInProgressState;

  @override
  GeopositionStatus get status => throw _privateConstructorUsedError;
  @override
  Geoposition get geoposition => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_GetStatusInProgressStateCopyWith<_$_GetStatusInProgressState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_GetPositionInProgressStateCopyWith<$Res>
    implements $GeopositionStateCopyWith<$Res> {
  factory _$$_GetPositionInProgressStateCopyWith(
          _$_GetPositionInProgressState value,
          $Res Function(_$_GetPositionInProgressState) then) =
      __$$_GetPositionInProgressStateCopyWithImpl<$Res>;
  @override
  $Res call({GeopositionStatus status, Geoposition geoposition});
}

/// @nodoc
class __$$_GetPositionInProgressStateCopyWithImpl<$Res>
    extends _$GeopositionStateCopyWithImpl<$Res>
    implements _$$_GetPositionInProgressStateCopyWith<$Res> {
  __$$_GetPositionInProgressStateCopyWithImpl(
      _$_GetPositionInProgressState _value,
      $Res Function(_$_GetPositionInProgressState) _then)
      : super(_value, (v) => _then(v as _$_GetPositionInProgressState));

  @override
  _$_GetPositionInProgressState get _value =>
      super._value as _$_GetPositionInProgressState;

  @override
  $Res call({
    Object? status = freezed,
    Object? geoposition = freezed,
  }) {
    return _then(_$_GetPositionInProgressState(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GeopositionStatus,
      geoposition: geoposition == freezed
          ? _value.geoposition
          : geoposition // ignore: cast_nullable_to_non_nullable
              as Geoposition,
    ));
  }
}

/// @nodoc

class _$_GetPositionInProgressState implements _GetPositionInProgressState {
  const _$_GetPositionInProgressState(
      {required this.status,
      this.geoposition = const Geoposition.notReceived()});

  @override
  final GeopositionStatus status;
  @override
  @JsonKey()
  final Geoposition geoposition;

  @override
  String toString() {
    return 'GeopositionState.getPositionInProgress(status: $status, geoposition: $geoposition)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetPositionInProgressState &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.geoposition, geoposition));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(geoposition));

  @JsonKey(ignore: true)
  @override
  _$$_GetPositionInProgressStateCopyWith<_$_GetPositionInProgressState>
      get copyWith => __$$_GetPositionInProgressStateCopyWithImpl<
          _$_GetPositionInProgressState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        initial,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        getStatusInProgress,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        getPositionInProgress,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        succsess,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        error,
  }) {
    return getPositionInProgress(status, geoposition);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        initial,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getStatusInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getPositionInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        succsess,
    TResult Function(GeopositionStatus status, Geoposition geoposition)? error,
  }) {
    return getPositionInProgress?.call(status, geoposition);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        initial,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getStatusInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getPositionInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        succsess,
    TResult Function(GeopositionStatus status, Geoposition geoposition)? error,
    required TResult orElse(),
  }) {
    if (getPositionInProgress != null) {
      return getPositionInProgress(status, geoposition);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initial,
    required TResult Function(_GetStatusInProgressState value)
        getStatusInProgress,
    required TResult Function(_GetPositionInProgressState value)
        getPositionInProgress,
    required TResult Function(_SuccsessState value) succsess,
    required TResult Function(_ErrorState value) error,
  }) {
    return getPositionInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_GetStatusInProgressState value)? getStatusInProgress,
    TResult Function(_GetPositionInProgressState value)? getPositionInProgress,
    TResult Function(_SuccsessState value)? succsess,
    TResult Function(_ErrorState value)? error,
  }) {
    return getPositionInProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_GetStatusInProgressState value)? getStatusInProgress,
    TResult Function(_GetPositionInProgressState value)? getPositionInProgress,
    TResult Function(_SuccsessState value)? succsess,
    TResult Function(_ErrorState value)? error,
    required TResult orElse(),
  }) {
    if (getPositionInProgress != null) {
      return getPositionInProgress(this);
    }
    return orElse();
  }
}

abstract class _GetPositionInProgressState implements GeopositionState {
  const factory _GetPositionInProgressState(
      {required final GeopositionStatus status,
      final Geoposition geoposition}) = _$_GetPositionInProgressState;

  @override
  GeopositionStatus get status => throw _privateConstructorUsedError;
  @override
  Geoposition get geoposition => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_GetPositionInProgressStateCopyWith<_$_GetPositionInProgressState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_SuccsessStateCopyWith<$Res>
    implements $GeopositionStateCopyWith<$Res> {
  factory _$$_SuccsessStateCopyWith(
          _$_SuccsessState value, $Res Function(_$_SuccsessState) then) =
      __$$_SuccsessStateCopyWithImpl<$Res>;
  @override
  $Res call({GeopositionStatus status, Geoposition geoposition});
}

/// @nodoc
class __$$_SuccsessStateCopyWithImpl<$Res>
    extends _$GeopositionStateCopyWithImpl<$Res>
    implements _$$_SuccsessStateCopyWith<$Res> {
  __$$_SuccsessStateCopyWithImpl(
      _$_SuccsessState _value, $Res Function(_$_SuccsessState) _then)
      : super(_value, (v) => _then(v as _$_SuccsessState));

  @override
  _$_SuccsessState get _value => super._value as _$_SuccsessState;

  @override
  $Res call({
    Object? status = freezed,
    Object? geoposition = freezed,
  }) {
    return _then(_$_SuccsessState(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GeopositionStatus,
      geoposition: geoposition == freezed
          ? _value.geoposition
          : geoposition // ignore: cast_nullable_to_non_nullable
              as Geoposition,
    ));
  }
}

/// @nodoc

class _$_SuccsessState implements _SuccsessState {
  const _$_SuccsessState({required this.status, required this.geoposition});

  @override
  final GeopositionStatus status;
  @override
  final Geoposition geoposition;

  @override
  String toString() {
    return 'GeopositionState.succsess(status: $status, geoposition: $geoposition)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SuccsessState &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.geoposition, geoposition));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(geoposition));

  @JsonKey(ignore: true)
  @override
  _$$_SuccsessStateCopyWith<_$_SuccsessState> get copyWith =>
      __$$_SuccsessStateCopyWithImpl<_$_SuccsessState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        initial,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        getStatusInProgress,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        getPositionInProgress,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        succsess,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        error,
  }) {
    return succsess(status, geoposition);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        initial,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getStatusInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getPositionInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        succsess,
    TResult Function(GeopositionStatus status, Geoposition geoposition)? error,
  }) {
    return succsess?.call(status, geoposition);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        initial,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getStatusInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getPositionInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        succsess,
    TResult Function(GeopositionStatus status, Geoposition geoposition)? error,
    required TResult orElse(),
  }) {
    if (succsess != null) {
      return succsess(status, geoposition);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initial,
    required TResult Function(_GetStatusInProgressState value)
        getStatusInProgress,
    required TResult Function(_GetPositionInProgressState value)
        getPositionInProgress,
    required TResult Function(_SuccsessState value) succsess,
    required TResult Function(_ErrorState value) error,
  }) {
    return succsess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_GetStatusInProgressState value)? getStatusInProgress,
    TResult Function(_GetPositionInProgressState value)? getPositionInProgress,
    TResult Function(_SuccsessState value)? succsess,
    TResult Function(_ErrorState value)? error,
  }) {
    return succsess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_GetStatusInProgressState value)? getStatusInProgress,
    TResult Function(_GetPositionInProgressState value)? getPositionInProgress,
    TResult Function(_SuccsessState value)? succsess,
    TResult Function(_ErrorState value)? error,
    required TResult orElse(),
  }) {
    if (succsess != null) {
      return succsess(this);
    }
    return orElse();
  }
}

abstract class _SuccsessState implements GeopositionState {
  const factory _SuccsessState(
      {required final GeopositionStatus status,
      required final Geoposition geoposition}) = _$_SuccsessState;

  @override
  GeopositionStatus get status => throw _privateConstructorUsedError;
  @override
  Geoposition get geoposition => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_SuccsessStateCopyWith<_$_SuccsessState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ErrorStateCopyWith<$Res>
    implements $GeopositionStateCopyWith<$Res> {
  factory _$$_ErrorStateCopyWith(
          _$_ErrorState value, $Res Function(_$_ErrorState) then) =
      __$$_ErrorStateCopyWithImpl<$Res>;
  @override
  $Res call({GeopositionStatus status, Geoposition geoposition});
}

/// @nodoc
class __$$_ErrorStateCopyWithImpl<$Res>
    extends _$GeopositionStateCopyWithImpl<$Res>
    implements _$$_ErrorStateCopyWith<$Res> {
  __$$_ErrorStateCopyWithImpl(
      _$_ErrorState _value, $Res Function(_$_ErrorState) _then)
      : super(_value, (v) => _then(v as _$_ErrorState));

  @override
  _$_ErrorState get _value => super._value as _$_ErrorState;

  @override
  $Res call({
    Object? status = freezed,
    Object? geoposition = freezed,
  }) {
    return _then(_$_ErrorState(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GeopositionStatus,
      geoposition: geoposition == freezed
          ? _value.geoposition
          : geoposition // ignore: cast_nullable_to_non_nullable
              as Geoposition,
    ));
  }
}

/// @nodoc

class _$_ErrorState implements _ErrorState {
  const _$_ErrorState(
      {required this.status,
      this.geoposition = const Geoposition.notReceived()});

  @override
  final GeopositionStatus status;
  @override
  @JsonKey()
  final Geoposition geoposition;

  @override
  String toString() {
    return 'GeopositionState.error(status: $status, geoposition: $geoposition)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ErrorState &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.geoposition, geoposition));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(geoposition));

  @JsonKey(ignore: true)
  @override
  _$$_ErrorStateCopyWith<_$_ErrorState> get copyWith =>
      __$$_ErrorStateCopyWithImpl<_$_ErrorState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        initial,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        getStatusInProgress,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        getPositionInProgress,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        succsess,
    required TResult Function(GeopositionStatus status, Geoposition geoposition)
        error,
  }) {
    return error(status, geoposition);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        initial,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getStatusInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getPositionInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        succsess,
    TResult Function(GeopositionStatus status, Geoposition geoposition)? error,
  }) {
    return error?.call(status, geoposition);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        initial,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getStatusInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        getPositionInProgress,
    TResult Function(GeopositionStatus status, Geoposition geoposition)?
        succsess,
    TResult Function(GeopositionStatus status, Geoposition geoposition)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(status, geoposition);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialState value) initial,
    required TResult Function(_GetStatusInProgressState value)
        getStatusInProgress,
    required TResult Function(_GetPositionInProgressState value)
        getPositionInProgress,
    required TResult Function(_SuccsessState value) succsess,
    required TResult Function(_ErrorState value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_GetStatusInProgressState value)? getStatusInProgress,
    TResult Function(_GetPositionInProgressState value)? getPositionInProgress,
    TResult Function(_SuccsessState value)? succsess,
    TResult Function(_ErrorState value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialState value)? initial,
    TResult Function(_GetStatusInProgressState value)? getStatusInProgress,
    TResult Function(_GetPositionInProgressState value)? getPositionInProgress,
    TResult Function(_SuccsessState value)? succsess,
    TResult Function(_ErrorState value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ErrorState implements GeopositionState {
  const factory _ErrorState(
      {required final GeopositionStatus status,
      final Geoposition geoposition}) = _$_ErrorState;

  @override
  GeopositionStatus get status => throw _privateConstructorUsedError;
  @override
  Geoposition get geoposition => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ErrorStateCopyWith<_$_ErrorState> get copyWith =>
      throw _privateConstructorUsedError;
}
