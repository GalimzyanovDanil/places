import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/assets/res/app_assets.dart';

class DeleteIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color iconColor;
  final Color backgroundColor;

  const DeleteIconButton({
    required this.onTap,
    required this.iconColor,
    required this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      canRequestFocus: false,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Material(
        shape: const CircleBorder(),
        color: backgroundColor,
        child: SvgPicture.asset(
          AppAssets.iconDelete,
          color: iconColor,
        ),
      ),
    );
  }
}
