import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/place_details/screen/place_details_model.dart';
import 'package:places/features/place_details/screen/place_details_screen.dart';
import 'package:provider/provider.dart';

enum PlannedButtonState { disable, active, haveDate, share }

abstract class IPlaceDetailsWidgetModel extends IWidgetModel {}

PlaceDetailsWidgetModel defaultPlaceDetailsWidgetModelFactory(
    BuildContext context) {
  final appScope = context.read<IAppScope>();
  final model = PlaceDetailsModel(appScope.errorHandler);
  return PlaceDetailsWidgetModel(model);
}

// TODO: cover with documentation
/// Default widget model for PlaceDetailsWidget
class PlaceDetailsWidgetModel
    extends WidgetModel<PlaceDetailsScreen, PlaceDetailsModel>
    implements IPlaceDetailsWidgetModel {
  PlaceDetailsWidgetModel(PlaceDetailsModel model) : super(model);
}
