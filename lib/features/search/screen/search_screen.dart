import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/widgets/app_bar_widget.dart';
import 'package:places/features/search/screen/search_wm.dart';
import 'package:places/features/search/strings/search_screen_strings.dart';
import 'package:places/features/search/widgets/find_place_list_widget.dart';
import 'package:places/features/search/widgets/query_list_widget.dart';
import 'package:places/util/double_state_notifier_builder.dart';

/// TODO(me): cover with documentation
/// Main widget for Search module
class SearchScreen extends ElementaryWidget<ISearchWidgetModel> {
  const SearchScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultSearchWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISearchWidgetModel wm) {
    return Scaffold(
      appBar: CommonAppBarWidget(
        onTrailingButtonTap: wm.onClearText,
        onBackButtonTap: wm.onBackButton,
        autofocusOnSearchFiled: true,
        searchBarcontroller: wm.searchBarController,
        trailingButtonIcon: Material(
          color: wm.theme.colorScheme.surface,
          shape: const CircleBorder(),
          child: SvgPicture.asset(
            AppAssets.iconDelete,
            color: wm.theme.colorScheme.onSurfaceVariant,
          ),
        ),
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 30,
          bottom: 16,
        ),
        child: DoubleStateNotifierBuilder<List<String>?, List<Place>?>(
          listenableState1: wm.searchQueriesState,
          listenableState2: wm.listPlaceState,
          builder: (queries, placesList) {
            return placesList == null
                ? QueryListWidget(
                    queries: queries,
                    onClearHistory: wm.onClearHistory,
                    onDeleteQuery: wm.onDeleteQuery,
                  )
                : placesList.isNotEmpty
                    ? FindPlaceListWidget(
                        queryText: wm.queryText!,
                        placesList: placesList,
                        onTapPlace: wm.onTapPlace,
                      )
                    : const EmptyWidget();
          },
        ),
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppAssets.iconEmptySearch,
            color: theme.disabledColor,
          ),
          const SizedBox(height: 35),
          Text(
            SearchScreenStrings.nothingFind,
            style:
                theme.textTheme.headline4?.copyWith(color: theme.disabledColor),
          ),
          const SizedBox(height: 10),
          Text(
            SearchScreenStrings.tryChangeParams,
            textAlign: TextAlign.center,
            style:
                theme.textTheme.subtitle1?.copyWith(color: theme.disabledColor),
          ),
        ],
      ),
    );
  }
}
