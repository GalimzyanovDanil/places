import 'package:flutter/material.dart';
import 'package:places/features/common/domain/entity/place.dart';

class DetailsContentWidget extends StatelessWidget {
  final Place place;
  const DetailsContentWidget({required this.place, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          place.name,
          style: textTheme.headline2
              ?.copyWith(color: theme.colorScheme.onSecondaryContainer),
        ),
        const SizedBox(height: 2),
        Text(
          place.placeType.title,
          style: textTheme.subtitle2?.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          place.description,
          style: textTheme.subtitle1?.copyWith(
            color: colorScheme.onSecondaryContainer,
          ),
        ),
      ],
    );
  }
}
