import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

final imagePickerHandler = ImagePickerHandler();

class ImagePickerHandler implements ImagePickerInterface {
  ImagePickerHandler();

  @override
  Future<String?> pickImageFromCamera() async {
    try {
      final image =
          await ImagePicker.platform.pickImage(source: ImageSource.camera);
      return image!.path;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> pickImageFromGallery() async {
    try {
      final image =
          await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      return image!.path;
    } catch (e) {
      return null;
    }
  }
}

abstract class ImagePickerInterface {
  Future<String?> pickImageFromCamera();

  Future<String?> pickImageFromGallery();
}
