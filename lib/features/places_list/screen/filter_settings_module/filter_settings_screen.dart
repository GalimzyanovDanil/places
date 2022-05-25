import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/places_list/domain/entity/place.dart';
import 'package:places/features/places_list/domain/entity/place_type.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_wm.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';
import 'package:places/features/places_list/widgets/filter_settings_widgets/show_result_button.dart';

// TODO: cover with documentation
/// Main widget for FilterSettings module
class FilterSettingsScreen
    extends ElementaryWidget<IFilterSettingsWidgetModel> {
  const FilterSettingsScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultFilterSettingsWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IFilterSettingsWidgetModel wm) {
    return Scaffold(
      appBar: AppBarWidget(
          onBackButtonTap: wm.onBackButtonTap, onClearTap: wm.onClearTap),
      body: Body(wm: wm),
      floatingActionButton: EntityStateNotifierBuilder<List<Place>>(
        listenableEntityState: wm.listPlaceState,
        loadingBuilder: (_, __) => const ShowResultButton.loading(),
        builder: (_, content) => ShowResultButton(
          onPressed: wm.onShowResultTap,
          countFindElements: content?.length,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }
}

class Body extends StatelessWidget {
  final IFilterSettingsWidgetModel wm;
  const Body({required this.wm, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 25),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                PlacesListStrings.category,
                style: textTheme.headline6,
              ),
            ),
            const SizedBox(height: 25),
            StateNotifierBuilder<List<PlaceType>>(
              listenableState: wm.filterState,
              builder: (_, filterList) => Wrap(
                alignment: WrapAlignment.spaceAround,
                spacing: 40,
                runSpacing: 40,
                children: wm.getCategoryElements(),
              ),
            ),
            const SizedBox(height: 60),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    PlacesListStrings.distance,
                    style: textTheme.bodyText1,
                  ),
                  const Spacer(),
                  Text(
                    PlacesListStrings.distanceNumber,
                    style: textTheme.bodyText2,
                  ),
                ],
              ),
            ),
            StateNotifierBuilder<double>(
              listenableState: wm.sliderState,
              builder: (_, value) => Slider(
                value: value ?? 0,
                divisions: wm.divSliderValue,
                label: value?.round().toString(),
                onChanged: wm.onSliderChange,
                min: wm.minSliderValue,
                max: wm.maxSliderValue,
                activeColor: colorScheme.primary,
                thumbColor: colorScheme.onPrimary,
                inactiveColor: colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  /// AppBar height. Default 56.
  final double? toolbarHeight;
  final VoidCallback onBackButtonTap;
  final VoidCallback onClearTap;

  const AppBarWidget(
      {required this.onBackButtonTap,
      required this.onClearTap,
      this.toolbarHeight,
      Key? key})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      toolbarHeight: toolbarHeight,
      leading: IconButton(
        onPressed: onBackButtonTap,
        splashRadius: 15,
        icon: SvgPicture.asset(
          AppAssets.iconArrow,
          color: theme.iconTheme.color,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onClearTap,
          style: const ButtonStyle(
            splashFactory: NoSplash.splashFactory,
          ),
          child: Text(PlacesListStrings.clearFilters,
              style: theme.textTheme.caption),
        )
      ],
    );
  }
}
