import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/places_list/screen/add_place_module/select_category/select_category_wm.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';

// TODO: cover with documentation
/// Main widget for SelectCategory module
class SelectCategoryScreen
    extends ElementaryWidget<ISelectCategoryWidgetModel> {
  final PlaceType? type;

  const SelectCategoryScreen({
    this.type,
    Key? key,
    WidgetModelFactory wmFactory = defaultSelectCategoryWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISelectCategoryWidgetModel wm) {
    return StateNotifierBuilder<int>(
      listenableState: wm.selectCategoryState,
      builder: (_, value) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: wm.onBackButton,
            splashRadius: 15,
            icon: SvgPicture.asset(
              AppAssets.iconArrow,
              color: wm.theme.iconTheme.color,
            ),
          ),
          title: Text(
            PlacesListStrings.categorySmallTitle,
            style: wm.theme.textTheme.headline4,
          ),
        ),
        body: ListView.separated(
          itemBuilder: (_, index) {
            return ListTile(
              onTap: () => wm.selectCategory(index),
              title: Text(
                PlaceType.values[index].filterTitle,
                style: wm.theme.textTheme.subtitle1
                    ?.copyWith(color: wm.theme.colorScheme.tertiary),
              ),
              trailing: index == value
                  ? SvgPicture.asset(
                      AppAssets.iconTick,
                      color: wm.theme.colorScheme.primary,
                    )
                  : const SizedBox.shrink(),
            );
          },
          separatorBuilder: (_, __) => Divider(
            height: 0,
            color: wm.theme.disabledColor,
          ),
          itemCount: PlaceType.values.length,
        ),
        floatingActionButton: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.infinity,
          child: FloatingActionButton.extended(
            onPressed: wm.onSaveButton,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            backgroundColor: value == null ? wm.theme.primaryColor : null,
            label: Text(
              PlacesListStrings.save,
              style: wm.theme.textTheme.button?.copyWith(
                color: value == null ? wm.theme.disabledColor : null,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
