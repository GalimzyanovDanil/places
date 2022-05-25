import 'package:flutter/material.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';

class ShowResultButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final int? countFindElements;
  final bool progressIndicator;

  const ShowResultButton({
    required this.onPressed,
    required this.countFindElements,
    Key? key,
    this.progressIndicator = false,
  }) : super(key: key);

  const ShowResultButton.loading({Key? key})
      : onPressed = null,
        countFindElements = null,
        progressIndicator = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lable = (countFindElements == null)
        ? PlacesListStrings.showResult
        : '${PlacesListStrings.showResult} ($countFindElements)';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      child: FloatingActionButton.extended(
        onPressed: onPressed,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        label: progressIndicator
            ? CircularProgressIndicator(color: theme.colorScheme.onPrimary)
            : Text(
                lable,
                style: theme.textTheme.button,
              ),
      ),
    );
  }
}
