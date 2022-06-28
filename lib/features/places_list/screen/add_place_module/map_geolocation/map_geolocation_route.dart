import 'package:flutter/material.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/places_list/screen/add_place_module/map_geolocation/map_geolocation.dart';

class MapGeolocationRoute extends ModalRoute<PlaceType?> {
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

  MapGeolocationRoute();

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Scaffold(
          body: MapPicker(
            onCancel: () {},
            onDone: (a) {
              // ignore: avoid_print
              print(a);
            },
          ),
        ),
      ),
    );
  }
}
