import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:places/features/places_list/domain/entity/place.dart';
import 'package:places/features/places_list/screen/builder_widgets/first_page_error_widget.dart';
import 'package:places/features/places_list/screen/builder_widgets/new_page_error_widget.dart';
import 'package:places/features/places_list/screen/places_list_wm.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';
import 'package:places/features/places_list/widgets/place_card_widget/place_card_widget.dart';

// TODO: cover with documentation
/// Main widget for PlacesList module
class PlacesListScreen extends ElementaryWidget<IPlacesListWidgetModel> {
  const PlacesListScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultPlacesListWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPlacesListWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(),
      ),
      body: Body(wm),
    );
  }
}

class Body extends StatelessWidget {
  final IPlacesListWidgetModel wm;
  const Body(this.wm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pagingController = wm.pagingController;
    return Center(
      child: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: wm.onRefresh,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: PagedListView.separated(
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate<Place>(
              itemBuilder: (_, place, index) => PlaceCardWidget(
                onTapCard: wm.onTapCard,
                index: index,
                place: place,
              ),
              firstPageErrorIndicatorBuilder: (_) =>
                  FirstPageErrorWidget(pagingController.error),
              newPageErrorIndicatorBuilder: (_) => NewPageErrorWidget(
                error: pagingController.error,
                retryLastRequest: pagingController.retryLastFailedRequest,
              ),
            ),
            separatorBuilder: (_, __) => const SizedBox(height: 24),
          ),
        ),
      ),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      PlacesListStrings.appBarTitle,
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
