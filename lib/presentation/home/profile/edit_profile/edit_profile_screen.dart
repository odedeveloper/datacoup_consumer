import 'dart:developer';
import 'dart:io';

import 'package:csc_picker/csc_picker.dart';
import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/widgets/drop_down_widget.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final controller = Get.find<HomeController>();
  String? genderInitialData = '';

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    controller.fnameTextContoller.text = controller.user!.value.firstName!;
    controller.lnaemTextContoller.text = controller.user!.value.lastName!;
    controller.emailTextContoller.text = controller.user!.value.email!;
    controller.mobileTextContoller.text = controller.user!.value.mobile!;
    controller.zipCodeTextContoller.text = controller.user!.value.zipCode!;
    if (controller.user!.value.gender == null ||
        controller.user!.value.gender == "") {
      genderInitialData = "Select Gender";
    } else {
      genderInitialData = controller.user!.value.gender;
    }

    if (controller.user!.value.country != null ||
        controller.user!.value.country != "") {
      controller.selectedreturnCountry(controller.user!.value.country!);
    } else {
      controller.selectedreturnCountry("Select Country");
    }

    if (controller.user!.value.state != null ||
        controller.user!.value.state != "") {
      controller.selectedreturnState(controller.user!.value.state!);
    } else {
      controller.selectedreturnState("Select State");
    }
    controller.profileLoader(false);
  }

  showUpdageButton() {
    if (controller.fnameTextContoller.text ==
            controller.user!.value.firstName &&
        controller.lnaemTextContoller.text == controller.user!.value.lastName &&
        controller.emailTextContoller.text == controller.user!.value.email &&
        controller.mobileTextContoller.text == controller.user!.value.mobile &&
        genderInitialData == controller.user!.value.gender &&
        controller.selectedreturnCountry.value ==
            controller.user!.value.country &&
        controller.selectedreturnState.value == controller.user!.value.state &&
        controller.zipCodeTextContoller.text ==
            controller.user!.value.zipCode) {
      controller.showSaveButton(false);
    } else {
      controller.showSaveButton(true);
    }
    log("is Update ${controller.showSaveButton.value}");
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Edit Profile",
            style: themeTextStyle(
              context: context,
              fweight: FontWeight.bold,
            ),
          ),
          actions: [
            controller.showSaveButton.value
                ? TextButton(
                    onPressed: () {},
                    child: Text(
                      "Update",
                      style: themeTextStyle(
                        context: context,
                        fweight: FontWeight.w600,
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
        body: controller.profileLoader.value
            ? ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                padding: const EdgeInsets.all(12),
                itemCount: 8,
                itemBuilder: (context, index) => SizedBox(
                  height: height(context)! * 0.15,
                  width: double.infinity,
                  child: const ShimmerBox(
                      height: double.infinity,
                      width: double.infinity,
                      radius: 12),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Stack(
                        children: [
                          InkWell(
                            onTap: () => _showPicker(context),
                            child: CircleAvatar(
                              radius: width(context)! * 0.15,
                              backgroundImage: NetworkImage(
                                  controller.user!.value.profileImage!),
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          Positioned(
                            bottom: 0.0,
                            right: 1.0,
                            child: InkWell(
                              onTap: () => _showPicker(context),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .appBarTheme
                                        .backgroundColor!,
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 0.4, spreadRadius: 0.4)
                                    ],
                                    borderRadius: BorderRadius.circular(50)),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Select Profile Photo",
                        style: themeTextStyle(context: context),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: CustomLoginTextField(
                              controller: controller.fnameTextContoller,
                              label: "First Name",
                              onChanged: (p0) => showUpdageButton(),
                            ),
                          ),
                          Expanded(
                            child: CustomLoginTextField(
                              controller: controller.lnaemTextContoller,
                              label: "Last Name",
                              onChanged: (p0) => showUpdageButton(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      CustomLoginTextField(
                        controller: controller.emailTextContoller,
                        label: "Email",
                        onChanged: (p0) => showUpdageButton(),
                      ),
                      const SizedBox(height: 10),
                      CustomLoginTextField(
                        controller: controller.mobileTextContoller,
                        label: "Phone Number",
                        onChanged: (p0) => showUpdageButton(),
                      ),
                      const SizedBox(height: 10),
                      DropDownWidget(
                        hintText: genderInitialData,
                        dropMenuList: controller.genderList,
                        labelText: "Gender",
                        selectedReturnValue: (val) {
                          showUpdageButton();
                          controller.selectedreturnGender(val);
                        },
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Country",
                              textAlign: TextAlign.center,
                              style: themeTextStyle(
                                context: context,
                                tColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.6),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "State",
                              textAlign: TextAlign.center,
                              style: themeTextStyle(
                                context: context,
                                tColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.6),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      CSCPicker(
                        showCities: false,
                        currentCountry: controller.selectedreturnCountry.value,
                        stateDropdownLabel:
                            controller.selectedreturnState.value,
                        dropdownDecoration: BoxDecoration(
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(kBorderRadius),
                          boxShadow: const [
                            BoxShadow(spreadRadius: 0.4, blurRadius: 0.4)
                          ],
                        ),
                        disabledDropdownDecoration: BoxDecoration(
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(kBorderRadius),
                          boxShadow: const [
                            BoxShadow(spreadRadius: 0.4, blurRadius: 0.4)
                          ],
                        ),
                        flagState: CountryFlag.DISABLE,
                        disableCountry: false,
                        selectedItemStyle: themeTextStyle(context: context),
                        onCountryChanged: (value) {
                          controller.selectedreturnCountry(value);
                          showUpdageButton();
                        },
                        onStateChanged: (value) {
                          controller.selectedreturnState(value);
                          showUpdageButton();
                        },
                        onCityChanged: (value) {},
                      ),
                      const SizedBox(height: 10),
                      CustomLoginTextField(
                        controller: controller.zipCodeTextContoller,
                        label: "Zip-code",
                        onChanged: (p0) => showUpdageButton(),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              textColor: Theme.of(context).primaryColor,
              leading: const Icon(Icons.photo_library),
              title: const Text('Photo Library'),
              onTap: () async {
                await _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              textColor: Theme.of(context).primaryColor,
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () async {
                await _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        controller.profileImage = img;
        Navigator.pop(context);
      });
    } catch (e) {
      log("error to load profile image from $source $e");
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        compressQuality: 80,
        uiSettings: [
          AndroidUiSettings(activeControlsWidgetColor: deepOrangeColor),
        ]);
    if (croppedImage == null) {
      // showSaveButton = false;
      return null;
    } else {
      // profileImgChange = 1;
      // showSaveButton = true;
      return File(croppedImage.path);
    }
  }
}

class LightLabelWidget extends StatelessWidget {
  final String? label;
  final double? fontsize;
  final TextAlign? textAlign;
  const LightLabelWidget(
      {Key? key, required this.label, this.textAlign, this.fontsize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          label!,
          textAlign: textAlign,
          style: themeTextStyle(
            context: context,
            letterSpacing: 0.9,
            fsize: fontsize,
            fontFamily: AssetConst.ralewayFont,
            tColor: Colors.grey[400],
            fweight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
