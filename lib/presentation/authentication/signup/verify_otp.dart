import 'package:datacoup/export.dart';

final _userService = UserService(userPool);

class VerifyOtp extends StatelessWidget {
  bool isEmail = true;
  bool isSecondVerification;
  String otp = '';
  final signUpController = Get.put(SignUpController());

  VerifyOtp(
      {Key? key, required this.isEmail, this.isSecondVerification = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20 * SizeConfig().widthScale),
                child: Column(children: [
                  SizedBox(height: 100 * SizeConfig().heightScale),
                  Container(
                    decoration: BoxDecoration(
                      color: blueGreyLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                        isEmail
                            ? AssetConst.VERIFY_EMAIL_LOGO
                            : AssetConst.VERIFY_MOBILE_LOGO,
                        color: Theme.of(context).secondaryHeaderColor,
                        height: 60 * SizeConfig().heightScale),
                  ),
                  SizedBox(height: 20 * SizeConfig().heightScale),
                  Text(
                      isEmail ? "Verify email address" : "Verify mobile number",
                      style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 24,
                          color: Theme.of(context).primaryColor,
                          fontFamily: AssetConst.RALEWAY_FONT,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 20 * SizeConfig().heightScale),
                  Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                            "Please enter the number code sent to your ${isEmail ? "email address" : "mobile number"}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                letterSpacing: 0.9,
                                fontSize: 14,
                                fontFamily: AssetConst.QUICKSAND_FONT,
                                color: mediumBlueGreyColor,
                                fontWeight: FontWeight.w800)),
                      )),
                  SizedBox(height: 40 * SizeConfig().heightScale),
                  Center(
                    child: OtpTextBix(
                      onOtpChange: (value) {
                        otp = value;
                      },
                    ),
                  ),
                  SizedBox(height: 40 * SizeConfig().heightScale),
                  GetBuilder<SignUpController>(builder: (controller) {
                    return controller.isLoading
                        ? const SpinKitThreeBounce(
                            size: 25,
                            duration: Duration(milliseconds: 800),
                            color: Colors.grey,
                          )
                        : TextButton(
                            onPressed: () async {
                              controller.updateOtp(otp);
                              MethodResponse result =
                                  await controller.verifyOTPRequest();
                              if (result.isSuccess) {
                                bool accountConfirmed = false;
                                try {
                                  accountConfirmed =
                                      await controller.confirmOTP();
                                  if (isSecondVerification &&
                                      accountConfirmed) {
                                    if (isEmail) {
                                      await controller.updateIsEmailVerified(
                                          accountConfirmed);
                                    } else {
                                      await controller.updateIsPhoneVerified(
                                          accountConfirmed);
                                    }

                                    Get.back();
                                  } else if (accountConfirmed) {
                                    // otp enetered is correct and user is authenticated
                                    controller.initUserProfile();
                                    Get.to(() => (CreateAccount()));
                                  } else {
                                    controller.updateIsLoading(false);
                                    if (isSecondVerification && isEmail) {
                                      showSnackBar(context,
                                          msg: "Email not confirmed");
                                    } else if (isSecondVerification &&
                                        !isEmail) {
                                      showSnackBar(context,
                                          msg: "Phone not confirmed");
                                    } else {
                                      showSnackBar(context,
                                          msg: "OTP entered is wrong");
                                    }
                                  }
                                } catch (e) {
                                  showSnackBar(context,
                                      msg: controller.errorMessage);
                                  controller.updateIsLoading(false);
                                }
                              } else {
                                showSnackBar(context, msg: result.errorMessage);
                                controller.updateIsLoading(false);
                              }
                              // }
                              // print(_controller.otp);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        deepOrangeColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  // side: BorderSide(color: Colors.red)
                                ))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Verify OTP",
                                    style: TextStyle(
                                        letterSpacing: 0.9,
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontFamily: AssetConst.RALEWAY_FONT)),
                              ],
                            ));
                  }),
                  SizedBox(height: 5 * SizeConfig().heightScale),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetBuilder<SignUpController>(builder: (controller) {
                        return TextButton(
                          onPressed: () async {
                            try {
                              // await _controller.sendCode(_userService);
                              //TODO: re use verification api and generate otp
                              showSnackBar(
                                context,
                                msg: "OTP has been sent successfully",
                                backgroundColor:
                                    const Color.fromARGB(255, 48, 193, 123),
                              );
                            } catch (e) {
                              showSnackBar(context,
                                  msg: controller.errorMessage);
                            }
                            controller.sendCode(_userService);
                          },
                          child: const Text("Resend Code",
                              style: TextStyle(
                                  color: mediumBlueGreyColor,
                                  fontSize: 15,
                                  fontFamily: AssetConst.RALEWAY_FONT,
                                  fontWeight: FontWeight.w600)),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 30 * SizeConfig().heightScale),
                  !isSecondVerification
                      ? Container(
                          alignment: Alignment.center,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                  "Did not receive the code?${isEmail ? "\nCheck the mail in your spam.\n" : "Wait for some time\n"}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      letterSpacing: 0.9,
                                      fontSize: 14,
                                      fontFamily: AssetConst.QUICKSAND_FONT,
                                      color: mediumBlueGreyColor,
                                      fontWeight: FontWeight.w600))))
                      : Container(),
                  !isSecondVerification
                      ? Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GetBuilder<SignUpController>(
                                builder: (controller) {
                              return InkWell(
                                highlightColor: lightGreyColor,
                                onTap: () {
                                  controller.clearState();
                                  Get.back();
                                },
                                child: Text(
                                    controller.isByEmail
                                        ? "Try another email address"
                                        : "Try another phone number",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        letterSpacing: 0.9,
                                        fontSize: 15,
                                        fontFamily: AssetConst.RALEWAY_FONT,
                                        color: mediumBlueGreyColor,
                                        fontWeight: FontWeight.w700)),
                              );
                            }),
                          ))
                      : Container(),
                ]))),
      ),
    );
  }
}
