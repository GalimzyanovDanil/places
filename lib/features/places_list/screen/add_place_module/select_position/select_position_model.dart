import 'package:elementary/elementary.dart';
import 'package:places/features/common/service/geoposition_bloc/geoposition_bloc.dart';

// TODO: cover with documentation
/// Default Elementary model for SelectPosition module
class SelectPositionModel extends ElementaryModel {
  final GeopositionBloc _geopositionBloc;
  Stream<GeopositionState> get geopositionState => _geopositionBloc.stream;
  GeopositionState get state => _geopositionBloc.state;
  SelectPositionModel(this._geopositionBloc);

  @override
  void init() {
    super.init();
    getCurrentGeoposition();
  }

  void getCurrentGeoposition() =>
      _geopositionBloc.add(const GeopositionEvent.getGeoposition());
}
