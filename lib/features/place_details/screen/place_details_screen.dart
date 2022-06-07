import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/place_details/screen/place_details_wm.dart';
import 'package:places/features/place_details/widgets/back_button_widget.dart';
import 'package:places/features/place_details/widgets/buttons_widget.dart';
import 'package:places/features/place_details/widgets/content_widget.dart';
import 'package:places/features/place_details/widgets/image_view_widget.dart';
import 'package:places/features/places_list/domain/entity/place.dart';

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
            //TODO(me)
            leading: BackButtonWidget(onTapBack: () {}),
            flexibleSpace: FlexibleSpaceBar(
              background: ImageViewWidget(
                place: place,
                onPageChanged: (value) {},
                //TODO(me) попробовать передать page
                currentPage: 1,
                pageController: PageController(),
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
                  //TODO(me) Обернуть в нотифаер
                  ButtonsWidget(
                    onTapFavorite: () {},
                    onTapNavigation: () {},
                    onTapPlanned: () {},
                    onTapShare: () {},
                    isFavorite: true,
                    plannedButtonState: PlannedButtonState.active,
                    plannedDate: 'null',
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
