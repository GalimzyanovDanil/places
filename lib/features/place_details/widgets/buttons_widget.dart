import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/place_details/Strings/details_screen_strings.dart';
import 'package:places/features/place_details/screen/place_details_wm.dart';

class ButtonsWidget extends StatelessWidget {
  final VoidCallback onTapFavorite;
  final AsyncCallback onTapPlanned;
  final VoidCallback onTapShare;
  final bool isFavorite;
  final PlannedButtonState plannedButtonState;
  final String? plannedDate;

  const ButtonsWidget({
    required this.onTapFavorite,
    required this.onTapPlanned,
    required this.isFavorite,
    required this.plannedButtonState,
    required this.plannedDate,
    required this.onTapShare,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          height: 0,
          color: theme.colorScheme.onBackground,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _PlannedButtonWidget(
              onTapPlanned: onTapPlanned,
              theme: theme,
              textTheme: textTheme,
              colorScheme: colorScheme,
              state: plannedButtonState,
              date: plannedDate,
              onTapShare: onTapShare,
            ),
            _FavoriteButtonWidget(
              onTapFavorite: onTapFavorite,
              isFavorite: isFavorite,
              colorScheme: colorScheme,
              textTheme: textTheme,
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _FavoriteButtonWidget extends StatelessWidget {
  const _FavoriteButtonWidget({
    required this.onTapFavorite,
    required this.colorScheme,
    required this.textTheme,
    required this.isFavorite,
    Key? key,
  }) : super(key: key);

  final VoidCallback onTapFavorite;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTapFavorite,
      icon: SvgPicture.asset(
        isFavorite ? AppAssets.iconFavoriteFill : AppAssets.iconFavorite,
        color: colorScheme.onSurface,
      ),
      label: Text(
        DeatilsScreenStrings.inFavorite,
        style: textTheme.subtitle1?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
    );
  }
}

class _PlannedButtonWidget extends StatelessWidget {
  const _PlannedButtonWidget({
    required this.onTapPlanned,
    required this.theme,
    required this.textTheme,
    required this.colorScheme,
    required this.state,
    required this.date,
    required this.onTapShare,
    Key? key,
  }) : super(key: key);

  final VoidCallback onTapPlanned;
  final VoidCallback onTapShare;
  final ThemeData theme;
  final TextTheme textTheme;
  final ColorScheme colorScheme;
  final PlannedButtonState state;
  final String? date;

  @override
  Widget build(BuildContext context) {
    late final VoidCallback? onPressed;
    late final Color color;
    late final String iconAsset;
    late final String label;

    switch (state) {
      case PlannedButtonState.disable:
        onPressed = null;
        color = theme.disabledColor;
        iconAsset = AppAssets.iconCalendar;
        label = DeatilsScreenStrings.planned;
        break;
      case PlannedButtonState.active:
        onPressed = onTapPlanned;
        color = colorScheme.onSurface;
        iconAsset = AppAssets.iconCalendar;
        label = DeatilsScreenStrings.planned;
        break;
      case PlannedButtonState.haveDate:
        onPressed = onTapPlanned;
        color = colorScheme.primary;
        iconAsset = AppAssets.iconCalendarFill;
        assert(date != null, 'Date can not be null!');
        label = date!;
        break;
      case PlannedButtonState.share:
        onPressed = onTapShare;
        color = colorScheme.onSurface;
        iconAsset = AppAssets.iconShare;
        label = DeatilsScreenStrings.share;
        break;
    }

    return TextButton.icon(
      onPressed: onPressed,
      icon: SvgPicture.asset(iconAsset, color: color),
      label: Text(label, style: textTheme.subtitle1?.copyWith(color: color)),
    );
  }
}
