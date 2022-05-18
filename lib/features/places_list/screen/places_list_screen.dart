import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/places_list/screen/places_list_wm.dart';

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
      appBar: AppBar(),
      body: Body(wm),
    );
  }
}

class Body extends StatelessWidget {
  final IPlacesListWidgetModel wm;
  const Body(this.wm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: EntityStateNotifierBuilder(
        listenableEntityState: wm.placesState,
        loadingBuilder: (_, __) => const CircularProgressIndicator.adaptive(),
        errorBuilder: (_, __, ___) => const Text('Error'),
        builder: (_, state) => ListView.separated(
            itemBuilder: (context, index) {
              wm.pagination(index);
              return Card(
                child: ListTile(
                  title: Text(wm.placesState.value?.data?[index].name ?? ''),
                  leading: Text(
                      wm.placesState.value?.data?[index].placeType.toTitle() ??
                          ''),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: wm.placesState.value?.data?.length ?? 0),
      ),
    );
  }
}
