// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'dart:async';

import 'package:datacoup/export.dart';

final _userService = new UserService(userPool);

class VerifyUsername extends StatelessWidget {
  VerifyUsername({Key? key}) : super(key: key);

  final _signupController = Get.put(SignUpController());
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Column(children: [
        SizedBox(height: 100 * SizeConfig().heightScale),
        Image.asset(AssetConst.LOGO_PNG, height: 60 * SizeConfig().heightScale),
        SizedBox(height: 25 * SizeConfig().heightScale),
        Text(
          "DATACOUP NEWS",
          style: themeTextStyle(
            context: context,
            fweight: FontWeight.bold,
            letterSpacing: 1.2,
            fsize: kextraLargeFont(context),
          ),
        ),
        SizedBox(height: 20 * SizeConfig().heightScale),
        Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Create and Verify Username".tr,
                textAlign: TextAlign.center,
                style: themeTextStyle(
                  context: context,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0.9,
                  fontFamily: AssetConst.RALEWAY_FONT,
                ),
              ),
            )),
        SizedBox(height: 30 * SizeConfig().heightScale),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GetBuilder<SignUpController>(builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 45 * SizeConfig().heightScale),
                  Text("Verify Username",
                      style: TextStyle(
                          letterSpacing: 0.9,
                          fontFamily: AssetConst.RALEWAY_FONT,
                          fontSize: 15,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500)),
                  Container(
                      alignment: Alignment.center,
                      height: 30 * SizeConfig().heightScale,
                      child: TextFormField(
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) {
                            _debounce?.cancel();
                          }
                          _debounce =
                              Timer(const Duration(milliseconds: 300), () {
                            // do something with query
                            controller.checkUsername(value);
                          });
                        },
                        controller: controller.usernameController,
                        keyboardType: TextInputType.text,
                        scrollPadding: EdgeInsets.zero,
                        style: new TextStyle(
                          letterSpacing: 0.9,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: AssetConst.QUICKSAND_FONT,
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
            SizedBox(height: 45 * SizeConfig().heightScale),
            GetBuilder<SignUpController>(builder: (controller) {
              return Container(
                height: 80,
                width: 370,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: controller.messageForUsernameVerification == ''
                            ? darkSkyBlueColor
                            : controller.colorForUsernameVerification,
                        width: 1),
                    color: controller.messageForUsernameVerification == ''
                        ? darkSkyBlueColor.withOpacity(0.1)
                        : controller.colorForUsernameVerification
                            .withOpacity(0.1)),
                child: Text(
                  controller.messageForUsernameVerification == ''
                      ? 'Verify username !'
                      : controller.messageForUsernameVerification,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: controller.messageForUsernameVerification == ''
                        ? darkSkyBlueColor
                        : controller.colorForUsernameVerification,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }),
            SizedBox(height: 45 * SizeConfig().heightScale),
            GetBuilder<SignUpController>(builder: (controller) {
              return controller.isLoading
                  ? const SpinKitThreeBounce(
                      size: 25,
                      duration: Duration(milliseconds: 800),
                      color: Colors.grey,
                    )
                  : TextButton(
                      onPressed: () async {
                        await controller
                            .checkUsername(controller.usernameController.text);
                        if (controller.messageForUsernameVerification ==
                            'username is available') {
                          Get.to(() => SignUp());
                        } else {
                          showSnackBar(context,
                              msg: 'Please verify username first !');
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(deepOrangeColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            // side: BorderSide(color: Colors.red)
                          ))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(StringConst.CONTINUE,
                              style: TextStyle(
                                  letterSpacing: 0.9,
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: AssetConst.RALEWAY_FONT)),
                        ],
                      ));
            }),
            SizedBox(height: 10 * SizeConfig().heightScale),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(StringConst.ALREADY_HAVE_AN_ACCOUNT,
                      style: TextStyle(
                          color: darkSkyBlueColor,
                          fontSize: 15,
                          fontFamily: AssetConst.RALEWAY_FONT,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            SizedBox(height: 10 * SizeConfig().heightScale),
          ]),
        )
      ])),
    ));
  }
}
