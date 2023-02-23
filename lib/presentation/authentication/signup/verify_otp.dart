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
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
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
                Text(isEmail ? "Verify email address" : "Verify mobile number",
                    style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 24,
                        color: Theme.of(context).secondaryHeaderColor,
                        fontFamily: AssetConst.RALEWAY_FONT,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 20 * SizeConfig().heightScale),
                Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                          "Please enter the number code send to your ${isEmail ? "email address" : "mobile number"}",
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
                              bool accountConfirmed;
                              try {
                                accountConfirmed =
                                    await controller.confirmOTP();
                                if (isSecondVerification && accountConfirmed) {
                                  if (isEmail) {
                                    await controller.updateIsEmailVerified(
                                        accountConfirmed);
                                  } else {
                                    await controller.updateIsPhoneVerified(
                                        accountConfirmed);
                                  }

                                  Get.back();
                                } else if (accountConfirmed) {
                                  controller.initUserProfile();
                                  Get.to(() => (CreateAccount()));
                                } else {
                                  if (isSecondVerification && isEmail) {
                                    showSnackBar(context,
                                        msg: "EMAIL_NOT_CONFIRMED");
                                  } else if (isSecondVerification && !isEmail) {
                                    showSnackBar(context,
                                        msg: "PHONE_NOT_CONFIRMED");
                                  } else {
                                    showSnackBar(context,
                                        msg: "ACCOUNT_NOT_CONFIRMED");
                                  }
                                }
                              } catch (e) {
                                showSnackBar(context,
                                    msg: controller.errorMessage);
                              }
                            } else {
                              showSnackBar(context, msg: result.errorMessage);
                            }
                            // }
                            // print(_controller.otp);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
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
                              msg: "OTP_HAS_BEEN_SENT_SUCCESSFULLY",
                              backgroundColor: Colors.greenAccent,
                            );
                          } catch (e) {
                            showSnackBar(context, msg: controller.errorMessage);
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                                "Did not receive the code?${isEmail ? "Check the mail in your spam filter , or" : "Wait for some time ,"}",
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
                                      ? "try another email address"
                                      : "try another phone number",
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
    ));
  }
}
