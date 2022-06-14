import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/search/strings/search_screen_strings.dart';

class QueryListWidget extends StatelessWidget {
  final List<String>? queries;
  final VoidCallback onClearHistory;
  final AsyncValueSetter<int> onDeleteQuery;

  const QueryListWidget({
    required this.queries,
    required this.onClearHistory,
    required this.onDeleteQuery,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: queries?.isNotEmpty ?? true,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              SearchScreenStrings.youFind,
              style: theme.textTheme.subtitle1
                  ?.copyWith(color: theme.disabledColor),
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 16),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) => Row(
            children: [
              Expanded(
                child: Text(queries![index]),
              ),
              IconButton(
                onPressed: () => onDeleteQuery(index),
                splashRadius: 16,
                icon: SvgPicture.asset(
                  AppAssets.iconDelete,
                  color: theme.disabledColor,
                ),
              ),
            ],
          ),
          separatorBuilder: (_, __) => const Divider(
            height: 0,
          ),
          itemCount: queries?.length ?? 0,
        ),
        Visibility(
          visible: queries?.isNotEmpty ?? true,
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: onClearHistory,
              child: Text(
                SearchScreenStrings.clearHistory,
                style: theme.textTheme.caption,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
