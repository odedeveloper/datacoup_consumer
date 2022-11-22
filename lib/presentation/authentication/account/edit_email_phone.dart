import 'package:country_code_picker/country_code_picker.dart';
import 'package:datacoup/export.dart';

final _userService = UserService(userPool);

class EditEmailPhone extends StatelessWidget {
  bool isEmail = true;

  String otp = '';
  final _userProfileController = Get.put(UserProfileController());
  final _signUpController = Get.put(SignUpController());
  final _editEmailPhoneController = Get.put(EditEmailPhoneController());

  EditEmailPhone({Key? key, required this.isEmail}) : super(key: key);
  // EditEmailPhone({Key? key}) : super(key: key);
  // final _controller = Get.put(ForgotPasswordController());

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
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Stack(children: [
              SingleChildScrollView(child:
                  GetBuilder<EditEmailPhoneController>(builder: (controller) {
                return Column(children: [
                  const SizedBox(height: 10),
                  LogoContainer(
                      title:
                          'Edit ${isEmail ? 'Email' : 'Mobile number'} associated with your account',
                      height: 300),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isEmail
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Email".tr,
                                      style: TextStyle(
                                          letterSpacing: 0.9,
                                          fontFamily: AssetConst.RALEWAY_FONT,
                                          fontSize: 15,
                                          color: Colors.grey[400],
                                          fontWeight: FontWeight.w500)),
                                  const SizedBox(height: 20),
                                  Container(
                                      alignment: Alignment.center,
                                      height: 60,
                                      child:
                                          GetBuilder<EditEmailPhoneController>(
                                              builder: (controller) {
                                        return TextFormField(
                                          controller:
                                              controller.emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
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
                                                bottom: 18 *
                                                    SizeConfig().heightScale),
                                          ),
                                        );
                                      })),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Phone Number".tr,
                                      style: TextStyle(
                                          letterSpacing: 0.9,
                                          fontFamily: AssetConst.RALEWAY_FONT,
                                          fontSize: 15,
                                          color: Colors.grey[400],
                                          fontWeight: FontWeight.w500)),
                                  GetBuilder<EditEmailPhoneController>(
                                      builder: (controller) {
                                    return Container(
                                      alignment: Alignment.bottomCenter,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showCountryPicker(
                                                context: context,
                                                showPhoneCode:
                                                    true, // optional. Shows phone code before the country name.
                                                onSelect: (Country country) {
                                                  controller.updateCountryCode(
                                                      country.phoneCode);
                                                },
                                              );
                                            },
                                            child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    2, 25, 2, 10),
                                                padding: EdgeInsets.fromLTRB(
                                                    2, 0, 2, 14),
                                                alignment: Alignment.topCenter,
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                )),
                                                child: Text(
                                                    controller.countryCode,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                            darkBlueGreyColor,
                                                        fontFamily: AssetConst
                                                            .QUICKSAND_FONT,
                                                        fontWeight:
                                                            FontWeight.w500))),
                                          ),
                                          Container(
                                            width:
                                                255 * SizeConfig().widthScale,
                                            // height:20,
                                            alignment: Alignment.bottomCenter,
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: TextFormField(
                                              controller:
                                                  controller.mobileController,
                                              autofocus: false,
                                              // maxLength: 10,
                                              keyboardType:
                                                  TextInputType.number,
                                              scrollPadding: EdgeInsets.zero,
                                              style: TextStyle(
                                                letterSpacing: 0.9,
                                                color: Colors.grey.shade700,
                                                fontWeight: FontWeight.w500,
                                                fontFamily:
                                                    AssetConst.RALEWAY_FONT,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 18,
                                              ),
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    bottom: 5 *
                                                        SizeConfig()
                                                            .heightScale),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                        const SizedBox(height: 60),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                              "We will send a verification code \n to your registered ${isEmail ? "email" : "mobile number"}",
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
                        GetBuilder<EditEmailPhoneController>(
                            builder: (controller) => controller.formProcessing
                                ? const SpinKitThreeBounce(
                                    size: 25,
                                    duration: Duration(milliseconds: 800),
                                    color: Colors.grey,
                                  )
                                : TextButton(
                                    onPressed: () async {
                                      String response =
                                          await controller.secondVerification(
                                              true,
                                              isEmail
                                                  ? controller
                                                      .emailController.text
                                                  : controller.countryCode +
                                                      controller
                                                          .mobileController
                                                          .text);
                                      Get.to(() => (VerifyOtpEditEmailPassword(
                                            isEmail: isEmail,
                                          )));
                                      // try {
                                      //   await _controller
                                      //       .updateUserCredentials();
                                      //   MethodResponse result =
                                      //       await _controller
                                      //           .verifyForgotRequest(isEmail);
                                      //   if (result.isSuccess) {
                                      //     await _controller.forgotPassword();
                                      //     Get.to(() => ResetPassword());
                                      //   } else {
                                      //     showSnackBar(context,
                                      //         msg: result.errorMessage);
                                      //   }
                                      // } catch (e) {
                                      //   showSnackBar(context,
                                      //       msg: _controller.errorMessage);
                                      // }
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
            ])));
  }
}
