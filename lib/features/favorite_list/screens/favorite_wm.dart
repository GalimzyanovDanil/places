import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/favorite_list/screens/favorite_model.dart';
import 'package:places/features/favorite_list/screens/favorite_screen.dart';
import 'package:places/features/navigation/domain/entity/app_coordinate.dart';
import 'package:places/features/navigation/service/coordinator.dart';
import 'package:places/features/place_details/widgets/date_picker_factory.dart';
import 'package:provider/provider.dart';
import 'package:surf_lint_rules/surf_lint_rules.dart';

abstract class IFavoriteWidgetModel extends IWidgetModel {
  ListenableState<List<Place>> get placesState;
  ThemeData get theme;
  DateFormat get dateFormat;
  Future<void> onDelete(int index);
  Future<void> onTapPlanned(int index);
  void onTapCard(int index);
  void onBackButtonTap();
}

FavoriteWidgetModel defaultFavoriteWidgetModelFactory(BuildContext context) {
  final appScope = context.read<IAppScope>();
  final model = FavoriteModel(appScope.favoriteDbService);

  return FavoriteWidgetModel(
    model: model,
    coordinator: appScope.coordinator,
  );
}

// TODO(me): cover with documentation
/// Default widget model for FavoriteWidget
class FavoriteWidgetModel extends WidgetModel<FavoriteScreen, FavoriteModel>
    implements IFavoriteWidgetModel {
  final Coordinator _coordinator;
  final StateNotifier<List<Place>> _placesState = StateNotifier();
  final _dateFormat = DateFormat('d MMM y', 'ru_RU');

  @override
  ListenableState<List<Place>> get placesState => _placesState;

  @override
  ThemeData get theme => Theme.of(context);

  @override
  DateFormat get dateFormat => _dateFormat;

  DateTime? _plannedDate;

  FavoriteWidgetModel({
    required FavoriteModel model,
    required Coordinator coordinator,
  })  : _coordinator = coordinator,
        super(model) {
    _getFavoriteList();
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _getFavoriteList();
  }

  @override
  Future<void> onDelete(int index) async {
    assert(_placesState.value?[index] != null,
        'Cards builds from list in placesstate.value');
    unawaited(model.deleteFavorite(_placesState.value![index].id));
    await _getFavoriteList();
  }

  @override
  Future<void> onTapPlanned(int index) async {
    await _selectDate(index);

    if (_plannedDate != null) {
      assert(_plannedDate != null, 'Planned date can not be null');

      assert(_placesState.value?[index] != null,
          'Cards builds from list in placesstate.value');
      await model.addFavorite(
        _placesState.value![index].copyWith(plannedDate: _plannedDate),
      );
      await _getFavoriteList();
    }
  }

  @override
  void onTapCard(int index) {
    assert(_placesState.value?[index] != null,
        'Cards builds from list in placesstate.value');
    _coordinator.navigate(
      context,
      AppCoordinate.detailsPlaceScreen,
      arguments: _placesState.value![index],
    );
  }

  @override
  void onBackButtonTap() {
    _coordinator.pop(context);
  }

  Future<void> _getFavoriteList() async {
    final favoriteList = await model.allFavoriteEntries();
    _placesState.accept(favoriteList);
  }

  Future<void> _selectDate(int index) async {
    await datePickerFactory(
      context: context,
      initialDate: _placesState.value![index].plannedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2122),
      onDateTimeChanged: (newDate) => _plannedDate = newDate,
    );
  }
}
