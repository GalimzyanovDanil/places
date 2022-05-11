import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage extends StatelessWidget {
  final String iconPath;
  final String tittle;
  final String text;

  const OnboardingPage({
    required this.iconPath,
    required this.tittle,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(flex: 4),
          SvgPicture.asset(
            iconPath,
            color: theme.iconTheme.color,
            height: 125,
            width: 125,
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 58),
            child: Text(
              tittle,
              textAlign: TextAlign.center,
              style: theme.textTheme.headline2,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 58),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: theme.textTheme.subtitle1,
            ),
          ),
          const Spacer(flex: 5),
        ],
      ),
    );
  }
}
