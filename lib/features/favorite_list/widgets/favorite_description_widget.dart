import 'package:flutter/material.dart';
import 'package:places/features/favorite_list/strings/favorite_screen_strings.dart';

class FavoriteDescriptionWidget extends StatelessWidget {
  final String name;
  final String description;
  final String? plannedDate;

  const FavoriteDescriptionWidget({
    required this.name,
    required this.description,
    this.plannedDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              name,
              style: theme.textTheme.headline3,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            if (plannedDate != null)
              Text(
                FavoriteScreenStrings.planned + plannedDate!,
                style: theme.textTheme.subtitle1
                    ?.copyWith(color: theme.colorScheme.primary),
              )
            else
              const SizedBox.shrink(),
            Text(
              description,
              style: theme.textTheme.subtitle1,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
