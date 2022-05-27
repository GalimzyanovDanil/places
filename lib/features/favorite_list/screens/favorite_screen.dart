import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/favorite_list/screens/favorite_wm.dart';

// TODO: cover with documentation
/// Main widget for Favorite module
class FavoriteScreen extends ElementaryWidget<IFavoriteWidgetModel> {
  const FavoriteScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultFavoriteWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IFavoriteWidgetModel wm) {
    return const Scaffold(
      body: Center(
        child: Text('FAVORITE'),
      ),
    );
  }
}
