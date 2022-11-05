import 'package:datacoup/export.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final controller = Get.find<HomeController>();

  Future<void> logout() async {
    await controller.logOut();
    Get.offAllNamed(AppRoutes.splash);
  }

  void onThemeUpdated(bool isDark) {
    controller.updateTheme(isDark);
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = controller.user?.value;
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Profile",
            style: themeTextStyle(
              context: context,
              fweight: FontWeight.bold,
            ),
          ),
        ),
        body: user?.profileImage != null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user!.profileImage!),
                    ),
                    const SizedBox(height: 30),
                    Text(user.profileImage!),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Dark Mode"),
                        Obx(
                          () => Switch(
                            value: controller.darkTheme.value,
                            onChanged: onThemeUpdated,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () => logout(),
                      child: const Text("Log Out"),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
      );
    });
  }
}
