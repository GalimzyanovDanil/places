import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';

class SelectCategoryWidget extends StatelessWidget {
  final String? categoryText;
  final VoidCallback onSelecetCategory;

  const SelectCategoryWidget({
    required this.categoryText,
    required this.onSelecetCategory,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          PlacesListStrings.categoryTitle,
          style: textTheme.overline,
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: onSelecetCategory,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  categoryText ?? PlacesListStrings.categoryNotSelect,
                  style: textTheme.overline,
                ),
              ),
              SvgPicture.asset(AppAssets.iconView),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Divider(
          height: 0,
          color: theme.disabledColor,
        ),
      ],
    );
  }
}
