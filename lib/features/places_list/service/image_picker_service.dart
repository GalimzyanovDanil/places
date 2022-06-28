import 'dart:io';
import 'package:places/features/places_list/domain/repository/image_pick_repository.dart';

class ImagePickerService {
  final ImagePickerRepositry _imagePickerRepositry;

  ImagePickerService(this._imagePickerRepositry);

  Future<File?> pickImage(ImagePickerSource source) =>
      _imagePickerRepositry.pickImage(source);
}
