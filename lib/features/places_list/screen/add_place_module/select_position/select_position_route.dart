import 'package:flutter/material.dart';
import 'package:places/features/common/domain/entity/geoposition.dart';
import 'package:places/features/places_list/screen/add_place_module/select_position/select_position_screen.dart';

class SelectPositionRoute extends ModalRoute<Geoposition?> {
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

  SelectPositionRoute(Geoposition? position)
      : super(settings: RouteSettings(arguments: position));

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: SelectPositionScreen(
          selectPosition: settings.arguments as Geoposition?,
        ),
      ),
    );
  }
}
