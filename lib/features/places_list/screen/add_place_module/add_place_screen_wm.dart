import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/places_list/screen/add_place_module/add_place_screen.dart';
import 'package:places/features/places_list/screen/add_place_module/add_place_screen_model.dart';

abstract class IAddPlaceScreenWidgetModel extends IWidgetModel {
  ThemeData get theme;
}

AddPlaceScreenWidgetModel defaultAddPlaceScreenWidgetModelFactory(
  BuildContext context,
) {
  final model = AddPlaceScreenModel();
  return AddPlaceScreenWidgetModel(model);
}

// TODO: cover with documentation
/// Default widget model for AddPlaceScreenWidget
class AddPlaceScreenWidgetModel
    extends WidgetModel<AddPlaceScreen, AddPlaceScreenModel>
    implements IAddPlaceScreenWidgetModel {
  @override
  ThemeData get theme => Theme.of(context);

  AddPlaceScreenWidgetModel(AddPlaceScreenModel model) : super(model);
}
