import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/favorite_list/screens/favorite_model.dart';
import 'package:places/features/favorite_list/screens/favorite_screen.dart';

abstract class IFavoriteWidgetModel extends IWidgetModel {}

FavoriteWidgetModel defaultFavoriteWidgetModelFactory(BuildContext context) {
  final model = FavoriteModel();
  return FavoriteWidgetModel(model);
}

// TODO: cover with documentation
/// Default widget model for FavoriteWidget
class FavoriteWidgetModel extends WidgetModel<FavoriteScreen, FavoriteModel>
    implements IFavoriteWidgetModel {
  FavoriteWidgetModel(FavoriteModel model) : super(model);
}
