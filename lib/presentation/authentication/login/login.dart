import 'dart:developer';

import 'package:datacoup/export.dart';

final _userService = UserService(userPool);

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final loginController = Get.put(LoginController());
  final auth = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      SizedBox(
          height: 330 * SizeConfig().heightScale,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30 * SizeConfig().heightScale),
              Image.asset(AssetConst.LOGO_PNG,
                  height: 80 * SizeConfig().heightScale),
              SizedBox(height: 30 * SizeConfig().heightScale),
              Text(
                "DATACOUP NEWS",
                style: themeTextStyle(
                  context: context,
                  fsize: kextraLargeFont(context),
                  fweight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 10 * SizeConfig().heightScale),
              Text(
                "Because Privacy matters !",
                style: themeTextStyle(
                  context: context,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          )),
      SizedBox(height: 5 * SizeConfig().heightScale),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GetBuilder<LoginController>(builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Username",
                    style: TextStyle(
                        letterSpacing: 0.9,
                        fontFamily: AssetConst.RALEWAY_FONT,
                        fontSize: 15,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 13),
                Container(
                    alignment: Alignment.center,
                    height: 30 * SizeConfig().heightScale,
                    child: TextFormField(
                      controller: controller.usernameController,
                      keyboardType: TextInputType.text,
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
                    )),
              ],
            );
          }),
          SizedBox(height: 25 * SizeConfig().heightScale),
          Text("password".tr,
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
            child: GetBuilder<LoginController>(
              builder: (controller) => (TextFormField(
                obscureText: controller.passwordHidden,
                autofocus: false,
                controller: controller.passwordController,
                scrollPadding: EdgeInsets.zero,
                style: TextStyle(
                  color: darkGreyColor,
                  letterSpacing: 0.9,
                  fontWeight: FontWeight.w500,
                  fontFamily: AssetConst.RALEWAY_FONT,
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 18),
                    suffixIcon: InkWell(
                        onTap: () {
                          controller.updatePasswordHiddens(
                              !controller.passwordHidden);
                        },
                        child: Icon(controller.passwordHidden
                            ? Icons.visibility_off
                            : Icons.visibility))),
              )),
            ),
          ),
          Row(
            children: [
              GetBuilder<LoginController>(
                  init: LoginController(),
                  builder: (controller) {
                    return Row(children: [
                      Checkbox(
                        value: controller.rememberMe,
                        fillColor: MaterialStateProperty.all(darkSkyBlueColor),
                        onChanged: (value) {
                          controller.rememberMe = value!;
                          controller.updateRememberMe(controller.rememberMe);
                        },
                      ),
                      InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          if (controller.rememberMe) {
                            controller.updateRememberMe(false);
                          } else {
                            controller.updateRememberMe(true);
                          }
                        },
                        child: Text("rememberMe".tr,
                            style: TextStyle(
                                letterSpacing: 0.9,
                                fontFamily: AssetConst.RALEWAY_FONT,
                                fontSize: SizeConfig().deviceWidth * 0.030,
                                color: darkGreyColor,
                                fontWeight: FontWeight.w500)),
                      )
                    ]);
                  }),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Get.to(() => ForgotPassword());
                },
                child: Text("forgotPassword".tr,
                    style: TextStyle(
                        letterSpacing: 0.9,
                        fontFamily: AssetConst.RALEWAY_FONT,
                        fontSize: SizeConfig().deviceWidth * 0.030,
                        color: darkSkyBlueColor,
                        fontWeight: FontWeight.w500)),
              )
            ],
          ),
          GetBuilder<AuthenticationController>(
              init: AuthenticationController(),
              builder: (acontroller) => GetBuilder<LoginController>(
                  init: LoginController(),
                  builder: (bcontroller) => acontroller.authInProgress
                      ? const SpinKitThreeBounce(
                          size: 25,
                          duration: Duration(milliseconds: 800),
                          color: Colors.grey,
                        )
                      : TextButton(
                          onPressed: () async {
                            bcontroller.updateUsernamePassword();
                            MethodResponse result =
                                await bcontroller.verifyLogInRequest();
                            if (result.isSuccess) {
                              try {
                                acontroller.updateAuthInProgress(true);
                                bool isValid =
                                    await bcontroller.login(_userService);
                                if (isValid) {
                                  print("yon");
                                  acontroller.updateLoggedIn(true);
                                  acontroller.updateAuthInProgress(false);
                                  acontroller.updateLoggedIn(true);
                                  Get.offAllNamed(AppRoutes.home);
                                } else {
                                  acontroller.updateAuthInProgress(false);
                                  acontroller.updateLoggedIn(false);
                                  // bcontroller.updateRememberMe(false);
                                }
                              } on CognitoClientException catch (exception) {
                                acontroller.updateAuthInProgress(false);
                                acontroller.updateLoggedIn(false);
                                // bcontroller.updateRememberMe(false);
                                showSnackBar(context, msg: exception.message!);
                              } catch (e) {
                                log("auth error $e");
                                acontroller.updateAuthInProgress(false);
                                acontroller.updateLoggedIn(false);
                                // bcontroller.updateRememberMe(false);
                                showSnackBar(context,
                                    msg: bcontroller.errorMessage);
                              }
                            } else {
                              // bcontroller.updateRememberMe(false);

                              showSnackBar(context, msg: result.errorMessage);
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  redOpacityColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("LOG IN".tr,
                                  style: const TextStyle(
                                      letterSpacing: 0.9,
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: AssetConst.RALEWAY_FONT)),
                            ],
                          )))),
          SizedBox(height: 10 * SizeConfig().heightScale),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("dontHaveAnAccount".tr,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontFamily: AssetConst.RALEWAY_FONT,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          SizedBox(height: 5 * SizeConfig().heightScale),
          TextButton(
              onPressed: () {
                Get.to(() => VerifyUsername());
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(redOpacityColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    // side: BorderSide(color: Colors.red)
                  ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "signUp".tr,
                    style: const TextStyle(
                      letterSpacing: 0.9,
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: AssetConst.RALEWAY_FONT,
                    ),
                  ),
                ],
              )),
        ]),
      )
    ])));
  }
}
