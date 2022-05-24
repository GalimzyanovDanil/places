import 'package:flutter/material.dart';
import 'package:places/features/common/app_exceptions/api_exception.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';

class NewPageErrorWidget extends StatelessWidget {
  final ApiException _error;
  final VoidCallback retryLastRequest;
  const NewPageErrorWidget(
      // ignore: avoid_annotating_with_dynamic
      {required dynamic error,
      required this.retryLastRequest,
      Key? key})
      : _error = error as ApiException,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.disabledColor;
    return InkWell(
      onTap: retryLastRequest,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                (_error.exceptionType == ApiExceptionType.other)
                    ? PlacesListStrings.otherErrorText
                    : PlacesListStrings.networkErrorText,
                style: theme.textTheme.subtitle1?.copyWith(
                  color: color,
                )),
            Text(PlacesListStrings.pressForUpdate,
                style: theme.textTheme.subtitle1?.copyWith(
                  color: color,
                )),
            // const SizedBox(height: 8),
            Icon(
              Icons.update,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
