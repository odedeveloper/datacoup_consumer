import 'package:datacoup/export.dart';

class SplachController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  SplachController({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  @override
  void onReady() {
    validateSession();
    validateTheme();
    super.onReady();
  }

  void validateTheme() async {
    final isDark = await localRepositoryInterface.isDarkMode();
    if (isDark != null) {
      Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
  }

  void validateSession() async {
    await apiRepositoryInterface.cogintoRegister();
    // bool result = await apiRepositoryInterface.checkAuthenticated();
    // log("user valid $result");
    // if (result) {
    //   Get.offNamed(AppRoutes.home);
    // } else {
    // }
    Get.offNamed(AppRoutes.login);
  }
}
