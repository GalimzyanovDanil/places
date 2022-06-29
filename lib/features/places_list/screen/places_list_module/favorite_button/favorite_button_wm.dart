import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/places_list/screen/places_list_module/favorite_button/favorite_button_model.dart';
import 'package:places/features/places_list/screen/places_list_module/favorite_button/favorite_button_widget.dart';
import 'package:provider/provider.dart';

abstract class IFavoriteButtonWidgetModel extends IWidgetModel {
  ListenableState<bool> get favoriteState;
  void onTap();
}

FavoriteButtonWidgetModel defaultFavoriteButtonWidgetModelFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();
  final model = FavoriteButtonModel(appScope.favoriteDbService);
  return FavoriteButtonWidgetModel(model);
}

// TODO(me): cover with documentation
/// Default widget model for FavoriteButtonWidget
class FavoriteButtonWidgetModel
    extends WidgetModel<FavoriteButtonWidget, FavoriteButtonModel>
    implements IFavoriteButtonWidgetModel {
  final StateNotifier<bool> _favoriteState = StateNotifier(initValue: false);

  @override
  ListenableState<bool> get favoriteState => _favoriteState;

  FavoriteButtonWidgetModel(FavoriteButtonModel model) : super(model);

  @override
  void onTap() {
    final prevValue = _favoriteState.value;

    if (prevValue!) {
      model.deleteFavorite(widget.place.id);
    } else {
      model.addFavorite(widget.place);
    }
    _favoriteState.accept(!prevValue);
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  Future<void> _init() async {
    final favoritePlaceOrNull =
        await model.checkPlaceIsFavorite(widget.place.id);
    if (favoritePlaceOrNull == null) {
      _favoriteState.accept(false);
    } else {
      _favoriteState.accept(true);
    }
  }
}
