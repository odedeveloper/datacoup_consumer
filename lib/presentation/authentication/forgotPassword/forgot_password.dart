import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/authentication/auth_controller/authentication_service.dart';

final _userService = UserService(userPool);

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);
  final _controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: IconButton(
                  color: lightGreyColor,
                  splashRadius: 20,
                  highlightColor: lightBlueGreyColor,
                  onPressed: () {
                    Get.back();
                  },
                  alignment: Alignment.centerRight,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: darkBlueGreyColor,
                  ))),
          backgroundColor: lightBlueGreyColor,
          elevation: 0,
        ),
        body: Stack(children: [
          SingleChildScrollView(child:
              GetBuilder<ForgotPasswordController>(builder: (controller) {
            return Column(children: [
              const SizedBox(height: 10),
              const LogoContainer(
                  title: "Forgot password ? Worry not ......", height: 300),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              controller.updateIsByEmail(true);
                            },
                            child: Text("email".tr,
                                style: TextStyle(
                                    color: controller.isByEmail
                                        ? darkSkyBlueColor
                                        : lightGreyColor))),
                        TextButton(
                            onPressed: () {
                              controller.updateIsByEmail(false);
                            },
                            child: Text("phone".tr,
                                style: TextStyle(
                                    color: !controller.isByEmail
                                        ? darkSkyBlueColor
                                        : lightGreyColor)))
                      ],
                    ),
                    controller.isByEmail ? const ByEmail() : const ByMobile(),
                    const SizedBox(height: 60),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                          "We will send a verification code \n to your registered ${controller.isByEmail ? "email" : "mobile number"}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              letterSpacing: 1.2,
                              // fontStyle: FontStyle.italic,
                              fontSize: 13,
                              fontFamily: AssetConst.RALEWAY_FONT,
                              color: lightGreyColor,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 20),
                    GetBuilder<ForgotPasswordController>(
                        builder: (controller) => controller.formProcessing
                            ? const SpinKitThreeBounce(
                                size: 25,
                                duration: Duration(milliseconds: 800),
                                color: Colors.grey,
                              )
                            : TextButton(
                                onPressed: () async {
                                  try {
                                    await controller.updateUserCredentials();
                                    MethodResponse result =
                                        await controller.verifyForgotRequest(
                                            controller.isByEmail);
                                    print(result);
                                    print(result.isSuccess);
                                    print(result.errorMessage);
                                    if (result.isSuccess) {
                                      String response =
                                          await controller.forgotPassword();
                                      print('response');
                                      print(response);
                                      if (response != 'Verification sent') {
                                        showSnackBar(context,
                                            msg: controller.errorMessage);
                                      } else {
                                        Get.to(() => const ResetPassword());
                                      }
                                    } else {
                                      showSnackBar(context,
                                          msg: controller.errorMessage);
                                    }
                                  } catch (e) {
                                    showSnackBar(context,
                                        msg: controller.errorMessage);
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            redOpacityColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("continue".tr,
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
        ]));
  }
}
