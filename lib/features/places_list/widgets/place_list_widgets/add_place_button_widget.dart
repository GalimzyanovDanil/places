import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/assets/colors/app_colors.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';

class AddPlaceButtonWidget extends StatelessWidget {
  final VoidCallback onAddPlaceTap;
  final Animation<Offset> animation;

  const AddPlaceButtonWidget({
    required this.onAddPlaceTap,
    required this.animation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SlideTransition(
      position: animation,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          gradient: LinearGradient(
            colors: [AppColors.yellowSplash, AppColors.greenSplash],
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppAssets.iconPlus,
                    color: theme.colorScheme.onPrimary,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    PlacesListStrings.addNewPlace,
                    style: theme.textTheme.button,
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: onAddPlaceTap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
