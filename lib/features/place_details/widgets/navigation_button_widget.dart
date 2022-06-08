import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/place_details/Strings/details_screen_strings.dart';

class NavigationButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final bool isRouteComplete;

  const NavigationButtonWidget({
    required this.onTap,
    required this.isRouteComplete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    const radius = 12.0;

    return isRouteComplete
        ? _FinishedButtonWidget(
            radius: radius,
            theme: theme,
            colorScheme: colorScheme,
            textTheme: textTheme,
            onTap: onTap,
          )
        : _NotFinishedButtonWidget(
            radius: radius,
            theme: theme,
            colorScheme: colorScheme,
            textTheme: textTheme,
            onTap: onTap,
          );
  }
}

class _NotFinishedButtonWidget extends StatelessWidget {
  const _NotFinishedButtonWidget({
    required this.theme,
    required this.colorScheme,
    required this.textTheme,
    required this.onTap,
    required this.radius,
    Key? key,
  }) : super(key: key);

  final ThemeData theme;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final VoidCallback onTap;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Material(
        color: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
        child: Align(
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.iconGo,
                    color: colorScheme.onPrimary,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    child: Text(
                      DeatilsScreenStrings.navigate,
                      style: textTheme.button,
                    ),
                  ),
                ],
              ),
              Positioned.fill(
                child: InkWell(
                  borderRadius: BorderRadius.circular(radius),
                  onTap: onTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FinishedButtonWidget extends StatelessWidget {
  const _FinishedButtonWidget({
    required this.theme,
    required this.colorScheme,
    required this.textTheme,
    required this.onTap,
    required this.radius,
    Key? key,
  }) : super(key: key);

  final ThemeData theme;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final VoidCallback onTap;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.iconTick,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        DeatilsScreenStrings.finish,
                        style: textTheme.button?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Material(
              color: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(radius),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 14,
                    ),
                    child: SvgPicture.asset(
                      AppAssets.iconGo,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  Positioned.fill(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(radius),
                      onTap: onTap,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
