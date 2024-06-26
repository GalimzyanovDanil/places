import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/common/app_typedef.dart';
import 'package:places/features/common/domain/entity/place_type.dart';

class CategoryElementWidget extends StatelessWidget {
  final String iconPath;
  final PlaceType placeType;
  final bool isSelect;
  final DoubleValueSetter<bool, PlaceType> onElementTap;

  const CategoryElementWidget({
    required this.iconPath,
    required this.placeType,
    required this.isSelect,
    required this.onElementTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mainColor = theme.indicatorColor;

    return Column(
      children: [
        Stack(
          children: [
            Material(
              color: mainColor.withOpacity(0.16),
              shape: const CircleBorder(),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.all(16),
                    child: SvgPicture.asset(
                      iconPath,
                      height: 40,
                      width: 40,
                      color: mainColor,
                    ),
                  ),
                  Positioned.fill(
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => onElementTap.call(isSelect, placeType),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 54,
              left: 54,
              child: isSelect
                  ? SelectTickWidget(
                      theme: theme,
                      key: ValueKey(placeType.name),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          placeType.filterTitle,
          style: theme.textTheme.headline5,
          maxLines: 2,
          softWrap: true,
        ),
      ],
    );
  }
}

class SelectTickWidget extends StatelessWidget {
  final ThemeData theme;

  const SelectTickWidget({
    required this.theme,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: theme.colorScheme.tertiary,
      shape: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: SvgPicture.asset(
          AppAssets.iconTick,
          height: 12,
          width: 17,
          color: theme.colorScheme.onTertiary,
        ),
      ),
    );
  }
}
