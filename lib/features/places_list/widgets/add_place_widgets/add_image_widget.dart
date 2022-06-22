import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/places_list/widgets/add_place_widgets/delete_icon_button.dart';

const _cardSize = 72.0;

class AddImageWidget extends StatelessWidget {
  final VoidCallback onAddPicture;
  final ValueSetter<int> deletePicture;

  const AddImageWidget({
    required this.onAddPicture,
    required this.deletePicture,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: _cardSize,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _AddCard(onTap: onAddPicture),
          const SizedBox(width: 16),
          _CardWidget(deletePicture: deletePicture, theme: theme),
        ],
      ),
    );
  }
}

// Карточка фото
class _CardWidget extends StatelessWidget {
  final ValueSetter<int> deletePicture;
  final ThemeData theme;

  const _CardWidget({
    required this.deletePicture,
    required this.theme,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: SizedBox(
            width: 72,
            height: 72,
            child: Placeholder(
              child: ColoredBox(color: Colors.greenAccent),
            ),
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: DeleteIconButton(
            onTap: () => deletePicture.call(1),
            iconColor: theme.colorScheme.tertiary,
            backgroundColor: theme.colorScheme.onTertiary,
          ),
        ),
      ],
    );
  }
}

/// Кнопка добавления новых фото.
class _AddCard extends StatelessWidget {
  final VoidCallback onTap;

  const _AddCard({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _cardSize,
        height: _cardSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          border: Border.all(
            color: color.withOpacity(0.48),
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
