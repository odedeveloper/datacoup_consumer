import 'dart:developer';
import 'dart:io';

import 'package:datacoup/export.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  bool isAfterProfile = false;
  EditProfileScreen({this.isAfterProfile = false, super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final controller = Get.find<HomeController>();
  String? genderInitialData = '';
  LoginResponse? loginResponse;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    controller.profileLoader(true);
    loginResponse = await controller.apiRepositoryInterface.fetchUserProfile();
    controller.fnameTextContoller!.text = loginResponse!.user!.firstName!;
    controller.lnaemTextContoller!.text = loginResponse!.user!.lastName!;
    controller.emailTextContoller!.text = loginResponse!.user!.email!;
    controller.mobileTextContoller!.text = loginResponse!.user!.phone!;
    controller.zipCodeTextContoller!.text = loginResponse!.user!.zipCode!;
    controller.dobTextContoller!.text = loginResponse!.user!.dob!;

    if (loginResponse!.user!.gender == null ||
        loginResponse!.user!.gender == "") {
      genderInitialData = "Select Gender";
      controller.selectedreturnGender!("");
    } else {
      genderInitialData = loginResponse!.user!.gender;
      controller.selectedreturnGender!(genderInitialData);
    }

    if (loginResponse!.user!.country != null ||
        loginResponse!.user!.country != "") {
      controller.selectedreturnCountry!(loginResponse!.user!.country!);
    } else {
      controller.selectedreturnCountry!("Select Country");
    }

    if (loginResponse!.user!.state != null ||
        loginResponse!.user!.state != "") {
      controller.selectedreturnState!(loginResponse!.user!.state!);
    } else {
      controller.selectedreturnState!("Select State");
    }
    controller.profileLoader(false);
  }

  showUpdageButton() {
    if (controller.fnameTextContoller!.text == loginResponse!.user!.firstName &&
        controller.dobTextContoller!.text == loginResponse!.user!.dob! &&
        controller.profileImageChange.value ==
            loginResponse!.user!.profileImageChange &&
        controller.lnaemTextContoller!.text == loginResponse!.user!.lastName &&
        controller.emailTextContoller!.text == loginResponse!.user!.email &&
        controller.mobileTextContoller!.text == loginResponse!.user!.phone &&
        controller.selectedreturnGender!.value == loginResponse!.user!.gender &&
        controller.selectedreturnCountry!.value ==
            loginResponse!.user!.country &&
        controller.selectedreturnState!.value == loginResponse!.user!.state &&
        controller.zipCodeTextContoller!.text == loginResponse!.user!.zipCode) {
      controller.showSaveButton(false);
    } else {
      controller.showSaveButton(true);
    }
  }

  updateUserDetails() async {
    controller.updatePressed(true);
    controller.profileLoader(true);
    await controller.updateUser();
    loadData();
    controller.showSaveButton(false);
  }

  Future openDialog(bool isByEmail) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Column(
            children: [
              Center(
                  child: CustomText(
                'You will recieve an OTP on your changed ${isByEmail ? 'Email.' : 'Mobile Number.'} \n Do you wish to edit your ${isByEmail ? 'Email' : 'Mobile Number'}?',
                fontFamily: AssetConst.QUICKSAND_FONT,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColorLight,
                alignment: TextAlign.center,
              )),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            GetBuilder<UserProfileController>(builder: (userProfilecontroller) {
              return TextButton(
                  onPressed: () async {
                    controller.editEmailOrPhonePressed(true);
                    await Get.to(() => EditEmailPhone(
                          isEmail: isByEmail,
                        ));
                    Get.back();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: darkSkyBlueColor,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                  ),
                  child: CustomText("Edit",
                      color: whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700));
            }),
            TextButton(
                onPressed: () {
                  controller.editEmailOrPhonePressed(false);
                  Get.back();
                },
                style: TextButton.styleFrom(
                  backgroundColor: redOpacityColor,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                ),
                child: CustomText("Cancel",
                    color: whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (widget.isAfterProfile) {
                Navigator.pop(context);
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.arrow_back_ios),
            //replace with our own icon data.
          ),
          centerTitle: true,
          title: Text(
            "Edit Profile",
            style: themeTextStyle(
              fsize: klargeFont(context),
              context: context,
              fweight: FontWeight.bold,
            ),
          ),
          actions: [
            controller.showSaveButton.value
                ? TextButton(
                    onPressed: () => updateUserDetails(),
                    child: Text(
                      "Update",
                      style: themeTextStyle(
                        context: context,
                        tColor: deepOrangeColor,
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
                padding: const EdgeInsets.all(20),
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
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Stack(
                          children: [
                            InkWell(
                              onTap: () => _showPicker(context),
                              child: controller.profileImage != null
                                  ? CircleAvatar(
                                      radius: 65,
                                      backgroundColor: Colors.grey,
                                      backgroundImage:
                                          FileImage(controller.profileImage!),
                                    )
                                  : controller.user!.value.profileImage!
                                              .contains("jpg") ||
                                          controller.user!.value.profileImage!
                                              .contains("png")
                                      ? Material(
                                          borderRadius: BorderRadius.circular(
                                              width(context)! * 0.17),
                                          elevation: 10,
                                          child: CircleAvatar(
                                            radius: width(context)! * 0.17,
                                            backgroundColor: deepOrangeColor,
                                            child: CircleAvatar(
                                              radius: width(context)! * 0.16,
                                              backgroundImage: controller
                                                          .profileImage !=
                                                      null
                                                  ? FileImage(controller
                                                          .profileImage!)
                                                      as ImageProvider
                                                  : NetworkImage(loginResponse!
                                                      .user!.profileImage!),
                                              backgroundColor: deepOrangeColor,
                                            ),
                                          ),
                                        )
                                      : const CircleAvatar(
                                          radius: 65,
                                          backgroundColor: Colors.grey,
                                          child: FaIcon(
                                            FontAwesomeIcons.solidUser,
                                            size: 60,
                                            color: deepOrangeColor,
                                          ),
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
                                      color: deepOrangeColor,
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 0.4, spreadRadius: 0.4)
                                      ],
                                      borderRadius: BorderRadius.circular(50)),
                                  child: FaIcon(
                                    FontAwesomeIcons.image,
                                    size: 18,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                            const SizedBox(width: 20),
                            Expanded(
                              child: CustomLoginTextField(
                                controller: controller.lnaemTextContoller,
                                label: "Last Name",
                                onChanged: (p0) => showUpdageButton(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () async {
                            await openDialog(true).then(
                              (value) {
                                if (controller.editEmailOrPhonePressed.value ==
                                    true) {
                                  loadData();
                                }
                              },
                            );
                          },
                          child: CustomLoginTextField(
                            controller: controller.emailTextContoller,
                            label: "Email",
                            enabledEdit: false,
                            // onChanged: (p0) => showUpdageButton(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () async {
                            await openDialog(false).then(
                              (value) {
                                if (controller.editEmailOrPhonePressed.value ==
                                    true) {
                                  loadData();
                                }
                              },
                            );
                          },
                          child: CustomLoginTextField(
                            controller: controller.mobileTextContoller,
                            label: "Phone Number",
                            enabledEdit: false,
                            // onChanged: (p0) => showUpdageButton(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Gender",
                            style: themeTextStyle(
                              context: context,
                              letterSpacing: 0.9,
                              fontFamily: AssetConst.RALEWAY_FONT,
                              tColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.6),
                              fweight: FontWeight.w500,
                            ),
                          ),
                        ),
                        DropDownWidget(
                          hintText: controller.selectedreturnGender!.value,
                          dropMenuList: controller.genderList,
                          labelText: "Gender",
                          selectedReturnValue: (val) {
                            controller.selectedreturnGender!(val);
                            showUpdageButton();
                          },
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () => selectDate(),
                          child: CustomLoginTextField(
                            controller: controller.dobTextContoller,
                            label: "Date of Birth",
                            enabledEdit: false,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Country",
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
                                  "   State",
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
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CSCPicker(
                            showCities: false,
                            currentCountry:
                                controller.selectedreturnCountry!.value,
                            stateDropdownLabel:
                                controller.selectedreturnState!.value,
                            dropdownDecoration: BoxDecoration(
                              color:
                                  Theme.of(context).appBarTheme.backgroundColor,
                              borderRadius:
                                  BorderRadius.circular(kBorderRadius),
                              boxShadow: const [
                                BoxShadow(spreadRadius: 0.4, blurRadius: 0.4)
                              ],
                            ),
                            disabledDropdownDecoration: BoxDecoration(
                              color:
                                  Theme.of(context).appBarTheme.backgroundColor,
                              borderRadius:
                                  BorderRadius.circular(kBorderRadius),
                              boxShadow: const [
                                BoxShadow(spreadRadius: 0.4, blurRadius: 0.4)
                              ],
                            ),
                            flagState: CountryFlag.DISABLE,
                            disableCountry: false,
                            selectedItemStyle: themeTextStyle(context: context),
                            onCountryChanged: (value) {
                              controller.selectedreturnCountry!(value);
                              showUpdageButton();
                            },
                            onStateChanged: (value) {
                              controller.selectedreturnState!(value);
                              showUpdageButton();
                            },
                            onCityChanged: (value) {},
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomLoginTextField(
                          controller: controller.zipCodeTextContoller,
                          label: "Zip-code",
                          onChanged: (p0) => showUpdageButton(),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Future selectDate() async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (selected != null && selected != DateTime.now()) {
      DateFormat dateFormat = DateFormat("dd-MM-yyyy");
      String date = dateFormat.format(selected);
      controller.dobTextContoller!.text = (date);
      controller.showSaveButton(true);
    } else {
      controller.showSaveButton(false);
    }
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
      controller.profileImage = img;
      Get.back();
    } catch (e) {
      log("error to load profile image from $source $e");
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        compressQuality: 80,
        uiSettings: [
          AndroidUiSettings(activeControlsWidgetColor: deepOrangeColor),
        ]);
    if (croppedImage == null) {
      controller.profileImageChange(false);
      controller.showSaveButton(false);
      return null;
    } else {
      controller.profileImageChange(true);
      controller.showSaveButton(true);
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
            fontFamily: AssetConst.RALEWAY_FONT,
            tColor: Colors.grey[400],
            fweight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
