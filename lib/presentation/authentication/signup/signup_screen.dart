import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/profile/edit_profile/edit_profile_screen.dart';

class SignupScreen extends GetWidget<SignupController> {
  const SignupScreen({super.key});

  void signUp() async {
    MethodResponse result =
        await controller.verifySignUpRequest(!controller.loginByPhone.value);

    if (result.isSuccess) {
      try {
        await controller.signUp();
        Get.toNamed(AppRoutes.verifyOtp);
      } catch (e) {
        Get.snackbar(
            "Email Address Required", "Please enter your email address",
            margin: const EdgeInsets.only(top: 20, left: 10, right: 10));
      }
    } else {
      Get.snackbar("SignUp Error", result.errorMessage,
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10));
    }

    // if (controller.emailTextContoller.text == "" &&
    //     controller.loginByPhone.value == false) {
    //   Get.snackbar("Email Address Required", "Please enter your email address",
    //       margin: const EdgeInsets.only(top: 20, left: 10, right: 10));
    //   return;
    // } else if (controller.phoneNumberTextContoller.text == "" &&
    //     controller.loginByPhone.value == true) {
    //   Get.snackbar("Phone Number Required", "Please enter your mobile number",
    //       margin: const EdgeInsets.only(top: 20, left: 10, right: 10));
    //   return;
    // } else if (controller.passwordTextContoller.text == "") {
    //   Get.snackbar("Password Required", "Please enter your password",
    //       margin: const EdgeInsets.only(top: 20, left: 10, right: 10));
    //   return;
    // } else if (controller.confirmpasswordTextContoller.text == "") {
    //   Get.snackbar("Password Required", "Please enter your password",
    //       margin: const EdgeInsets.only(top: 20, left: 10, right: 10));
    //   return;
    // } else if (controller.confirmpasswordTextContoller.text !=
    //     controller.passwordTextContoller.text) {
    //   Get.snackbar("Password Mismatch", "Please enter correct password",
    //       margin: const EdgeInsets.only(top: 20, left: 10, right: 10));
    //   return;
    // }

    // final result = await controller.signUp();
    // if (result) {
    //   Get.offAllNamed(AppRoutes.home);
    // } else {
    //   Get.snackbar("Error", "Login Incorrect");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.secondary),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AuthenticationHeader(fromLogin: false),
                  const SizedBox(height: 15),
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomLoginTextField(
                      controller: controller.passwordTextContoller,
                      label: "Password",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomLoginTextField(
                      controller: controller.confirmpasswordTextContoller,
                      label: "Confirm Password",
                      showData: true,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => LightLabelWidget(
                      textAlign: TextAlign.center,
                      label: userVerifyDesc.replaceAll(
                          '{}',
                          !controller.loginByPhone.value
                              ? "email"
                              : "mobile number"),
                      fontsize: kminiFont(context)! + 1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Obx(
                      () => controller.signupState.value == LoginState.loading
                          ? const Center(child: CircularProgressIndicator())
                          : RoundedElevatedButton(
                              title: "CONTINUE",
                              onClicked: signUp,
                            ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      "Already have an account?",
                      style: themeTextStyle(
                        context: context,
                        tColor: darkSkyBlueColor,
                        fweight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
