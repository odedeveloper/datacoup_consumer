// import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'dart:math';

import 'package:datacoup/data/datasource/user_account_api.dart';
import 'package:datacoup/export.dart';

final RegExp _mobileNumberRegExp = RegExp(r'^[0-9]*$');
final RegExp _emailRegExp = RegExp(
  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
);
final RegExp _passwordRegExp = RegExp(
  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
);

class EditEmailPhoneController extends GetxController {
  String email = '';
  String password = '';
  String confirmPassword = '';
  String countryCode = '+91';
  String mobile = '';
  String errorMessage = '';
  bool formProcessing = false;
  bool isByEmail = true;
  String code = '';
  String otp = '';
  String generatedOtp = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  updateEmail(String value) {
    email = value;
    update();
  }

  updatePassword(String value) {
    password = value;
    update();
  }

  updateMobile(String value) {
    mobile = value;
    update();
  }

  updateErrorMessage(String value) {
    errorMessage = value;
    update();
  }

  updateCountryCode(String value) {
    countryCode = value;
    update();
  }

  updateFormProcessing(bool value) {
    formProcessing = value;
    update();
  }

  updateIsByEmail(bool value) {
    isByEmail = value;
    if (isByEmail) {
      emailController.text = '';
    } else {
      mobileController.text = '';
    }
    passwordController.text = '';
    update();
  }

  updateOtp(value) {
    otp = value;
    update();
  }

  updateUserPassword() {
    password = passwordController.text.trim();
    confirmPassword = confirmPasswordController.text.trim();
    otp = otpController.text.trim();
    update();
  }

  generateOtp() {
    var rng = Random();
    var code = rng.nextInt(900000) + 100000;
    print(code);
    return code.toString();
  }

  secondVerification(bool isByEmail, String value) async {
    generatedOtp = generateOtp();
    this.isByEmail = isByEmail;
    String verificationRequestResponse;

    try {
      verificationRequestResponse =
          await verificationByOtp(isByEmail, value, generatedOtp);

      print(verificationRequestResponse);

      SignUpController signUpController = Get.put(SignUpController());
      // updateVerificationUnderProgress(true);
      signUpController.updateGeneratedOtp(generatedOtp);
      update();
      return verificationRequestResponse;
    } catch (e) {
      print(e);
    }
  }

  createUserProfile() async {
    try {
      UserModel user;
      user = Get.find<UserProfileController>().user!;
      if (isByEmail) {
        user.email = emailController.text;
      } else {
        user.phone = countryCode + mobileController.text;
      }
      await createUserProfileApi(user, username: user.odenId!);
      // await fetchUserProfileApi('hjh');
      //TODO: call fetchuserprofileapi after editing is completed.
      // isUpdating = false;
      // isProfileCreated = true;

      update();
    } catch (error) {
      // isUpdating = false;
      // isProfileCreated = false;
      update();
      print(error.toString());
    }
  }

  editDetails() async {
    String editDetailsResponse;
    try {
      editDetailsResponse = await editEmailPhone(
          isByEmail, isByEmail ? emailController.text : mobileController.text);

      print(editDetailsResponse);

      update();
      return editDetailsResponse;
    } catch (e) {
      print(e);
    }
  }

  clearState() {
    mobileController.text = '';
    emailController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    generatedOtp = '';

    isByEmail = true;
    otp = '';
    update();
  }

  Future<MethodResponse> verifyRequest(bool isByEmail) async {
    if (isByEmail) {
      if (email == '' || email.isEmpty) {
        return MethodResponse(errorMessage: StringConst.ENTER_EMAIL_PROCEED);
      }
      if (!_emailRegExp.hasMatch(email)) {
        return MethodResponse(errorMessage: StringConst.VALID_EMAIL);
      }
    } else {
      if (mobile == '' || mobile.isEmpty) {
        return MethodResponse(errorMessage: StringConst.ENTER_MOBILE_PROCEED);
      }
      if (mobile.length < 8) {
        return MethodResponse(errorMessage: StringConst.CHECK_MOBILE_LENGTH);
      }
      if (!_mobileNumberRegExp.hasMatch(mobile)) {
        return MethodResponse(errorMessage: StringConst.VALID_MOBILE);
      }
    }
    return MethodResponse(isSuccess: true);
  }

  Future<MethodResponse> verifyOTPRequest() async {
    if (otp == '' || otp.isEmpty) {
      return MethodResponse(errorMessage: StringConst.ENTER_OTP_PROCEED);
    }
    if (otp.length < 6) {
      return MethodResponse(errorMessage: StringConst.VALID_OTP);
    }
    if (otp != generatedOtp) {
      return MethodResponse(errorMessage: StringConst.INVALID_OTP);
    }
    return MethodResponse(isSuccess: true);
  }

  Future<MethodResponse> verifyForgotRequest(bool isByEmail) async {
    if (isByEmail) {
      if ((email == '' || email.isEmpty) && password.isEmpty) {
        return MethodResponse(errorMessage: StringConst.ENTER_CREDENTIALS);
      }
      if (email == '' || email.isEmpty) {
        return MethodResponse(errorMessage: StringConst.ENTER_EMAIL);
      }
      if (!_emailRegExp.hasMatch(email)) {
        return MethodResponse(errorMessage: StringConst.VALID_EMAIL);
      }
    } else {
      if (mobile == '' || mobile.isEmpty) {
        return MethodResponse(errorMessage: StringConst.ENTER_MOBILE);
      }
      if (mobile.length < 8) {
        return MethodResponse(errorMessage: StringConst.CHECK_MOBILE_LENGTH);
      }
    }
    return MethodResponse(isSuccess: true);
  }

  updateUserCredentials() {
    updateEmail(emailController.text.trim());
    updateMobile(mobileController.text.trim());
  }
}
