import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/assets/colors/app_colors.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/places_list/domain/entity/place.dart';
import 'package:places/features/places_list/widgets/place_card_widgets/description_widget.dart';
import 'package:places/features/common/widgets/network_image_widget.dart';

/// [onTapCard] - Открытие делальной информации места
/// [place] - Данные места
class PlaceCardWidget extends StatelessWidget {
  final ValueChanged<int> onTapCard;
  final Place place;
  final int index;

  const PlaceCardWidget({
    required this.onTapCard,
    required this.place,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Material(
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        color: theme.primaryColor,
        child: Stack(
          children: [
            Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: NetworkImageWidget(
                          imageUrl:
                              place.urls.isNotEmpty ? place.urls.first : '',
                        ),
                      ),
                      Expanded(
                        child: DescriptionWidget(
                          name: place.name,
                          description: place.description,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => onTapCard(index),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 16,
              right: 16,
              child: _FavoriteButtonWidget(),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                place.placeType.title,
                style: theme.textTheme.subtitle2,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// TODO: Сделать отдельный элементари модуль
class _FavoriteButtonWidget extends StatelessWidget {
  _FavoriteButtonWidget({
    Key? key,
  }) : super(key: key);

  // ignore: prefer_function_declarations_over_variables
  final onTapFavorite = () {};
  final bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTapFavorite,
      child: SvgPicture.asset(
        isFavorite ? AppAssets.iconFavoriteFill : AppAssets.iconFavorite,
        color: AppColors.whiteBase,
      ),
    );
  }
}
