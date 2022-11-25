import 'package:datacoup/export.dart';

final _userService = UserService(userPool);

class VerifyOtpEditEmailPassword extends StatelessWidget {
  bool isEmail = true;

  String otp = '';
  final _editEmailPhoneController = Get.put(EditEmailPhoneController());

  VerifyOtpEditEmailPassword({Key? key, required this.isEmail})
      : super(key: key);
  final controller = Get.find<HomeController>();
  String? genderInitialData = '';
  LoginResponse? loginResponse;

  loadData() async {
    controller.profileLoader(true);
    controller.user!.value = UserModel.empty();
    LoginResponse? response =
        await controller.apiRepositoryInterface.fetchUserProfile();
    controller.user!(response!.user);
    controller.profileLoader(false);
    controller.updatePressed(false);
  }

  @override
  Widget build(BuildContext context) {
    Future openDialog() => showDialog(
        context: context,
        builder: (context) =>
            GetBuilder<EditEmailPhoneController>(builder: (controller) {
              return AlertDialog(
                title: Column(
                  children: [
                    Center(
                        child: CustomText(
                      isEmail
                          ? 'Your email has been successfully changed to:'
                          : 'Your phone has been successfully changed to:',
                      fontFamily: AssetConst.QUICKSAND_FONT,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorLight,
                      alignment: TextAlign.center,
                    )),
                  ],
                ),
                content: Column(mainAxisSize: MainAxisSize.min, children: [
                  Center(
                    child: Text(isEmail
                        ? controller.emailController.text
                        : controller.countryCode +
                            controller.mobileController.text),
                  )
                ]),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actions: [
                  TextButton(
                      onPressed: () async {
                        await loadData();
                        Get.back();
                        Get.back();
                        Get.back();
                        Get.back();
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
              );
            }));
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20 * SizeConfig().widthScale),
              child: Column(children: [
                SizedBox(height: 200 * SizeConfig().heightScale),
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
                Center(
                  child: Text(
                      isEmail ? "Verify email address" : "Verify mobile number",
                      style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 24,
                          color: Theme.of(context).secondaryHeaderColor,
                          fontFamily: AssetConst.RALEWAY_FONT,
                          fontWeight: FontWeight.w600)),
                ),
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
                GetBuilder<EditEmailPhoneController>(builder: (controller) {
                  return TextButton(
                      onPressed: () async {
                        controller.updateOtp(otp);
                        MethodResponse result =
                            await controller.verifyOTPRequest();
                        if (result.isSuccess) {
                          String editDetailsConfirmed;
                          try {
                            editDetailsConfirmed =
                                await controller.editDetails();
                            if (editDetailsConfirmed == 'True') {
                              await controller.createUserProfile(isEmail);

                              // Get.to(HomeScreen());
                              openDialog();
                            } else {
                              if (isEmail) {
                                showSnackBar(context,
                                    msg: "EMAIL_NOT_CONFIRMED");
                              } else {
                                showSnackBar(context,
                                    msg: "PHONE_NOT_CONFIRMED");
                              }
                            }
                          } catch (e) {
                            showSnackBar(context, msg: controller.errorMessage);
                          }
                        } else {
                          showSnackBar(context, msg: result.errorMessage);
                        }

                        // print(_controller.otp);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(redOpacityColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    GetBuilder<EditEmailPhoneController>(builder: (controller) {
                      return TextButton(
                        onPressed: () async {
                          try {
                            String response =
                                await controller.secondVerification(
                                    true,
                                    isEmail
                                        ? controller.emailController.text
                                        : controller.countryCode +
                                            controller.mobileController.text);
                            showSnackBar(
                              context,
                              msg: "OTP_HAS_BEEN_SENT_SUCCESSFULLY",
                              backgroundColor: Colors.greenAccent,
                            );
                          } catch (e) {
                            showSnackBar(context, msg: controller.errorMessage);
                          }
                          // _controller.sendCode(_userService);
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
                Container(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                            "Did not receive the code? ${isEmail ? "Check the mail in your spam filter , or" : "Wait for some time ,"}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                letterSpacing: 0.9,
                                fontSize: 14,
                                fontFamily: AssetConst.QUICKSAND_FONT,
                                color: mediumBlueGreyColor,
                                fontWeight: FontWeight.w600)))),
                Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GetBuilder<EditEmailPhoneController>(
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
              ]))),
    );
  }
}
