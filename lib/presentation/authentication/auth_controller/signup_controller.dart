// ignore_for_file: use_rethrow_when_possible

import 'dart:math';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:datacoup/data/datasource/user_account_api.dart';
import 'package:datacoup/domain/model/user.dart';
import 'package:datacoup/presentation/authentication/auth_controller/authentication_service.dart';
import 'package:datacoup/presentation/authentication/auth_controller/user_profile_controller.dart';
import 'package:datacoup/presentation/utils/constants/string.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/colors.dart';
// import 'package:get/get.dart';

final RegExp _mobileNumberRegExp = RegExp(r'^[0-9]*$');
final RegExp _emailRegExp = RegExp(
  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
);
final RegExp _passwordRegExp = RegExp(
  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
);

class SignUpController extends GetxController {
  late UserModel user;

  String email = '';
  String password = '';
  String confirmPassword = '';
  String username = '';
  String mobile = '';
  String countryCode = '+91';
  String country = '';
  String state = '';
  String zipCode = '';
  String bestScore = '';
  String errorMessage = '';
  String otp = '';
  bool confirmPasswordHidden = true;
  bool passwordHidden = true;

  String deviceImagePath = '';
  String generatedOTP = '';
  List<String> genderOptions = ['Male', 'Female', 'Other'];
  bool isByEmail = true;
  String messageForUsernameVerification = '';
  Color colorForUsernameVerification = darkSkyBlueColor;
  bool isEmailVerified = false;
  bool isPhoneVerified = false;

  bool isPayloadVerified = false;

  bool isLoading = false;
  bool isUpdating = false;
  bool isProfileCreated = false;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  // TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController bestScoreController = TextEditingController();

  updateEmail(String value) {
    email = value;
    update();
  }

  updatePassword(String value) {
    password = value;
    update();
  }

  updateConfirmPassword(String value) {
    confirmPassword = value;
    update();
  }

  updateErrorMessage(String value) {
    errorMessage = value;
    update();
  }

  updateIsPayload(bool value) {
    isPayloadVerified = value;
    update();
  }

  updateConfirmPasswordHidden(bool value) {
    confirmPasswordHidden = value;
    update();
  }

  updatePasswordHidden(bool value) {
    passwordHidden = value;
    update();
  }

  updateOtp(String value) {
    otp = value;
    update();
  }

  updateIsEmailVerified(bool value) async {
    isEmailVerified = true;

    UserProfileController userProfileController =
        Get.put(UserProfileController());
    await userProfileController.updateIsEmailVerified(isEmailVerified);
    update();
  }

  updateIsPhoneVerified(bool value) async {
    isPhoneVerified = true;

    UserProfileController userProfileController =
        Get.put(UserProfileController());
    await userProfileController.updateIsPhoneVerified(isPhoneVerified);
    update();
  }

  updateIsByEmail(bool value) {
    isByEmail = value;
    if (isByEmail) {
      emailController.text = '';
      phoneController.text = '';
    } else {
      phoneController.text = '';
      emailController.text = '';
    }
    passwordController.text = '';
    confirmPasswordController.text = '';
    update();
  }

  updateGender(value) {
    user.gender = value;
    update();
  }

  updateCountryCode(String value) {
    countryCode = '+$value';
    update();
  }

  updateDeviceImagePath(String value) {
    deviceImagePath = value;
    update();
  }

  updateCountry(String value) {
    country = value;
    update();
  }

  updateLoading(bool value) {
    isLoading = value;
    update();
  }

  updateState(String value) {
    state = value;
    update();
  }

  updateGeneratedOtp(String value) {
    generatedOTP = value;
    update();
  }

  generateOtp() {
    var rng = Random();
    var code = rng.nextInt(900000) + 100000;
    print(code);
    return code.toString();
  }

  checkUsername(String username) async {
    try {
      print('HERHEHREHRHERHEHRERE-----------------');
      if (username.isEmpty) {
        messageForUsernameVerification = 'Type in Username for Verification';
        colorForUsernameVerification = darkSkyBlueColor;
      } else {
        messageForUsernameVerification = await setUsername(username);
        if (messageForUsernameVerification == 'username is available') {
          colorForUsernameVerification = Colors.greenAccent;
        } else {
          colorForUsernameVerification = Colors.redAccent;
        }
      }

      update();
      print('MESSAGE');
      print(messageForUsernameVerification);
    } catch (error) {
      print(error);
      rethrow;
    } finally {}
  }

  updateUsingTextController() {
    updateEmail(emailController.text.toLowerCase());
    mobile = phoneController.text.trim();
    updatePassword(passwordController.text);
    updateConfirmPassword(confirmPasswordController.text);
  }

  clearState() {
    phoneController.text = '';
    emailController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    dobController.text = '';
    isByEmail = true;
    otp = '';
    countryController.text = '';
    stateController.text = '';
    zipCodeController.text = '';
    update();
  }

  Future<MethodResponse> verifySignUpRequest(bool isByEmail) async {
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
    if (password.isEmpty && confirmPassword.isEmpty) {
      return MethodResponse(errorMessage: StringConst.ENTER_PASSWORD_PROCEED);
    }
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
    if (password != confirmPassword) {
      return MethodResponse(
          errorMessage: StringConst.PASWWORD_MATCH_CONFIRM_PASSWORD);
    }
    return MethodResponse(isSuccess: true);
  }

  Future sendCode(UserService userService) async {
    try {
      generatedOTP = generateOtp();
      String verificationRequestResponse;
      if (isByEmail) {
        verificationRequestResponse = await verificationByOtp(
            isByEmail, emailController.text, generatedOTP);
        isLoading = false;
        print(verificationRequestResponse);
        return verificationRequestResponse;
      } else {
        verificationRequestResponse = await verificationByOtp(
            isByEmail, countryCode + phoneController.text, generatedOTP);
        isLoading = false;
        print(verificationRequestResponse);
        return verificationRequestResponse;
      }
    } on CognitoClientException catch (e) {
      if (e.code == 'NetworkError') {
        errorMessage = StringConst.INTERNET_NOT_AVAILABLE;
      } else {
        errorMessage = e.message!;
      }
      throw (e);
    } catch (e) {
      errorMessage = StringConst.UNKNOWN_ERROR_OCCURRED;
      throw (e);
    }
  }

  Future<MethodResponse> verifyOTPRequest() async {
    if (otp == '' || otp.isEmpty) {
      return MethodResponse(errorMessage: StringConst.ENTER_OTP_PROCEED);
    }
    if (otp.length < 6) {
      return MethodResponse(errorMessage: StringConst.VALID_OTP);
    }
    updateIsPayload(true);
    return MethodResponse(isSuccess: true);
  }

  Future<bool> confirmOTP() async {
    try {
      isLoading = true;
      update();

      if (isByEmail) {
        isEmailVerified = otp == generatedOTP;
      } else {
        isPhoneVerified = otp == generatedOTP;
      }
      isLoading = false;
      update();
      return otp == generatedOTP;
    } on CognitoClientException catch (e) {
      print('error is here');
      print(e);
      if (e.code == 'NetworkError') {
        updateErrorMessage(StringConst.INTERNET_NOT_AVAILABLE);
      } else {
        updateErrorMessage(e.message!);
      }
      throw (e);
    } catch (e) {
      print('error is here2');
      print(e);
      updateErrorMessage(StringConst.UNKNOWN_ERROR_OCCURRED);
      throw (e);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<MethodResponse> verifyCreateProfileRequest(UserModel user) async {
    if (user.firstName == '' && user.lastName == '') {
      return MethodResponse(errorMessage: StringConst.ENTER_NAME_PROCEED);
    }
    if (user.firstName == '' || user.firstName!.isEmpty) {
      return MethodResponse(errorMessage: StringConst.ENTER_FIRST_NAME);
    }
    if (user.lastName == '' || user.lastName!.isEmpty) {
      return MethodResponse(errorMessage: StringConst.ENTER_LAST_NAME);
    }

    if (user.email == '' || user.email!.isEmpty) {
      return MethodResponse(errorMessage: StringConst.ENTER_EMAIL_PROCEED);
    }

    if (user.email != '' && user.email!.isNotEmpty) {
      if (!_emailRegExp.hasMatch(user.email!)) {
        return MethodResponse(errorMessage: StringConst.VALID_EMAIL);
      }
    }

    if (user.phone == '' || user.phone!.isEmpty) {
      return MethodResponse(errorMessage: StringConst.ENTER_MOBILE);
    }

    if (user.phone != '' && user.phone!.isNotEmpty) {
      if (user.phone!.length < 8) {
        return MethodResponse(errorMessage: StringConst.CHECK_MOBILE_LENGTH);
      }
      if (!_mobileNumberRegExp.hasMatch(user.phone!)) {
        return MethodResponse(errorMessage: StringConst.VALID_MOBILE);
      }
    }
    return MethodResponse(isSuccess: true);
  }

  Future<String> signUp() async {
    try {
      isLoading = true;
      update();

      generatedOTP = generateOtp();
      String verificationRequestResponse;
      if (isByEmail) {
        verificationRequestResponse = await verificationByOtp(
            isByEmail, emailController.text, generatedOTP);
        isLoading = false;
        print(verificationRequestResponse);
        return verificationRequestResponse;
      } else {
        verificationRequestResponse = await verificationByOtp(
            isByEmail, countryCode + phoneController.text, generatedOTP);
        isLoading = false;
        print(verificationRequestResponse);
        return verificationRequestResponse;
      }
      // await Amplify.Auth.signUp(
      //     username: countryCode + phoneController.text,
      //     password: passwordController.text,
      //     options: CognitoSignUpOptions(userAttributes: {
      //       CognitoUserAttributeKey.email: emailController.text,
      //       CognitoUserAttributeKey.phoneNumber: '+919718081100'
      //     }));

    } catch (e) {
      print('by mistake----');
      print(e);
      errorMessage = StringConst.UNKNOWN_ERROR_OCCURRED;
      update();
      throw (errorMessage);
    }
  }

  Future<MethodResponse> verifyRequest(bool isByEmail) async {
    if (isByEmail) {
      if ((email == '' || email.isEmpty) && password.isEmpty) {
        return MethodResponse(errorMessage: StringConst.ENTER_CREDENTIALS);
      }
      if (email == '' || email.isEmpty) {
        return MethodResponse(errorMessage: StringConst.ENTER_EMAIL);
      }
      if (password == '' || password.isEmpty) {
        return MethodResponse(errorMessage: StringConst.ENTER_PASSWORD);
      }
    } else {
      if ((mobile == '' || mobile.isEmpty) && password.isEmpty) {
        return MethodResponse(errorMessage: StringConst.ENTER_CREDENTIALS);
      }
      if (mobile == '' || mobile.isEmpty) {
        return MethodResponse(errorMessage: StringConst.ENTER_MOBILE);
      }
      if (mobile.length < 8) {
        return MethodResponse(errorMessage: StringConst.CHECK_MOBILE_LENGTH);
      }
      if (password == '' || password.isEmpty) {
        return MethodResponse(errorMessage: StringConst.ENTER_PASSWORD);
      }
    }
    updateIsPayload(true);
    return MethodResponse(isSuccess: true);
  }

  createUserProfile(UserModel user) async {
    try {
      if (deviceImagePath != '') {
        String awsImageUrl = await uploadProfileImageApi(deviceImagePath);
        user.profileImage = awsImageUrl;
      }
      await createUserProfileApi(user, username: usernameController.text);
      isUpdating = false;
      isProfileCreated = true;
      update();
    } catch (error) {
      isUpdating = false;
      isProfileCreated = false;
      update();
      print(error.toString());
    }
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
    isPayloadVerified = true;
    return MethodResponse(isSuccess: true);
  }

  void initUserProfile() {
    user = UserModel(
        firstName: '',
        lastName: '',
        email: isByEmail ? email : '',
        phone: isByEmail ? '' : mobile,
        emailVerified: isEmailVerified ? 'True' : 'False',
        phoneVerified: isPhoneVerified ? 'True' : 'False',
        odenId: '',
        country: '',
        state: '',
        zipCode: '',
        bestScore: '',
        profileImage: 'https://picsum.photos/id/1005/200/200',
        gender: 'Male',
        dob: DateTime.now().toString(),
        primary: 'TODO:'
        // badge: ''
        );
    update();
  }

  updateUserUsingController() async {
    try {
      isUpdating = true;
      update();
      user.firstName = firstNameController.text.trim();
      user.lastName = lastNameController.text.trim();
      user.email = emailController.text.trim().toLowerCase();
      user.phone = countryCode + phoneController.text.trim();
      user.dob = dobController.text.trim();
      user.country = country;
      user.state = state;
      user.zipCode = zipCodeController.text.trim();
      user.bestScore = bestScoreController.text.trim();
      user.password = passwordController.text.trim();

      // user.gender = genderController.text.trim();

      await createUserProfile(user);
      return true;
    } catch (e) {
      return false;
    }
  }
}
