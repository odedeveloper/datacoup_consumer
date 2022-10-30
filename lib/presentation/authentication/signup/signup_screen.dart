import 'package:datacoup/export.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignupScreen extends GetWidget<SignupController> {
  const SignupScreen({super.key});

  void signUp() async {
    MethodResponse result =
        await controller.verifySignUpRequest(!controller.loginByPhone.value);

    if (result.isSuccess) {
      try {
        String? result = await controller.signUp();
        if (result != null || result == "") {
          Get.snackbar("Signup Error", result!,
              margin: const EdgeInsets.only(top: 20, left: 10, right: 10));
          return;
        } else {
          Get.toNamed(AppRoutes.verifyOtp);
        }
      } catch (e) {
        Get.snackbar("SignUp Error", "Please try again",
            margin: const EdgeInsets.only(top: 20, left: 10, right: 10));
      }
    } else {
      Get.snackbar("SignUp Error", result.errorMessage,
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10));
    }
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
                              controller.clearState();
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
                              controller.clearState();
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
                        signupController: controller,
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
                      signupController: controller,
                      controller: controller.passwordTextContoller,
                      label: "Password",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomLoginTextField(
                      signupController: controller,
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
                      () => controller.signupState.value == SignUpState.loading
                          ? const Center(
                              child: SpinKitThreeBounce(
                              size: 25,
                              duration: Duration(milliseconds: 800),
                              color: Colors.grey,
                            ))
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
