import 'package:country_code_picker/country_code_picker.dart';
import 'package:datacoup/export.dart';

final _userService = UserService(userPool);

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final _signupController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Column(children: [
        SizedBox(height: 80 * SizeConfig().heightScale),
        Image.asset(AssetConst.LOGO_PNG, height: 60 * SizeConfig().heightScale),
        SizedBox(height: 20 * SizeConfig().heightScale),
        Text(
          "DATACOUP NEWS",
          style: themeTextStyle(
            context: context,
            fsize: klargeFont(context),
            fweight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 10 * SizeConfig().heightScale),
        Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "createNewAccount".tr,
                textAlign: TextAlign.center,
                style: themeTextStyle(
                  context: context,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.2,
                ),
              ),
            )),
        SizedBox(height: 30 * SizeConfig().heightScale),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GetBuilder<SignUpController>(builder: (controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        controller.updateIsByEmail(true);
                      },
                      child: Text("Email",
                          style: TextStyle(
                              color: controller.isByEmail
                                  ? darkSkyBlueColor
                                  : lightGreyColor))),
                  TextButton(
                      onPressed: () {
                        controller.updateIsByEmail(false);
                      },
                      child: Text("Phone",
                          style: TextStyle(
                              color: !controller.isByEmail
                                  ? darkSkyBlueColor
                                  : lightGreyColor)))
                ],
              );
            }),
            GetBuilder<SignUpController>(builder: (controller) {
              return controller.isByEmail
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email",
                            style: TextStyle(
                                letterSpacing: 0.9,
                                fontFamily: AssetConst.RALEWAY_FONT,
                                fontSize: 14,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 13),
                        Container(
                            alignment: Alignment.center,
                            height: 30 * SizeConfig().heightScale,
                            child: TextFormField(
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              scrollPadding: EdgeInsets.zero,
                              style: TextStyle(
                                letterSpacing: 0.9,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: AssetConst.QUICKSAND_FONT,
                                fontStyle: FontStyle.normal,
                                fontSize: 17,
                                height: 1.0,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    bottom: 18 * SizeConfig().heightScale),
                              ),
                            )),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mobile Number",
                            style: TextStyle(
                                letterSpacing: 0.9,
                                fontFamily: AssetConst.RALEWAY_FONT,
                                fontSize: 14,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500)),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  showCountryPicker(
                                    countryListTheme: CountryListThemeData(
                                        backgroundColor:
                                            Theme.of(context).cardColor,
                                        searchTextStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                        textStyle: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    context: context,
                                    showPhoneCode:
                                        true, // optional. Shows phone code before the country name.
                                    onSelect: (Country country) {
                                      controller
                                          .updateCountryCode(country.phoneCode);
                                    },
                                  );
                                },
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(2, 25, 2, 10),
                                    padding: EdgeInsets.fromLTRB(2, 0, 2, 14),
                                    alignment: Alignment.topCenter,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    )),
                                    child: Text(controller.countryCode,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontFamily:
                                                AssetConst.QUICKSAND_FONT,
                                            fontWeight: FontWeight.w500))),
                              ),
                              Container(
                                width: 255 * SizeConfig().widthScale,
                                // height:20,
                                alignment: Alignment.bottomCenter,
                                padding: const EdgeInsets.only(left: 20),
                                child: TextFormField(
                                  controller: controller.phoneController,
                                  autofocus: false,
                                  // maxLength: 10,
                                  keyboardType: TextInputType.number,
                                  scrollPadding: EdgeInsets.zero,
                                  style: TextStyle(
                                    letterSpacing: 0.9,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AssetConst.QUICKSAND_FONT,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16,
                                    height: 1.9,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        bottom: 5 * SizeConfig().heightScale),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
            }),
            SizedBox(height: 25 * SizeConfig().heightScale),
            Text("password".tr,
                style: TextStyle(
                    letterSpacing: 0.9,
                    fontFamily: AssetConst.RALEWAY_FONT,
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 13),
            Container(
                alignment: Alignment.center,
                height: 30 * SizeConfig().heightScale,
                child: GetBuilder<SignUpController>(builder: (controller) {
                  return TextFormField(
                    controller: controller.passwordController,
                    obscureText: controller.passwordHidden,
                    scrollPadding: EdgeInsets.zero,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      letterSpacing: 0.9,
                      fontWeight: FontWeight.w500,
                      fontFamily: AssetConst.QUICKSAND_FONT,
                      fontStyle: FontStyle.normal,
                      fontSize: 17,
                      height: 1.0,
                    ),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 18),
                        suffixIcon: InkWell(
                            onTap: () {
                              controller.updatePasswordHidden(
                                  !controller.passwordHidden);
                            },
                            child: Icon(controller.passwordHidden
                                ? Icons.visibility_off
                                : Icons.visibility))),
                  );
                })),
            SizedBox(height: 25 * SizeConfig().heightScale),
            Text("Confirm Password",
                style: TextStyle(
                    letterSpacing: 0.9,
                    fontFamily: AssetConst.RALEWAY_FONT,
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 13),
            Container(
                alignment: Alignment.center,
                height: 30 * SizeConfig().heightScale,
                child: GetBuilder<SignUpController>(builder: (controller) {
                  return TextFormField(
                    controller: controller.confirmPasswordController,
                    obscureText: controller.confirmPasswordHidden,
                    scrollPadding: EdgeInsets.zero,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      letterSpacing: 0.9,
                      fontWeight: FontWeight.w500,
                      fontFamily: AssetConst.QUICKSAND_FONT,
                      fontStyle: FontStyle.normal,
                      fontSize: 17,
                      height: 1.0,
                    ),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 18),
                        suffixIcon: InkWell(
                            onTap: () {
                              controller.updateConfirmPasswordHidden(
                                  !controller.confirmPasswordHidden);
                            },
                            child: Icon(controller.confirmPasswordHidden
                                ? Icons.visibility_off
                                : Icons.visibility))),
                  );
                })),
            SizedBox(height: 45 * SizeConfig().heightScale),
            GetBuilder<SignUpController>(builder: (controller) {
              return Text(
                StringConst.WE_WILL_SEND_NOTIFICATION.replaceAll(
                    '{}', controller.isByEmail ? "email" : "mobile number"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 0.9,
                  color: lightGreyColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: AssetConst.RALEWAY_FONT,
                  fontStyle: FontStyle.normal,
                  fontSize: 13,
                ),
              );
            }),
            SizedBox(height: 20 * SizeConfig().heightScale),
            GetBuilder<SignUpController>(builder: (controller) {
              return controller.isLoading
                  ? const SpinKitThreeBounce(
                      size: 25,
                      duration: Duration(milliseconds: 800),
                      color: Colors.grey,
                    )
                  : TextButton(
                      onPressed: () async {
                        controller.updateUsingTextController();
                        MethodResponse result = await controller
                            .verifySignUpRequest(controller.isByEmail);
                        if (result.isSuccess) {
                          try {
                            await controller.signUp();
                            Get.to(() =>
                                (VerifyOtp(isEmail: controller.isByEmail)));
                          } catch (e) {
                            showSnackBar(context, msg: controller.errorMessage);
                          }
                        } else {
                          showSnackBar(context, msg: result.errorMessage);
                        }
                        // Get.to(()=>(VerifyOtp(isEmail: _controller.isByEmail)));
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
                        children: const [
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
                    Get.back();
                  },
                  child: const Text(StringConst.ALREADY_HAVE_AN_ACCOUNT,
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
