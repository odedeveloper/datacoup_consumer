import 'dart:math';
import 'package:datacoup/data/configs/app_setting_controller.dart';
import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/authentication/account/update_account.dart';
import 'package:datacoup/presentation/authentication/auth_controller/navigation_controller.dart';
import 'package:datacoup/presentation/authentication/auth_controller/user_profile_controller.dart';
import 'package:datacoup/presentation/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  void _logout(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Log out'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () async {
                  final authController = Get.find<AuthenticationController>();
                  await authController.logOut();
                  Get.delete<LoginController>();
                  Get.delete<HomeController>();
                  Get.delete<NavigationController>();
                  Get.delete<UserProfileController>();
                  Get.offAll(() => Login());
                },
                isDefaultAction: true,
                isDestructiveAction: true,
                child: const Text('Yes'),
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                isDefaultAction: false,
                isDestructiveAction: false,
                child: const Text('No'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 20 * SizeConfig().heightScale),
            GetBuilder<UserProfileController>(builder: (controller) {
              return Row(children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: (controller.user == null)
                          ? const ShimmerBox(
                              height: 110, width: 110, radius: 55)
                          : controller.user!.profileImage!.contains(".jpg") ||
                                  controller.user!.profileImage!.contains(".png")
                              ? Image.network(
                                  controller.user!.profileImage!,
                                  errorBuilder: (context, error, map) {
                                    return Container(
                                      height: 110,
                                      width: 110,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(55)),
                                    );
                                  },
                                  height: 80.0,
                                  width: 80.0,
                                  fit: BoxFit.fill,
                                )
                              : Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Icon(Icons.person, size: 60),
                                )),
                ),
                SizedBox(width: 10 * SizeConfig().widthScale),
                (controller.user == null)
                    ? ShimmerBox(
                        height: 45,
                        width: 210 * SizeConfig().widthScale,
                        radius: 5)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${controller.user!.firstName} ${controller.user!.lastName}",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontFamily: AssetConst.QUICKSAND_FONT,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.8)),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 210 * SizeConfig().widthScale,
                            child: Text(controller.user!.email!,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontFamily: AssetConst.QUICKSAND_FONT,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.7)),
                          ),
                        ],
                      ),
                const Spacer(),
                (controller.user == null)
                    ? Container()
                    : Transform.rotate(
                        angle: pi,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: blueGreyLight,
                          ),
                          child: IconButton(
                            // splashColor: Colors.grey.shade200,
                            highlightColor: lightGreyColor,
                            splashRadius: 20,
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 20,
                              color: darkBlueGreyColor,
                            ),
                            onPressed: () async {
                              controller.isUpdating(false);
                              controller.loadUpdatedUserData();
                              await Get.to(() => UpdateAccount())!.then(
                                  (value) => controller.fetchUserProfile());
                            },
                          ),
                        ),
                      ),
              ]);
            }),
            SizedBox(height: 30 * SizeConfig().heightScale),
            Container(
              alignment: Alignment.centerLeft,
              child: Text("appSetting".tr,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.9,
                    fontFamily: AssetConst.QUICKSAND_FONT,
                  )),
            ),
            SizedBox(height: 10 * SizeConfig().heightScale),
            AppSetting(),
            SizedBox(height: 25 * SizeConfig().heightScale),
            Container(
              alignment: Alignment.centerLeft,
              child: Text("general".tr,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    letterSpacing: 0.9,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    fontFamily: AssetConst.QUICKSAND_FONT,
                  )),
            ),
            SizedBox(height: 10 * SizeConfig().heightScale),
            GeneralSetting(),
            SizedBox(height: 10 * SizeConfig().heightScale),
            Container(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    _logout(context);
                  },
                  child: Text("logOut".tr,
                      style: const TextStyle(
                        color: redOpacityColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.9,
                        fontFamily: AssetConst.RALEWAY_FONT,
                      )),
                ))
          ],
        ),
      ),
    );
  }
}

class AppSetting extends StatelessWidget {
  AppSetting({Key? key}) : super(key: key);

  final List<String> appSettings = ["language", "darkMode"];
  final List<String> appSettingsLogo = [
    AssetConst.LANGUAGE_LOGO,
    AssetConst.DARK_MODE_LOGO
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(2, (index) {
      return Column(
        children: [
          const SizedBox(height: 2),
          Row(
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Image.asset(
                  appSettingsLogo[index],
                  width: 40,
                  height: 40,
                ),
              ),
              const SizedBox(width: 20),
              Text(appSettings[index].tr,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.9,
                    fontFamily: AssetConst.QUICKSAND_FONT,
                  )),
              const Spacer(),
              if (appSettings[index] == "language")
                GetBuilder<AppSettingController>(builder: (controller) {
                  return DropdownButton(
                    dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                    value: controller.language,
                    underline: Container(),
                    icon: const Icon(Icons.arrow_drop_down),
                    items: controller.supportedLanguages.map(
                      (val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text(
                            val,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: val == controller.language
                                    ? Theme.of(context).errorColor
                                    : Colors.grey.shade300,
                                fontFamily: AssetConst.QUICKSAND_FONT),
                            textScaleFactor: 1.0,
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      controller.updateLanguage(value.toString());
                    },
                  );
                }),
              if (appSettings[index] == "darkMode")
                GetBuilder<AppSettingController>(builder: (controller2) {
                  return Switch.adaptive(
                      value: controller2.isDark,
                      onChanged: (value) {
                        controller2.updateDarkMode(value);
                      });
                })
            ],
          ),
          const SizedBox(height: 2),
          if (index != 1)
            Divider(
              color: lightGreyColor,
            )
        ],
      );
    }));
  }
}

class GeneralSetting extends StatelessWidget {
  GeneralSetting({Key? key}) : super(key: key);

  final List<String> appSettings = ["policyAndGuidelines", "legal", "help"];
  final List<String> appSettingsLogo = [
    AssetConst.PRIVACY_LOGO,
    AssetConst.LEGACY_LOGO,
    AssetConst.FAQ_LOGO
  ];
  final List appSettingsActionUrl = [PRIVACY_URL, TERMS_URL, HELP_URL];

  @override
  Widget build(BuildContext context) {
    Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Column(
                children: [
                  Image.asset(AssetConst.FAQ_LOGO),
                  const SizedBox(height: 10),
                  Center(
                      child: CustomText(
                    'Please contact: ',
                    fontFamily: AssetConst.QUICKSAND_FONT,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorLight,
                    alignment: TextAlign.center,
                  )),
                ],
              ),
              content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [Text('technology@odeinfinity.com')]),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: darkSkyBlueColor,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                    ),
                    child: CustomText("OK",
                        color: whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
              ],
            ));
    return Column(
        children: List.generate(3, (index) {
      return Column(
        children: [
          const SizedBox(height: 2),
          Material(
            color: Colors.white.withOpacity(0.0),
            child: InkWell(
              highlightColor: lightGreyColor,
              splashColor: lightGreyColor,
              onTap: () {
                if (appSettingsActionUrl[index] == HELP_URL) {
                  openDialog();
                } else {
                  Get.to(() => (WebViewWidget(
                      showAppbar: true,
                      url: appSettingsActionUrl[index],
                      title: appSettings[index].tr)));
                }
              },
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Image.asset(
                      appSettingsLogo[index],
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(appSettings[index].tr,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.9,
                        fontFamily: AssetConst.QUICKSAND_FONT,
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 2),
          if (index != 2)
            Divider(
              color: lightGreyColor,
              thickness: 1,
            ),
        ],
      );
    }));
  }
}
