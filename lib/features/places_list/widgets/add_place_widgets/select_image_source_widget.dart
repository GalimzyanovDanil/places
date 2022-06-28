import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/features/places_list/domain/repository/image_pick_repository.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';

typedef PickImageAsync = Future<File?> Function(ImagePickerSource);

class SelectImageSourceWidget extends StatelessWidget {
  final PickImageAsync pickImage;

  const SelectImageSourceWidget({
    required this.pickImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final currentItem = ImagePickerSource.values[index];

                  return ListTile(
                    onTap: () async {
                      await pickImage(currentItem).then(
                        (value) => Navigator.of(context).pop(value),
                      );
                    },
                    leading: SvgPicture.asset(
                      currentItem.iconPath,
                      color: colorScheme.onTertiaryContainer,
                    ),
                    title: Text(
                      currentItem.title,
                      style: textTheme.bodyText2?.copyWith(
                        color: colorScheme.onTertiaryContainer,
                      ),
                    ),
                    horizontalTitleGap: 0,
                  );
                },
                separatorBuilder: (_, __) => Divider(
                  color: theme.disabledColor,
                  height: 0,
                ),
                itemCount: ImagePickerSource.values.length,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FloatingActionButton.extended(
                onPressed: Navigator.of(context).pop,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                backgroundColor: colorScheme.secondary, //null
                label: Text(
                  PlacesListStrings.cancel.toUpperCase(),
                  style: textTheme.button?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
