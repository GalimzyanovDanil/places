// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/common/widgets/app_bar_widget.dart';
import 'package:places/features/places_list/screen/places_list_module/builder_widgets/first_page_error_widget.dart';
import 'package:places/features/places_list/screen/places_list_module/builder_widgets/new_page_error_widget.dart';
import 'package:places/features/places_list/screen/places_list_module/builder_widgets/progress_indicator_widget.dart';
import 'package:places/features/places_list/screen/places_list_module/places_list_wm.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';
import 'package:places/features/places_list/widgets/place_list_widgets/add_place_button_widget.dart';
import 'package:places/features/places_list/widgets/place_list_widgets/place_card_widget.dart';

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
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (_, __) => [
            SliverAppBar(
              pinned: true,
              elevation: 0,
              expandedHeight: 150,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final top = constraints.biggest.height;
                  final theme = wm.theme;

                  return FlexibleSpaceBar(
                    title: Visibility(
                      visible: top < 180,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: top < 105 ? 1.0 : 0.0,
                        child: Text(
                          PlacesListStrings.appBarTitle,
                          style: theme.textTheme.headline4,
                        ),
                      ),
                    ),
                    background: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 25,
                          ),
                          child: Text(
                            PlacesListStrings.appBarLargeTitle,
                            style: theme.textTheme.headline1,
                          ),
                        ),
                        SearchFieldWidget(
                          onSearchBarTap: wm.onSearchBarTap,
                          trailingButtonIcon: SvgPicture.asset(
                            AppAssets.iconFilter,
                            color: theme.indicatorColor,
                          ),
                          onTrailingButtonTap: wm.onSettingsTap,
                          toolbarHeight: 100,
                          enabled: false,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
          body: Center(
            child: RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              onRefresh: wm.onRefresh,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: PagedListView.separated(
                  key: const PageStorageKey<String>('listPlaces'),
                  pagingController: wm.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Place>(
                    itemBuilder: (_, place, index) => PlaceCardWidget(
                      onTapCard: wm.onTapCard,
                      index: index,
                      place: place,
                    ),
                    firstPageProgressIndicatorBuilder: (_) =>
                        const ProgresIndicatorWidget(),
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
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: AddPlaceButtonWidget(
          onAddPlaceTap: wm.onAddPlaceTap,
          animation: wm.animation,
        ),
      ),
    );
  }
}
