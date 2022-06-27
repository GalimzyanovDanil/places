import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/places_list/screen/add_place_module/add_place_screen_wm.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';
import 'package:places/features/places_list/widgets/add_place_widgets/add_image_widget.dart';
import 'package:places/features/places_list/widgets/add_place_widgets/common_text_fields.dart';
import 'package:places/features/places_list/widgets/add_place_widgets/select_category_widget.dart';
import 'package:places/util/text_field_validator.dart';

// TODO(me): cover with documentation
/// Main widget for AddPlaceScreen module
class AddPlaceScreen extends ElementaryWidget<IAddPlaceScreenWidgetModel> {
  const AddPlaceScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultAddPlaceScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IAddPlaceScreenWidgetModel wm) {
    return StateNotifierBuilder<bool>(
      listenableState: wm.isLoadingProgressState,
      builder: (_, isLoadingInProgress) {
        return AbsorbPointer(
          absorbing: isLoadingInProgress ?? false,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Scaffold(
                  appBar: AppBar(
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
                      PlacesListStrings.addNewPlaceTittle,
                      style: wm.theme.textTheme.headline4,
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      key: wm.formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: wm.onChangeFields,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 24),
                            StateNotifierBuilder<List<String>>(
                              listenableState: wm.uploadImageState,
                              builder: (_, imagePathList) {
                                return AddImageWidget(
                                  deletePicture: wm.onDeleteImage,
                                  onAddPicture: wm.onAddImage,
                                  imagePathList: imagePathList ?? [],
                                );
                              },
                            ),
                            const SizedBox(height: 24),
                            StateNotifierBuilder<PlaceType>(
                              listenableState: wm.categoryState,
                              builder: (_, value) {
                                return SelectCategoryWidget(
                                  categoryText: value?.filterTitle,
                                  onSelecetCategory: wm.onSelectCategory,
                                );
                              },
                            ),
                            const SizedBox(height: 24),
                            CommonTextField(
                              title: PlacesListStrings.name,
                              validator: TextFieldsValidators.checkNotEmpty,
                              onFieldSubmitted: (name) {
                                wm.data.addAll(
                                  {PlacesListStrings.name: name ?? ''},
                                );
                                debugPrint(name);
                              },
                            ),
                            const SizedBox(height: 24),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CommonTextField(
                                    title: PlacesListStrings.lat,
                                    keyboardType: TextInputType.datetime,
                                    validator:
                                        TextFieldsValidators.checkLatitude,
                                    onFieldSubmitted: (lat) => wm.data.addAll(
                                      {PlacesListStrings.lat: lat ?? ''},
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: CommonTextField(
                                    title: PlacesListStrings.lng,
                                    keyboardType: TextInputType.datetime,
                                    validator:
                                        TextFieldsValidators.checkLongitude,
                                    onFieldSubmitted: (lng) => wm.data.addAll(
                                      {PlacesListStrings.lng: lng ?? ''},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            InkWell(
                              onTap: wm.onSetOnMapButton,
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
                              title: PlacesListStrings.description,
                              maxLines: 3,
                              textInputAction: TextInputAction.done,
                              validator: TextFieldsValidators.checkNotEmpty,
                              onFieldSubmitted: (description) => wm.data.addAll(
                                {
                                  PlacesListStrings.description:
                                      description ?? '',
                                },
                              ),
                            ),
                            const SizedBox(height: 40),
                            StateNotifierBuilder<bool>(
                              listenableState: wm.isValidState,
                              builder: (_, isValid) {
                                return FloatingActionButton.extended(
                                  onPressed: isValid ?? false
                                      ? wm.onAddNewPlace
                                      : null,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  backgroundColor: isValid ?? false
                                      ? null
                                      : wm.theme.primaryColor,
                                  label: Text(
                                    PlacesListStrings.create,
                                    style: wm.theme.textTheme.button?.copyWith(
                                      color: isValid ?? false
                                          ? null
                                          : wm.theme.disabledColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ...isLoadingInProgress ?? false
                  ? [
                      const Center(child: CircularProgressIndicator()),
                    ]
                  : [],
            ],
          ),
        );
      },
    );
  }
}
