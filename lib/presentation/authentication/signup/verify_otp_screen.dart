import 'package:datacoup/export.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class VerifyOTPScreen extends GetWidget<SignupController> {
  const VerifyOTPScreen({super.key});

  void verifyOtp() async {
    controller.verifyOTPRequest();
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CacheImageWidget(
                  fromAsset: true,
                  imageUrl: AssetConst.verifyEmailLogo,
                  imgheight: height(context)! * 0.10,
                  imgwidth: width(context)! * 0.22,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(height: 25),
                Text(
                  controller.loginByPhone.value
                      ? StringConst.verifyPhoneNumer
                      : StringConst.verifyEmailAddress,
                  style: themeTextStyle(
                    context: context,
                    fweight: FontWeight.bold,
                    fontFamily: AssetConst.ralewayFont,
                    fsize: kmaxExtraLargeFont(context)! + 4,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  StringConst.verifyEmailAddressDesc.replaceAll(
                      "{}",
                      controller.loginByPhone.value
                          ? "phone number"
                          : "email address"),
                  textAlign: TextAlign.center,
                  style: themeTextStyle(
                    context: context,
                    fontFamily: AssetConst.ralewayFont,
                    fontStyle: FontStyle.italic,
                    fweight: FontWeight.w700,
                    tColor: Theme.of(context).colorScheme.secondary,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                  child: OtpTextBix(
                    onOtpChange: (value) {
                      controller.enteredOtp.value = value;
                    },
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Obx(
                    () => controller.signupState.value == LoginState.loading
                        ? const Center(
                            child: SpinKitThreeBounce(
                            size: 25,
                            duration: Duration(milliseconds: 800),
                            color: Colors.grey,
                          ))
                        : RoundedElevatedButton(
                            title: "Verify OTP",
                            onClicked: verifyOtp,
                          ),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      LightLabelWidget(
                        label: "Resend OTP",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Did not receive the code? ${!controller.loginByPhone.value ? "Check the mail in your spam filter , or" : "Wait for some time ,"}",
                  textAlign: TextAlign.center,
                  style: themeTextStyle(
                    context: context,
                    fsize: ksmallFont(context),
                    tColor: Theme.of(context).colorScheme.secondary,
                    fweight: FontWeight.w500,
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.clearState();
                    Get.back();
                  },
                  child: Text(
                    !controller.loginByPhone.value
                        ? "try another email address"
                        : "try another phone number",
                    textAlign: TextAlign.center,
                    style: themeTextStyle(
                      context: context,
                      fweight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
