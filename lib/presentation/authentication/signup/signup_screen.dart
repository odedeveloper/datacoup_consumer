import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/profile/edit_profile/edit_profile_screen.dart';

class SignupScreen extends GetWidget<LoginController> {
  const SignupScreen({super.key});

  void signUp() async {
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
    } else if (controller.confirmpasswordTextContoller.text == "") {
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
                  AuthenticatByWidget(),
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
                      () => controller.loginState.value == LoginState.loading
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
