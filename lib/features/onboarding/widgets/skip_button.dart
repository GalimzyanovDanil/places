import 'package:flutter/material.dart';
import 'package:places/features/onboarding/strings/onboarding_strings.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final bool _visible;

  const SkipButton({
    required VoidCallback onPressed,
    required bool visible,
    Key? key,
  })  : _onPressed = onPressed,
        _visible = visible,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible,
      child: TextButton(
        style: const ButtonStyle(
          splashFactory: NoSplash.splashFactory,
        ),
        onPressed: _onPressed,
        child: Text(
          OnboardingStrings.skipButton,
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    );
  }
}
