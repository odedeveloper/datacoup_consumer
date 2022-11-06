import 'package:datacoup/export.dart';

class HomeController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  Rx<User>? user = User.empty().obs;
  RxInt onIndexSelected = 0.obs;
  RxBool darkTheme = false.obs;
  RxBool profileLoader = true.obs;

  final fnameTextContoller = TextEditingController();
  final lnaemTextContoller = TextEditingController();
  final emailTextContoller = TextEditingController();
  final mobileTextContoller = TextEditingController();
  final phoneNumberTextContoller = TextEditingController();
  final passwordTextContoller = TextEditingController();

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
    final token = await localRepositoryInterface.getToken();
    await apiRepositoryInterface.logout(token);
    await localRepositoryInterface.clearAllData();
  }
}
