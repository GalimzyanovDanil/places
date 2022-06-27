import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';

enum ImagePickerSource {
  gallery(
    AppAssets.iconPhoto,
    PlacesListStrings.photo,
  ),
  camera(
    AppAssets.iconCamera,
    PlacesListStrings.camera,
  );

  final String iconPath;
  final String title;

  const ImagePickerSource(this.iconPath, this.title);
}

class ImagePickerRepositry {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage(ImagePickerSource source) async {
    final ImageSource imageSource;
    switch (source) {
      case ImagePickerSource.gallery:
        imageSource = ImageSource.gallery;
        break;
      case ImagePickerSource.camera:
        imageSource = ImageSource.camera;
        break;
    }

    final image = await _picker.pickImage(source: imageSource);
    return image != null ? File(image.path) : null;
  }
}
