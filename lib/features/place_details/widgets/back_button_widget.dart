import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/assets/res/app_assets.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback onTapBack;
  const BackButtonWidget({
    required this.onTapBack,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16),
      child: Material(
        color: theme.colorScheme.onTertiary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.iconArrow,
              color: theme.colorScheme.tertiary,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: onTapBack,
            ),
          ],
        ),
      ),
    );
  }
}