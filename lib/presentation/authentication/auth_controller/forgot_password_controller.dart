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

class ForgotPasswordController extends GetxController {
  String email = '';
  String password = '';
  String confirmPassword = '';
  String countryCode = '+91';
  String mobile = '';
  String errorMessage = '';
  bool formProcessing = false;
  bool isByEmail = true;
  String generatedOtp = '';
  String otp = '';

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

  resetUiUserPassword() {
    emailController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    mobileController.text = '';
    otpController.text = '';
    mobile = '';
    countryCode = '+91';
    email = '';
    password = '';
    confirmPassword = '';
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

  Future<MethodResponse> verifyPasswordOtpRequest(bool isByEmail) async {
    if (password == '' || password.isEmpty) {
      return MethodResponse(errorMessage: StringConst.ENTER_PASSWORD);
    }
    if (password.length < 8) {
      return MethodResponse(errorMessage: StringConst.PASSWORD_LENGTH);
    }
    if (!_passwordRegExp.hasMatch(password)) {
      return MethodResponse(errorMessage: StringConst.VALID_PASSWORD);
    }
    if (confirmPassword == '' || confirmPassword.isEmpty) {
      return MethodResponse(errorMessage: StringConst.ENTER_CONFIRM_PASSWORD);
    }
    if (confirmPassword != password) {
      return MethodResponse(
          errorMessage: StringConst.PASWWORD_MATCH_CONFIRM_PASSWORD);
    }
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

  forgotPassword() async {
    formProcessing = true;
    update();
    String user = isByEmail ? email : countryCode + mobile;
    try {
      var rng = Random();
      generatedOtp = (rng.nextInt(900000) + 100000).toString();
      print(generatedOtp);

      String response = await resetPasswordApi(isByEmail, user, generatedOtp);
      if (response != 'success') {
        errorMessage = response;
      }
      formProcessing = false;
      update();
    } catch (e) {
      errorMessage = e.toString();

      formProcessing = false;
      update();
      rethrow;
    }
  }

  resetPassword(bool isEmail) async {
    formProcessing = true;
    update();
    String user = isByEmail ? email : countryCode + mobile;
    try {
      String response =
          await adminResetPasswordApi(user, passwordController.text);
      print(response);
      if (response == 'No account found' || response != 'success') return false;
      return true;
    } on CognitoClientException catch (e) {
      print("yeah");
      errorMessage = '';
      if (e.code == 'NetworkError') {
        errorMessage = StringConst.INTERNET_NOT_AVAILABLE;
      } else {
        errorMessage = e.message!;
      }
      formProcessing = false;
      update();
      rethrow;
    } catch (e) {
      errorMessage = StringConst.UNKNOWN_ERROR_OCCURRED;
      formProcessing = false;
      update();
      rethrow;
    }
  }
}
