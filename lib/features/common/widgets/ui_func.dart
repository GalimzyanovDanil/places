import 'package:flutter/material.dart';

class UiFuncController {
  Future<void> showSnackBar({
    required String text,
    required BuildContext context,
  }) async {
    final theme = Theme.of(context);
    final snackBar = SnackBar(
      backgroundColor: theme.colorScheme.onPrimaryContainer,
      content: Text(
        text,
        style: theme.textTheme.subtitle1,
      ),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
