import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/places_list/widgets/add_place_widgets/delete_icon_button.dart';

const _cardSize = 72.0;

class AddImageWidget extends StatelessWidget {
  final AsyncCallback onAddPicture;
  final ValueSetter<int> deletePicture;
  final List<String> imagePathList;

  const AddImageWidget({
    required this.onAddPicture,
    required this.deletePicture,
    required this.imagePathList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardWidgets = <Widget>[];

    if (imagePathList.isNotEmpty) {
      for (var i = 0; i <= imagePathList.length - 1; i++) {
        cardWidgets.addAll(
          [
            const SizedBox(width: 16),
            _CardWidget(
              deletePicture: deletePicture,
              theme: theme,
              imagePath: imagePathList[i],
              index: i,
            ),
          ],
        );
      }
    }

    return SizedBox(
      height: _cardSize,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _AddCard(
            onTap: onAddPicture,
            theme: theme,
          ),
          ...cardWidgets,
        ],
      ),
    );
  }
}

// Карточка фото
class _CardWidget extends StatelessWidget {
  final ValueSetter<int> deletePicture;
  final ThemeData theme;
  final String imagePath;
  final int index;

  const _CardWidget({
    required this.deletePicture,
    required this.theme,
    required this.imagePath,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = theme.colorScheme;

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.up,
      onDismissed: (_) => deletePicture(index),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: SizedBox(
              width: 72,
              height: 72,
              child: Image.file(
                File(imagePath),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 6,
            right: 6,
            child: DeleteIconButton(
              onTap: () => deletePicture(index),
              iconColor: colorScheme.tertiary,
              backgroundColor: colorScheme.onTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

// Кнопка добавления новых фото.
class _AddCard extends StatelessWidget {
  final VoidCallback onTap;
  final ThemeData theme;

  const _AddCard({
    required this.onTap,
    required this.theme,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = theme.colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _cardSize,
        height: _cardSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          border: Border.all(
            color: primaryColor.withOpacity(0.48),
            width: 2.0,
          ),
        ),
        child: SvgPicture.asset(
          AppAssets.iconPlus,
          width: _cardSize * 0.5,
          height: _cardSize * 0.5,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
