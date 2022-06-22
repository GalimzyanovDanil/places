import 'package:flutter/material.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/widgets/network_image_widget.dart';
import 'package:places/features/places_list/screen/places_list_module/favorite_button/favorite_button_widget.dart';
import 'package:places/features/places_list/widgets/place_list_widgets/description_widget.dart';

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
              child: FavoriteButtonWidget(
                place: place,
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                place.placeType.title,
                style: theme.textTheme.subtitle2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
