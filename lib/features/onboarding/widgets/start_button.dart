import 'package:flutter/material.dart';
import 'package:places/features/onboarding/strings/onboarding_strings.dart';

class StartButton extends StatelessWidget {
  final VoidCallback _onPressed;

  const StartButton({
    required VoidCallback onPressed,
    Key? key,
  })  : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      child: FloatingActionButton.extended(
        onPressed: _onPressed,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        label: Text(
          OnboardingStrings.startButton,
          style: theme.textTheme.button,
        ),
      ),
    );
  }
}
