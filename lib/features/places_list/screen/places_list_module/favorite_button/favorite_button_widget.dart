import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/assets/colors/app_colors.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/places_list/screen/places_list_module/favorite_button/favorite_button_wm.dart';

// TODO: cover with documentation
/// Main widget for FavoriteButton module
class FavoriteButtonWidget
    extends ElementaryWidget<IFavoriteButtonWidgetModel> {
  final Place place;

  const FavoriteButtonWidget({
    required this.place,
    Key? key,
    WidgetModelFactory wmFactory = defaultFavoriteButtonWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IFavoriteButtonWidgetModel wm) {
    return StateNotifierBuilder<bool>(
      listenableState: wm.favoriteState,
      builder: (_, isFavorite) {
        assert(isFavorite != null,
            'isFavorite value can not be a null. Set default value');

        return InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: wm.onTap,
          child: SvgPicture.asset(
            isFavorite! ? AppAssets.iconFavoriteFill : AppAssets.iconFavorite,
            color: AppColors.whiteBase,
          ),
        );
      },
    );
  }
}
