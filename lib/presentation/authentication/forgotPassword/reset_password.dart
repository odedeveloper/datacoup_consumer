import 'package:datacoup/export.dart';

final _userService = UserService(userPool);

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 40,
              leadingWidth: 44,
              leading: Container(
                  margin: const EdgeInsets.only(
                    top: 8,
                    left: 10,
                  ),
                  padding: const EdgeInsets.only(left: 3),
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: blueGreyLight,
                  ),
                  child: GetBuilder<ForgotPasswordController>(
                      builder: (controller) {
                    return IconButton(
                        color: lightGreyColor,
                        splashRadius: 20,
                        highlightColor: lightBlueGreyColor,
                        onPressed: () {
                          controller.resetUiUserPassword();
                          controller.updateFormProcessing(false);
                          Get.back();
                        },
                        alignment: Alignment.centerRight,
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                          color: darkBlueGreyColor,
                        ));
                  })),
              backgroundColor: lightBlueGreyColor,
              elevation: 0,
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Stack(children: [
              SingleChildScrollView(child:
                  GetBuilder<ForgotPasswordController>(builder: (controller) {
                return Column(children: [
                  const SizedBox(height: 10),
                  const LogoContainer(
                      title: "Reset your password !", height: 300),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Enter new password".tr,
                            style: TextStyle(
                                letterSpacing: 0.9,
                                fontFamily: AssetConst.RALEWAY_FONT,
                                fontSize: 15,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 10),
                        Container(
                            alignment: Alignment.center,
                            height: 30 * SizeConfig().heightScale,
                            child: GetBuilder<ForgotPasswordController>(
                                builder: (controller) {
                              return TextFormField(
                                controller: controller.passwordController,
                                scrollPadding: EdgeInsets.zero,
                                style: TextStyle(
                                  letterSpacing: 0.9,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AssetConst.RALEWAY_FONT,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      bottom: 18 * SizeConfig().heightScale),
                                ),
                              );
                            })),
                        const SizedBox(height: 30),
                        Text("Confirm password".tr,
                            style: TextStyle(
                                letterSpacing: 0.9,
                                fontFamily: AssetConst.RALEWAY_FONT,
                                fontSize: 15,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 10),
                        Container(
                            alignment: Alignment.center,
                            height: 30 * SizeConfig().heightScale,
                            child: GetBuilder<ForgotPasswordController>(
                                builder: (controller) {
                              return TextFormField(
                                obscureText:
                                    controller.forgetconfirmPasswordVisible!,
                                controller:
                                    controller.confirmPasswordController,
                                scrollPadding: EdgeInsets.zero,
                                style: TextStyle(
                                  letterSpacing: 0.9,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AssetConst.RALEWAY_FONT,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      bottom: 18 * SizeConfig().heightScale),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      controller
                                          .updatePasswordforgetPassConfirmHiddens(
                                              !controller
                                                  .forgetconfirmPasswordVisible!);
                                    },
                                    child: Icon(
                                        controller.forgetconfirmPasswordVisible!
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                  ),
                                ),
                              );
                            })),
                        const SizedBox(height: 30),
                        Text("Enter OTP received".tr,
                            style: TextStyle(
                                letterSpacing: 0.9,
                                fontFamily: AssetConst.RALEWAY_FONT,
                                fontSize: 15,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 10),
                        Container(
                            alignment: Alignment.center,
                            height: 30 * SizeConfig().heightScale,
                            child: GetBuilder<ForgotPasswordController>(
                                builder: (controller) {
                              return TextFormField(
                                controller: controller.otpController,
                                scrollPadding: EdgeInsets.zero,
                                style: TextStyle(
                                  letterSpacing: 0.9,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AssetConst.RALEWAY_FONT,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      bottom: 18 * SizeConfig().heightScale),
                                ),
                              );
                            })),
                        //     const SizedBox(height:60),
                        //    Container(
                        //      alignment: Alignment.center,
                        //      child: Text("We will send a verification code \n in your registered email . ",
                        //      textAlign: TextAlign.center,
                        // style: TextStyle(
                        //   letterSpacing:1.2,
                        //   // fontStyle: FontStyle.italic,
                        //   fontSize: 13,
                        //   fontFamily: AssetConst.RALEWAY_FONT,
                        //   color: lightGreyColor,
                        //   fontWeight: FontWeight.w600)),
                        //    ),
                        const SizedBox(height: 40),
                        GetBuilder<ForgotPasswordController>(
                            builder: (controller) => controller.formProcessing
                                ? const SpinKitThreeBounce(
                                    size: 25,
                                    duration: Duration(milliseconds: 800),
                                    color: Colors.grey,
                                  )
                                : TextButton(
                                    onPressed: () async {
                                      controller.updateUserPassword();
                                      MethodResponse result = await controller
                                          .verifyPasswordOtpRequest(
                                              controller.isByEmail);
                                      if (result.isSuccess) {
                                        try {
                                          await controller.resetPassword(
                                              controller.isByEmail);
                                          print("yonnn");
                                          passwordResetDialog(context);
                                        } catch (e) {
                                          showSnackBar(context,
                                              msg: controller.errorMessage);
                                        }
                                      } else {
                                        showSnackBar(context,
                                            msg: result.errorMessage);
                                      }
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                redOpacityColor),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("CONFIRM".tr,
                                            style: const TextStyle(
                                                letterSpacing: 0.9,
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontFamily:
                                                    AssetConst.RALEWAY_FONT)),
                                      ],
                                    )))
                      ],
                    ),
                  )
                ]);
              }))
            ])));
  }
}
