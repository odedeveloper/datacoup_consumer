import 'package:datacoup/export.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends GetWidget<LoginController> {
  const LoginScreen({super.key});

  void login() async {
    if (controller.emailTextContoller.text == "" &&
        controller.loginByPhone.value == false) {
      Get.snackbar("Email Address Required", "Please enter your email address",
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10));
      return;
    } else if (controller.phoneNumberTextContoller.text == "" &&
        controller.loginByPhone.value == true) {
      Get.snackbar("Phone Number Required", "Please enter your mobile number",
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10));
      return;
    } else if (controller.passwordTextContoller.text == "") {
      Get.snackbar("Password Required", "Please enter your password",
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10));
      return;
    }

    final result = await controller.login();
    if (result) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.snackbar("Error", "Login Incorrect");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AuthenticationHeader(),
                  SizedBox(height: height(context)! * 0.1),
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
                        label: controller.loginByPhone.value
                            ? "Phone Number"
                            : "Email",
                        forPhoneNumber: controller.loginByPhone.value,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => Align(
                      alignment: Alignment.topLeft,
                      child: CustomLoginTextField(
                        controller: controller.passwordTextContoller,
                        label: "Password",
                        showEye: true,
                        showData: controller.showPassword.value,
                        onEyeTap: () {
                          controller.updateShowPassword(
                              !controller.showPassword.value);
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => CheckboxListTile(
                            value: controller.rememberMe.value,
                            onChanged: (value) {
                              controller.updateRememberMe(value!);
                            },
                            title: Text(
                              "Remember me",
                              style: themeTextStyle(
                                context: context,
                                fsize: ksmallFont(context),
                                tColor: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password ?",
                          style: themeTextStyle(
                            context: context,
                            fsize: ksmallFont(context),
                            tColor: darkSkyBlueColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height(context)! * 0.01),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Obx(
                        () => controller.loginState.value == LoginState.loading
                            ? const Center(
                                child: SpinKitThreeBounce(
                                size: 25,
                                duration: Duration(milliseconds: 800),
                                color: Colors.grey,
                              ))
                            : RoundedElevatedButton(
                                title: "CONTINUE",
                                onClicked: login,
                              ),
                      )),
                  SizedBox(height: height(context)! * 0.01),
                  Text(
                    "Don't have an account ?",
                    style: themeTextStyle(
                      context: context,
                      tColor: Colors.grey[400],
                    ),
                  ),
                  SizedBox(height: height(context)! * 0.01),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: RoundedElevatedButton(
                      title: "SIGN UP",
                      onClicked: () => Get.toNamed(AppRoutes.signup),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
