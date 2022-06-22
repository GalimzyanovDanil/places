import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/navigation/domain/entity/app_coordinate.dart';
import 'package:places/features/navigation/service/coordinator.dart';
import 'package:places/features/places_list/screen/add_place_module/add_place_screen.dart';
import 'package:places/features/places_list/screen/add_place_module/add_place_screen_model.dart';
import 'package:provider/provider.dart';

abstract class IAddPlaceScreenWidgetModel extends IWidgetModel {
  ThemeData get theme;
  void onSelectCategory();
}

AddPlaceScreenWidgetModel defaultAddPlaceScreenWidgetModelFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();

  final model = AddPlaceScreenModel();
  return AddPlaceScreenWidgetModel(
    model: model,
    coordinator: appScope.coordinator,
  );
}

// TODO: cover with documentation
/// Default widget model for AddPlaceScreenWidget
class AddPlaceScreenWidgetModel
    extends WidgetModel<AddPlaceScreen, AddPlaceScreenModel>
    implements IAddPlaceScreenWidgetModel {
  final Coordinator coordinator;
  late final PlaceType? selectCategory;

  @override
  ThemeData get theme => Theme.of(context);

  AddPlaceScreenWidgetModel({
    required this.coordinator,
    required AddPlaceScreenModel model,
  }) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    selectCategory = widget.type;
  }

  @override
  void onSelectCategory() {
    coordinator.navigate(
      context,
      AppCoordinate.selectCategory,
      arguments: selectCategory,
    );
  }
}
