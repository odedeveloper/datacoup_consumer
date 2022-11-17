import 'package:datacoup/export.dart';
import 'package:image_picker/image_picker.dart';

showImagePickerModal(BuildContext context) async {
  var result = await showModalBottomSheet(
    context: context,
    builder: (context) {
      return GetBuilder<ImagePickerController>(builder: (controller) {
        return SizedBox(
          height: 150,
          child: Column(
            children: [
              const SizedBox(height: 15),
              Text(
                "Choose Photo",
                style: TextStyle(
                  fontFamily: AssetConst.RALEWAY_FONT,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: darkGreyColor,
                  letterSpacing: 0.9,
                ),
              ),
              ListTile(
                focusColor: lightGreyColor,
                selectedColor: lightGreyColor,
                onTap: () async {
                  await controller.getImageFromDevice(ImageSource.camera);
                  Navigator.pop(context, controller.imagePath);
                },
                leading: const Icon(
                  Icons.camera,
                  size: 30,
                ),
                title: Text(
                  'Camera',
                  style: TextStyle(
                    fontFamily: AssetConst.QUICKSAND_FONT,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: darkGreyColor,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await controller.getImageFromDevice(ImageSource.gallery);
                  Navigator.of(context).pop(controller.imagePath);
                },
                child: ListTile(
                  leading: const Icon(Icons.photo),
                  title: Text(
                    'Gallery',
                    style: TextStyle(
                      fontFamily: AssetConst.QUICKSAND_FONT,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: darkGreyColor,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
    },
  );

  return result;
}
