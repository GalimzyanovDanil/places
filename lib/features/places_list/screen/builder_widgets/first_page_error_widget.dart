import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/common/app_exceptions/api_exception.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';

class FirstPageErrorWidget extends StatelessWidget {
  final ApiException _error;
  // ignore: avoid_annotating_with_dynamic
  const FirstPageErrorWidget(dynamic error, {Key? key})
      : _error = error as ApiException,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.disabledColor;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppAssets.iconErrorCommon,
            width: 64,
            height: 64,
            color: color,
          ),
          const SizedBox(height: 24),
          Text(
            PlacesListStrings.errorTitle,
            style: theme.textTheme.headline4?.copyWith(
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            (_error.exceptionType == ApiExceptionType.other)
                ? PlacesListStrings.otherErrorText
                : PlacesListStrings.networkErrorText,
            textAlign: TextAlign.center,
            style: theme.textTheme.subtitle1?.copyWith(
              color: theme.disabledColor,
            ),
          ),
        ],
      ),
    );
  }
}
