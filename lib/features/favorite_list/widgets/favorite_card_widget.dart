import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:places/assets/colors/app_colors.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/widgets/network_image_widget.dart';
import 'package:places/features/favorite_list/strings/favorite_screen_strings.dart';
import 'package:places/features/favorite_list/widgets/favorite_description_widget.dart';

/// [onTapCard] - Открытие делальной информации места
/// [place] - Данные места
class FavoriteCardWidget extends StatelessWidget {
  final ValueChanged<int> onTapCard;
  final ValueChanged<int> onDelete;
  final ValueChanged<int> onPlanned;
  final Place place;
  final int index;
  final DateFormat dateFormat;

  const FavoriteCardWidget({
    required this.onTapCard,
    required this.onDelete,
    required this.onPlanned,
    required this.place,
    required this.index,
    required this.dateFormat,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onDeleteColor = theme.colorScheme.onError;

    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colorScheme.error,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16.0),
                bottom: Radius.circular(12.0),
              ),
            ),
          ),
        ),
        Positioned(
          right: 16.0,
          child: Column(
            children: [
              SvgPicture.asset(
                AppAssets.iconBucket,
                color: onDeleteColor,
              ),
              const SizedBox(height: 8),
              Text(
                FavoriteScreenStrings.delete,
                style: theme.textTheme.headline6?.copyWith(
                  color: onDeleteColor,
                ),
              ),
            ],
          ),
        ),
        Dismissible(
          direction: DismissDirection.endToStart,
          key: Key(place.name),
          onDismissed: (_) => onDelete(index),
          child: AspectRatio(
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
                                imageUrl: place.urls.isNotEmpty
                                    ? place.urls.first
                                    : '',
                              ),
                            ),
                            Expanded(
                              child: FavoriteDescriptionWidget(
                                name: place.name,
                                description: place.description,
                                plannedDate: place.plannedDate != null
                                    ? dateFormat.format(place.plannedDate!)
                                    : null,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () => onPlanned(index),
                          child: SvgPicture.asset(
                            AppAssets.iconCalendar,
                            color: AppColors.whiteBase,
                          ),
                        ),
                        const SizedBox(width: 25),
                        InkWell(
                          onTap: () => onDelete(index),
                          child: SvgPicture.asset(
                            AppAssets.iconDelete,
                            color: AppColors.whiteBase,
                          ),
                        ),
                      ],
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
          ),
        ),
      ],
    );
  }
}
