import 'package:flutter/material.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/places_list/screen/add_place_module/select_category/select_category_screen.dart';

class SelectCategoryRoute extends ModalRoute<PlaceType?> {
  @override
  Duration get transitionDuration => Duration.zero;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  SelectCategoryRoute(PlaceType? type)
      : super(settings: RouteSettings(arguments: type));

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: SelectCategoryScreen(type: settings.arguments as PlaceType?),
      ),
    );
  }
}
