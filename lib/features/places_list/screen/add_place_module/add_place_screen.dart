import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/places_list/screen/add_place_module/add_place_screen_wm.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';
import 'package:places/features/places_list/widgets/add_place_widgets/add_image_widget.dart';
import 'package:places/features/places_list/widgets/add_place_widgets/common_text_fields.dart';
import 'package:places/features/places_list/widgets/add_place_widgets/select_category_widget.dart';

// TODO: cover with documentation
/// Main widget for AddPlaceScreen module
class AddPlaceScreen extends ElementaryWidget<IAddPlaceScreenWidgetModel> {
  final PlaceType? type;

  const AddPlaceScreen({
    this.type,
    Key? key,
    WidgetModelFactory wmFactory = defaultAddPlaceScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IAddPlaceScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            child: TextButton(
              onPressed: () {},
              child: Text(
                PlacesListStrings.cancel,
                style: wm.theme.textTheme.headline3
                    ?.copyWith(color: wm.theme.colorScheme.onInverseSurface),
              ),
            ),
          ),
        ),
        title: Text(
          PlacesListStrings.addNewPlaceTittle,
          style: wm.theme.textTheme.headline4,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                AddImageWidget(
                  deletePicture: (index) {},
                  onAddPicture: () {},
                ),
                const SizedBox(height: 24),
                SelectCategoryWidget(
                  categoryText: type?.filterTitle,
                  onSelecetCategory: wm.onSelectCategory,
                ),
                const SizedBox(height: 24),
                CommonTextField(
                  onClearText: () {},
                  title: PlacesListStrings.name,
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CommonTextField(
                        onClearText: () {},
                        title: PlacesListStrings.lat,
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CommonTextField(
                        onClearText: () {},
                        title: PlacesListStrings.lng,
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {},
                  canRequestFocus: false,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Text(
                    PlacesListStrings.setOnMap,
                    style: wm.theme.textTheme.caption,
                  ),
                ),
                const SizedBox(height: 36),
                CommonTextField(
                  onClearText: () {},
                  title: PlacesListStrings.description,
                  maxLines: 3,
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: double.infinity,
        child: FloatingActionButton.extended(
          onPressed: () {},
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          backgroundColor: wm.theme.primaryColor, //null
          label: Text(
            PlacesListStrings.create,
            style: wm.theme.textTheme.button
                ?.copyWith(color: wm.theme.disabledColor), // color: null
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }
}
