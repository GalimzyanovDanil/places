import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/place_details/screen/place_details_wm.dart';
import 'package:places/features/place_details/widgets/back_button_widget.dart';
import 'package:places/features/place_details/widgets/buttons_widget.dart';
import 'package:places/features/place_details/widgets/content_widget.dart';
import 'package:places/features/place_details/widgets/image_view_widget.dart';
import 'package:places/features/place_details/widgets/navigation_button_widget.dart';
import 'package:places/features/places_list/domain/entity/place.dart';
import 'package:places/util/triple_state_notifier_builder.dart';

// TODO: cover with documentation
/// Main widget for PlaceDetails module
class PlaceDetailsScreen extends ElementaryWidget<IPlaceDetailsWidgetModel> {
  final Place place;
  const PlaceDetailsScreen({
    required this.place,
    Key? key,
    WidgetModelFactory wmFactory = defaultPlaceDetailsWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPlaceDetailsWidgetModel wm) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 360,
            leading: BackButtonWidget(onTapBack: wm.onTapBackButton),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: StateNotifierBuilder<double>(
                listenableState: wm.imageViewState,
                builder: (_, pageOffset) => ImageViewWidget(
                  place: place,
                  pageOffset: pageOffset ?? 0.0,
                  pageController: wm.pageController,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  DetailsContentWidget(place: place),
                  const SizedBox(height: 24),
                  StateNotifierBuilder<bool>(
                    listenableState: wm.routeCompleteState,
                    builder: (_, isRouteComplete) => NavigationButtonWidget(
                      onTap: wm.onTapNavigation,
                      isRouteComplete: isRouteComplete ?? false,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TripleStateNotifierBuilder<bool, PlannedButtonState, String?>(
                    listenableState1: wm.favoriteState,
                    listenableState2: wm.plannedState,
                    listenableState3: wm.plannedDateState,
                    builder: (isFavorite, plannedState, plannedDateState) =>
                        ButtonsWidget(
                      onTapFavorite: wm.onTapFavorite,
                      onTapPlanned: wm.onTapPlanned,
                      onTapShare: wm.onTapShare,
                      isFavorite: isFavorite ?? false,
                      plannedButtonState:
                          plannedState ?? PlannedButtonState.disable,
                      plannedDate: plannedDateState,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
