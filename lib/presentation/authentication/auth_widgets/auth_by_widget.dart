import 'package:datacoup/export.dart';

class AuthenticatByWidget extends StatelessWidget {
  AuthenticatByWidget({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    controller.updateLoginMode(false);
                  },
                  child: Text(
                    "Email",
                    style: themeTextStyle(
                      context: context,
                      tColor: controller.loginByPhone.value
                          ? lightGreyColor
                          : darkSkyBlueColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    controller.updateLoginMode(true);
                  },
                  child: Text(
                    "Phone",
                    style: themeTextStyle(
                      context: context,
                      tColor: !controller.loginByPhone.value
                          ? lightGreyColor
                          : darkSkyBlueColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: height(context)! * 0.03),
        Obx(
          () => Align(
            alignment: Alignment.topLeft,
            child: CustomLoginTextField(
              controller: controller.loginByPhone.value
                  ? controller.phoneNumberTextContoller
                  : controller.emailTextContoller,
              label: controller.loginByPhone.value ? "Phone Number" : "Email",
              forPhoneNumber: controller.loginByPhone.value,
            ),
          ),
        ),
      ],
    );
  }
}
