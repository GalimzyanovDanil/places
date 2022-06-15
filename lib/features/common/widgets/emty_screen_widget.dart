import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyScreenWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;

  const EmptyScreenWidget({
    required this.iconPath,
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            color: theme.disabledColor,
          ),
          const SizedBox(height: 35),
          Text(
            title,
            style:
                theme.textTheme.headline4?.copyWith(color: theme.disabledColor),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style:
                theme.textTheme.subtitle1?.copyWith(color: theme.disabledColor),
          ),
        ],
      ),
    );
  }
}
