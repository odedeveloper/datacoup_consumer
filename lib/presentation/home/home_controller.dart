import 'dart:developer';
import 'dart:io';

import 'package:datacoup/export.dart';

class HomeController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  Rx<User>? user = User.empty().obs;
  RxInt onIndexSelected = 0.obs;
  RxBool darkTheme = false.obs;
  RxBool profileImageChange = false.obs;
  RxBool profileLoader = true.obs;
  RxBool showSaveButton = false.obs;
  RxBool updatePressed = false.obs;
  final TextEditingController? fnameTextContoller = TextEditingController();
  final TextEditingController? lnaemTextContoller = TextEditingController();
  final TextEditingController? emailTextContoller = TextEditingController();
  final TextEditingController? mobileTextContoller = TextEditingController();
  final TextEditingController? phoneNumberTextContoller =
      TextEditingController();
  final TextEditingController? passwordTextContoller = TextEditingController();
  final TextEditingController? zipCodeTextContoller = TextEditingController();
  final TextEditingController? dobTextContoller = TextEditingController();
  RxString? selectedreturnGender = ''.obs;
  RxString? selectedreturnCountry = ''.obs;
  RxString? selectedreturnState = ''.obs;
  File? profileImage;

  List<String?> genderList = ["Male", "Female", "Other"];

  HomeController({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  @override
  void onReady() {
    loadUser();
    loadCurrentTheme();
    super.onReady();
  }

  void loadCurrentTheme() async {
    await localRepositoryInterface.isDarkMode().then((value) {
      darkTheme(value);
    });
  }

  updateController() {
    update();
  }

  Future<bool> updateTheme(bool isDark) async {
    await localRepositoryInterface.saveDarkMode(isDark);
    darkTheme(isDark);
    return isDark;
  }

  void updateIndexSelected(int index) {
    onIndexSelected(index);
  }

  void loadUser() async {
    LoginResponse? loginResponse =
        await apiRepositoryInterface.fetchUserProfile();
    user!(loginResponse!.user);
    zipCodeTextContoller!.text = loginResponse.user!.zipCode!;
    selectedreturnCountry!(loginResponse.user!.country);
    selectedreturnState!(loginResponse.user!.state);
  }

  Future<void> updateUser() async {
    try {
      String? newProfileImageUrl;
      if (profileImageChange.value == true) {
        newProfileImageUrl =
            await apiRepositoryInterface.uploadProfileImage(profileImage!.path);
      }
      LoginResponse? loginResponse =
          await apiRepositoryInterface.fetchUserProfile();
      User user = User(
        email: emailTextContoller?.text ?? loginResponse!.user!.email,
        firstName: fnameTextContoller?.text ?? loginResponse!.user!.firstName,
        lastName: lnaemTextContoller?.text ?? loginResponse!.user!.lastName,
        gender: selectedreturnGender?.value ?? loginResponse!.user!.gender,
        country: selectedreturnCountry?.value ?? loginResponse!.user!.country,
        dob: dobTextContoller?.text ?? loginResponse!.user!.dob,
        mobile: mobileTextContoller?.text ?? loginResponse!.user!.mobile,
        state: selectedreturnState?.value ?? loginResponse!.user!.state,
        profileImage: newProfileImageUrl ?? loginResponse!.user!.profileImage,
        zipCode: zipCodeTextContoller?.text ?? loginResponse!.user!.zipCode!,
      );
      await apiRepositoryInterface.createUpdateUser(user);
    } catch (e) {
      log("Failed to update user $e");
    }
  }

  Future<void> logOut() async {
    String token = GetStorage().read("idToken") ?? "";
    await apiRepositoryInterface.logout(token);
    await localRepositoryInterface.storeUserLogin(log: false);
    await localRepositoryInterface.clearAllData();
  }
}
