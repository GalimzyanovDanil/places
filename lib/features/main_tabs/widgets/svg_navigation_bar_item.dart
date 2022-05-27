import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/features/common/strings/app_strings.dart';

class SvgNavigationBarItem extends BottomNavigationBarItem {
  final String unselectedAssetName;
  final String selectedAssetName;
  final Color iconColor;

  SvgNavigationBarItem({
    required this.unselectedAssetName,
    required this.selectedAssetName,
    required this.iconColor,
  }) : super(
          icon: SvgPicture.asset(unselectedAssetName, color: iconColor),
          activeIcon: SvgPicture.asset(selectedAssetName, color: iconColor),
          label: AppStrings.emptyString,
        );
}
