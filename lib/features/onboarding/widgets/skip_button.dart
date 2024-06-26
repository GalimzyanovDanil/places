import 'package:flutter/material.dart';
import 'package:places/features/onboarding/strings/onboarding_strings.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback _onPressed;

  const SkipButton({
    required VoidCallback onPressed,
    Key? key,
  })  : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: _onPressed,
      child: Text(
        OnboardingStrings.skipButton,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
