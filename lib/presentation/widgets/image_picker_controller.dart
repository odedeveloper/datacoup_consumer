import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  String imagePath = '';

  updateImagePath(String value) {
    imagePath = value;
    update();
  }

  getImageFromDevice(ImageSource source) async {
    var imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(
        source: source,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    if (image != null) {
      updateImagePath(image.path);
      return image.path;
    }
  }

  getImagePath() {
    return imagePath;
  }
}
