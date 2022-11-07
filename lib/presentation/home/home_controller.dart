import 'dart:io';

import 'package:datacoup/export.dart';

class HomeController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  Rx<User>? user = User.empty().obs;
  RxInt onIndexSelected = 0.obs;
  RxBool darkTheme = false.obs;
  RxBool profileLoader = true.obs;
  RxBool showSaveButton = false.obs;
  final fnameTextContoller = TextEditingController();
  final lnaemTextContoller = TextEditingController();
  final emailTextContoller = TextEditingController();
  final mobileTextContoller = TextEditingController();
  final phoneNumberTextContoller = TextEditingController();
  final passwordTextContoller = TextEditingController();
  final zipCodeTextContoller = TextEditingController();
  RxString selectedreturnGender = ''.obs;
  RxString selectedreturnCountry = ''.obs;
  RxString selectedreturnState = ''.obs;
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
  }

  Future<void> logOut() async {
    String token = GetStorage().read("idToken") ?? "";
    await apiRepositoryInterface.logout(token);
    await localRepositoryInterface.clearAllData();
  }
}
