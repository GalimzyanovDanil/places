import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/widgets/emty_screen_widget.dart';
import 'package:places/features/favorite_list/screens/favorite_wm.dart';
import 'package:places/features/favorite_list/strings/favorite_screen_strings.dart';
import 'package:places/features/favorite_list/widgets/favorite_card_widget.dart';

// TODO(me): cover with documentation
/// Main widget for Favorite module
class FavoriteScreen extends ElementaryWidget<IFavoriteWidgetModel> {
  const FavoriteScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultFavoriteWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IFavoriteWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          FavoriteScreenStrings.title,
          style: wm.theme.textTheme.headline4,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
          child: StateNotifierBuilder<List<Place>>(
            listenableState: wm.placesState,
            builder: (_, favoriteList) => (favoriteList?.isNotEmpty ?? false)
                ? ListView.separated(
                    itemBuilder: (_, index) => FavoriteCardWidget(
                      onTapCard: wm.onTapCard,
                      onDelete: wm.onDelete,
                      onPlanned: wm.onTapPlanned,
                      place: favoriteList![index],
                      index: index,
                      dateFormat: wm.dateFormat,
                    ),
                    separatorBuilder: (_, __) => const SizedBox(height: 25),
                    itemCount: favoriteList?.length ?? 0,
                  )
                : const EmptyScreenWidget(
                    iconPath: AppAssets.iconEmptyFav1,
                    title: FavoriteScreenStrings.emtyTitle,
                    subtitle: FavoriteScreenStrings.emtySubtitle,
                  ),
          ),
        ),
      ),
    );
  }
}
