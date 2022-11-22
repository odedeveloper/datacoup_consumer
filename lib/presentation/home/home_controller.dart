import 'dart:developer';
import 'dart:io';

import 'package:datacoup/export.dart';

class HomeController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  Rx<UserModel>? user = UserModel.empty().obs;
  RxInt onIndexSelected = 0.obs;
  RxBool darkTheme = false.obs;
  RxBool profileImageChange = false.obs;
  RxBool profileLoader = true.obs;
  RxBool showSaveButton = false.obs;
  RxBool updatePressed = false.obs;
  RxBool editEmailOrPhonePressed = false.obs;
  String language = "English";
  List<String> supportedLanguages = ["English", "Hindi"];
  final Map<String, Locale> _locales = {
    "English": const Locale('en', 'US'),
    "Hindi": const Locale('hi', 'IN')
  };
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
  String countryCode = '+91';
  File? profileImage;

  List<String?> genderList = ["Male", "Female", "Other"];

  HomeController({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  updateCountryCode(value) {
    countryCode = '+$value';
    update();
  }

  updateLanguage(String value) {
    language = value;
    Get.updateLocale(_locales[value]!);
    GetStorage().write("Language", value);
    update();
  }

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
    final newsController = Get.find<NewsController>();
    LoginResponse? loginResponse =
        await apiRepositoryInterface.fetchUserProfile();
    user!(loginResponse!.user);
    zipCodeTextContoller!.text = loginResponse.user!.zipCode!;
    selectedreturnCountry!(loginResponse.user!.country);
    selectedreturnState!(loginResponse.user!.state);
    newsController.selectedState(loginResponse.user!.state);
    newsController.selectedcountry(loginResponse.user!.country);
    newsController.selectedzipCode(loginResponse.user!.zipCode);
  }

  Future<void> updateUser() async {
    try {
      final newsController = Get.find<NewsController>();
      String? newProfileImageUrl;
      if (profileImageChange.value == true) {
        newProfileImageUrl =
            await apiRepositoryInterface.uploadProfileImage(profileImage!.path);
      }
      LoginResponse? loginResponse =
          await apiRepositoryInterface.fetchUserProfile();
      UserModel user = UserModel(
        bestScore: loginResponse!.user!.bestScore,
        emailVerified: loginResponse.user!.emailVerified,
        odenId: loginResponse.user!.odenId,
        phoneVerified: loginResponse.user!.phoneVerified,
        primary: loginResponse.user!.primary,
        email: emailTextContoller?.text ?? loginResponse.user!.email,
        firstName: fnameTextContoller?.text ?? loginResponse.user!.firstName,
        lastName: lnaemTextContoller?.text ?? loginResponse.user!.lastName,
        gender: selectedreturnGender?.value ?? loginResponse.user!.gender,
        country: selectedreturnCountry?.value ?? loginResponse.user!.country,
        dob: dobTextContoller?.text ?? loginResponse.user!.dob,
        phone: mobileTextContoller?.text ?? loginResponse.user!.phone,
        state: selectedreturnState?.value ?? loginResponse.user!.state,
        profileImage: newProfileImageUrl ?? loginResponse.user!.profileImage,
        zipCode: zipCodeTextContoller?.text ?? loginResponse.user!.zipCode,
      );
      newsController.selectedcountry(
          selectedreturnCountry?.value ?? loginResponse.user!.country);
      newsController.selectedState(
          selectedreturnState?.value ?? loginResponse.user!.state);
      newsController.selectedzipCode(
          zipCodeTextContoller?.text ?? loginResponse.user!.zipCode);
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
