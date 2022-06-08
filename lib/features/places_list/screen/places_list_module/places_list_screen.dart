// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/places_list/screen/places_list_module/builder_widgets/first_page_error_widget.dart';
import 'package:places/features/places_list/screen/places_list_module/builder_widgets/new_page_error_widget.dart';
import 'package:places/features/places_list/screen/places_list_module/places_list_wm.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';
import 'package:places/features/places_list/widgets/place_card_widgets/place_card_widget.dart';

// TODO(me): cover with documentation
/// Main widget for PlacesList module
class PlacesListScreen extends ElementaryWidget<IPlacesListWidgetModel> {
  final List<PlaceType>? placeTypes;
  final double? radius;
  final double? lat;
  final double? lng;

  const PlacesListScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultPlacesListWidgetModelFactory,
    this.placeTypes,
    this.radius,
    this.lat,
    this.lng,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPlacesListWidgetModel wm) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBarWidget(
          onSearchBarTap: wm.onSearchBarTap,
          onSettingsTap: wm.onSettingsTap,
          toolbarHeight: 100,
        ),
        body: Center(
          child: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: wm.onRefresh,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
              child: PagedListView.separated(
                key: const PageStorageKey<String>('listPlaces'),
                pagingController: wm.pagingController,
                builderDelegate: PagedChildBuilderDelegate<Place>(
                  itemBuilder: (_, place, index) => PlaceCardWidget(
                    onTapCard: wm.onTapCard,
                    index: index,
                    place: place,
                  ),
                  firstPageErrorIndicatorBuilder: (_) =>
                      FirstPageErrorWidget(wm.pagingController.error),
                  newPageErrorIndicatorBuilder: (_) => NewPageErrorWidget(
                    error: wm.pagingController.error,
                    retryLastRequest:
                        wm.pagingController.retryLastFailedRequest,
                  ),
                ),
                separatorBuilder: (_, __) => const SizedBox(height: 24),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  /// AppBar height. Default 56.
  final double? toolbarHeight;
  final AsyncCallback onSettingsTap;
  final VoidCallback onSearchBarTap;

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);

  const AppBarWidget({
    required this.onSettingsTap,
    required this.onSearchBarTap,
    this.toolbarHeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight,
      centerTitle: true,
      title: Text(
        PlacesListStrings.appBarTitle,
        style: Theme.of(context).textTheme.headline4,
      ),
      bottom: SearchFieldWidget(
        onSearchBarTap: onSearchBarTap,
        onSettingsTap: onSettingsTap,
      ),
    );
  }
}

class SearchFieldWidget extends StatelessWidget implements PreferredSizeWidget {
  final double? toolbarHeight;
  final VoidCallback onSettingsTap;
  final VoidCallback onSearchBarTap;

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);

  const SearchFieldWidget({
    required this.onSettingsTap,
    required this.onSearchBarTap,
    this.toolbarHeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(12),
          color: theme.primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              SvgPicture.asset(
                AppAssets.iconSearch,
                color: theme.disabledColor,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: TextField(
                  onTap: onSearchBarTap,
                  decoration: InputDecoration(
                    hintText: PlacesListStrings.hintText,
                    hintStyle: theme.textTheme.overline,
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              IconButton(
                onPressed: onSettingsTap,
                splashRadius: 15,
                icon: SvgPicture.asset(
                  AppAssets.iconFilter,
                  color: theme.indicatorColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
