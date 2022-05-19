import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/assets/colors/app_colors.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/places_list/widgets/place_card_widget/description_widget.dart';
import 'package:places/features/places_list/widgets/place_card_widget/network_image_widget.dart';

/// [onTapCard] - Открытие делальной информации места
/// [onTapFavorite] - Добавление/удаление в избранное
/// [placeType] - Тип места
/// [imageUrl] - Ссылка на изображение
/// [name] - Имя места
/// [description] - Краткое описание
class PlaceCardWidget extends StatelessWidget {
  final void Function() onTapCard;
  final void Function() onTapFavorite;
  final bool isFavorite;
  final String placeType;
  final String imageUrl;
  final String name;
  final String description;

  const PlaceCardWidget({
    required this.onTapCard,
    required this.onTapFavorite,
    required this.isFavorite,
    required this.placeType,
    required this.imageUrl,
    required this.name,
    required this.description,
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
                          imageUrl: imageUrl,
                        ),
                      ),
                      Expanded(
                        child: DescriptionWidget(
                          name: name,
                          description: description,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onTapCard,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 16,
              right: 16,
              child: _FavoriteButtonWidget(
                onTapFavorite: onTapFavorite,
                isFavorite: isFavorite,
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                placeType,
                style: theme.textTheme.subtitle2,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _FavoriteButtonWidget extends StatelessWidget {
  const _FavoriteButtonWidget({
    required this.onTapFavorite,
    required this.isFavorite,
    Key? key,
  }) : super(key: key);

  final void Function() onTapFavorite;
  final bool isFavorite;

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
