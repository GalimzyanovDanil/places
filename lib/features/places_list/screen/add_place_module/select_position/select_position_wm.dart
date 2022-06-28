import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/common/domain/entity/geoposition.dart';
import 'package:places/features/common/service/geoposition_bloc/geoposition_bloc.dart';
import 'package:places/features/places_list/screen/add_place_module/select_position/select_position_model.dart';
import 'package:places/features/places_list/screen/add_place_module/select_position/select_position_screen.dart';
import 'package:provider/provider.dart';

abstract class ISelectPositionWidgetModel extends IWidgetModel {
  ThemeData get theme;
  MapController get mapController;
  ListenableState<Geoposition> get currentPositionState;
  ListenableState<Geoposition> get selectPositionState;
  void onCancelButton();
  void onAcceptButton();
  void onMoveCurrentPosition();
  void onMapCreated(MapController controller);
  void onChangeMarker(Geoposition position);
}

SelectPositionWidgetModel defaultSelectPositionWidgetModelFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();
  final model = SelectPositionModel(appScope.geopositionBloc);
  return SelectPositionWidgetModel(model);
}

// TODO: cover with documentation
/// Default widget model for SelectPositionWidget
class SelectPositionWidgetModel
    extends WidgetModel<SelectPositionScreen, SelectPositionModel>
    implements ISelectPositionWidgetModel {
  late final StateNotifier<Geoposition> _currentPositionState;
  final _markerPositionState = StateNotifier<Geoposition>();
  late final StreamSubscription<GeopositionState> _streamSub;

  @override
  ThemeData get theme => Theme.of(context);

  @override
  MapController get mapController => _mapController;

  @override
  ListenableState<Geoposition> get currentPositionState =>
      _currentPositionState;

  @override
  ListenableState<Geoposition> get selectPositionState => _markerPositionState;

  late MapController _mapController;

  SelectPositionWidgetModel(SelectPositionModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _currentPositionState =
        StateNotifier<Geoposition>(initValue: model.state.geoposition);

    _mapController = MapController();

    _streamSub = model.geopositionState.listen((state) {
      state.whenOrNull<void>(
        succsess: (_, position) {
          _currentPositionState.accept(position);
          if (widget.selectPosition == null) onMoveCurrentPosition();
        },
      );
    });

    _markerPositionState.accept(widget.selectPosition);
  }

  @override
  void dispose() {
    _streamSub.cancel();
    _mapController.dispose();
    super.dispose();
  }

  @override
  void onAcceptButton() =>
      Navigator.of(context).pop(_markerPositionState.value);

  @override
  void onCancelButton() => Navigator.of(context).pop();

  @override
  void onMoveCurrentPosition() {
    final position = _currentPositionState.value!;
    _mapController.move(LatLng(position.latitude, position.longitude), 13);
  }

  @override
  void onMapCreated(MapController controller) {
    _mapController = controller;
  }

  @override
  void onChangeMarker(Geoposition position) {
    _markerPositionState.accept(position);
  }
}
