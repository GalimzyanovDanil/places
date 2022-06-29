import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/common/domain/entity/geoposition.dart';
import 'package:places/features/places_list/screen/add_place_module/select_position/select_position_wm.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';
import 'package:places/util/double_state_notifier_builder.dart';

// TODO(me): cover with documentation
/// Main widget for SelectPosition module
class SelectPositionScreen
    extends ElementaryWidget<ISelectPositionWidgetModel> {
  final Geoposition? selectPosition;

  const SelectPositionScreen({
    this.selectPosition,
    Key? key,
    WidgetModelFactory wmFactory = defaultSelectPositionWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISelectPositionWidgetModel wm) {
    return DoubleStateNotifierBuilder<Geoposition, Geoposition>(
      listenableState1: wm.selectPositionState,
      listenableState2: wm.currentPositionState,
      builder: (selectPos, currentPos) {
        final centrePos = selectPos ?? currentPos;

        final selectMarker = selectPos != null
            ? Marker(
                point: LatLng(
                  selectPos.latitude,
                  selectPos.longitude,
                ),
                builder: (ctx) {
                  final color = wm.theme.colorScheme.tertiary;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 2,
                        height: 25,
                        color: color,
                      ),
                      Container(
                        width: 25,
                        height: 2,
                        color: color,
                      ),
                    ],
                  );
                },
              )
            : null;

        final currentMarker = currentPos != null
            ? Marker(
                point: LatLng(
                  currentPos.latitude,
                  currentPos.longitude,
                ),
                builder: (ctx) => ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: ColoredBox(
                    color: wm.theme.colorScheme.primary,
                  ),
                ),
              )
            : null;

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            leadingWidth: 120,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                child: TextButton(
                  onPressed: wm.onCancelButton,
                  child: Text(
                    PlacesListStrings.cancel,
                    style: wm.theme.textTheme.headline3?.copyWith(
                      color: wm.theme.colorScheme.onInverseSurface,
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              PlacesListStrings.selectPositionTitle,
              style: wm.theme.textTheme.headline4,
            ),
            actions: [
              Visibility(
                visible: selectPos != null,
                child: TextButton(
                  onPressed: wm.onAcceptButton,
                  child: Text(
                    PlacesListStrings.selectPositionAccept,
                    style: wm.theme.textTheme.headline3?.copyWith(
                      color: wm.theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  onMapCreated: wm.onMapCreated,
                  center: LatLng(
                    centrePos?.latitude ?? 0,
                    centrePos?.longitude ?? 0,
                  ),
                  controller: wm.mapController,
                  minZoom: 4,
                  maxZoom: 18,
                  onTap: (_, pos) => wm.onChangeMarker(Geoposition(
                    latitude: pos.latitude,
                    longitude: pos.longitude,
                  )),
                ),
                children: [
                  TileLayerWidget(
                    options: TileLayerOptions(
                      urlTemplate: (wm.theme.brightness == Brightness.light)
                          ? PlacesListStrings.lightModeUrl
                          : PlacesListStrings.darkModeUrl,
                      subdomains: ['a', 'b', 'c'],
                      fastReplace: true,
                    ),
                  ),
                  MarkerLayerWidget(
                    options: MarkerLayerOptions(
                      markers: [
                        if (selectMarker != null) selectMarker,
                        if (currentMarker != null) currentMarker,
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: IconButton(
                  iconSize: 55,
                  onPressed: wm.onMoveCurrentPosition,
                  icon: ClipRRect(
                    borderRadius: BorderRadius.circular(55),
                    child: Container(
                      height: 55,
                      width: 55,
                      padding: const EdgeInsets.all(10),
                      color: wm.theme.colorScheme.secondaryContainer,
                      child: SvgPicture.asset(
                        AppAssets.iconGeolocation,
                        color: wm.theme.colorScheme.tertiary,
                      ),
                    ),
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
