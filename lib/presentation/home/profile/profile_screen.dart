import 'package:datacoup/export.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    controller.profileLoader(true);
    controller.user!.value = User.empty();
    LoginResponse? response =
        await controller.apiRepositoryInterface.fetchUserProfile();
    controller.user!(response!.user);
    controller.profileLoader(false);
    controller.updatePressed(false);
  }

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(
                () => controller.user!.value.profileImage == null
                    ? SizedBox(
                        height: height(context)! * 0.2,
                        width: double.infinity,
                        child: const ShimmerBox(
                            height: double.infinity,
                            width: double.infinity,
                            radius: 12),
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  controller.user!.value.profileImage!),
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${controller.user!.value.firstName!} ${controller.user!.value.lastName}",
                                    style: themeTextStyle(
                                      context: context,
                                      fweight: FontWeight.bold,
                                      fsize: kmaxExtraLargeFont(context),
                                    ),
                                  ),
                                  Text(
                                    controller.user!.value.email!,
                                    style: themeTextStyle(context: context),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              onPressed: () async {
                                controller.showSaveButton(false);
                                controller.profileImage = null;
                                await Get.to(() => const EditProfileScreen())!
                                    .then((_) async {
                                  if (controller.updatePressed.value == true) {
                                    loadData();
                                  }
                                });
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.pen,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 20),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "App Settings",
                        style: themeTextStyle(
                          context: context,
                          fsize: klargeFont(context),
                          tColor: darkSkyBlueColor,
                          fweight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      tileWithIcon(
                        context,
                        icon: FontAwesomeIcons.language,
                        title: "Language",
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: tileWithIcon(
                              context,
                              icon: FontAwesomeIcons.moon,
                              title: "Dark Mode",
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Transform.scale(
                                scale: 1.2,
                                child: Switch(
                                  value: controller.darkTheme.value,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                  onChanged: onThemeUpdated,
                                  activeColor: deepOrangeColor,
                                  inactiveTrackColor: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      tileWithIcon(
                        context,
                        icon: FontAwesomeIcons.bell,
                        title: "Notifiaction",
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "General",
                        style: themeTextStyle(
                          context: context,
                          fsize: klargeFont(context),
                          tColor: darkSkyBlueColor,
                          fweight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      tileWithIcon(
                        context,
                        icon: Icons.privacy_tip_outlined,
                        title: "Policy and guidelines",
                      ),
                      const SizedBox(height: 20),
                      tileWithIcon(
                        context,
                        icon: FontAwesomeIcons.fileLines,
                        title: "Legal",
                      ),
                      const SizedBox(height: 20),
                      tileWithIcon(
                        context,
                        icon: Icons.help_center_outlined,
                        title: "Help",
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: width(context)! * 0.3,
                          child: RoundedElevatedButton(
                            onClicked: () => logout(),
                            title: "Logout",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tileWithIcon(BuildContext context, {String? title, IconData? icon}) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          radius: 20,
          child: Center(
            child: FaIcon(
              icon!,
              color: deepOrangeColor,
              size: 20,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title!,
          style: themeTextStyle(
            context: context,
            fweight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
