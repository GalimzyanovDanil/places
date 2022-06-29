import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/place_details/screen/builder_widgets/place_details_loading_widget.dart';
import 'package:places/features/place_details/screen/place_details_wm.dart';
import 'package:places/features/place_details/widgets/back_button_widget.dart';
import 'package:places/features/place_details/widgets/buttons_widget.dart';
import 'package:places/features/place_details/widgets/content_widget.dart';
import 'package:places/features/place_details/widgets/image_view_widget.dart';
import 'package:places/features/place_details/widgets/navigation_button_widget.dart';
import 'package:places/features/common/widgets/skeleton.dart';
import 'package:places/util/triple_state_notifier_builder.dart';
import 'package:shimmer/shimmer.dart';

// TODO(me): cover with documentation
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
    final backButton = BackButtonWidget(onTapBack: wm.onTapBackButton);
    const appBarHeight = 360.0;

    return EntityStateNotifierBuilder<bool>(
      listenableEntityState: wm.isLoadingProgressState,
      loadingBuilder: (_, isLoading) => PlaceDetailsLoadingWidget(
        backButton: backButton,
        height: appBarHeight,
        isLoading: isLoading ?? true,
      ),
      builder: (_, isLoading) {
        return Scaffold(
          body: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: appBarHeight,
                leading: backButton,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                      TripleStateNotifierBuilder<bool, PlannedButtonState,
                          String?>(
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
              ),
            ],
          ),
        );
      },
    );
  }
}
