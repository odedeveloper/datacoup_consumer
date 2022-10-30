import 'package:datacoup/export.dart';

enum SignUpState { loading, initail }

final RegExp _mobileNumberRegExp = RegExp(r'^[0-9]*$');
final RegExp _emailRegExp = RegExp(
  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
);
final RegExp _passwordRegExp = RegExp(
  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
);

class SignupController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  SignupController({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  final fullNameTextContoller = TextEditingController();
  final usernameTextContoller = TextEditingController();
  final emailTextContoller = TextEditingController();
  final phoneNumberTextContoller = TextEditingController();
  final passwordTextContoller = TextEditingController();
  final confirmpasswordTextContoller = TextEditingController();
  RxBool showConfirmPassword = true.obs;
  RxBool loginByPhone = false.obs;
  var signupState = SignUpState.initail.obs;

  RxList<String> genderlist = ["Male", "Female", "Other"].obs;
  RxString selectedreturnGender = "".obs;
  RxString selectedCountryCode = "1".obs;
  RxString enteredOtp = "".obs;
  RxString selectedCountry = "".obs;
  RxString selectedstate = "".obs;

  @override
  void onReady() {
    apiRepositoryInterface.cogintoRegister();
    super.onReady();
  }

  Future<bool> updateLoginMode(bool byPhone) async {
    emailTextContoller.clear();
    phoneNumberTextContoller.clear();
    passwordTextContoller.clear();
    confirmpasswordTextContoller.clear();
    loginByPhone(byPhone);
    return byPhone;
  }

  updateCountry(String value) {
    selectedCountry(value);
  }

  updateState(String value) {
    selectedstate(value);
  }

  Future<String> updateCountryCode(String code) async {
    selectedCountryCode(code);
    return code;
  }

  Future<bool> updateShowConfirmPassword(bool show) async {
    showConfirmPassword(show);
    return show;
  }

  clearState() {
    phoneNumberTextContoller.text = '';
    emailTextContoller.text = '';
    passwordTextContoller.text = '';
    confirmpasswordTextContoller.text = '';
    loginByPhone.value = false;
    update();
  }

  Future<bool> signUp() async {
    final email = emailTextContoller.text;
    final password = passwordTextContoller.text;

    try {
      signupState(SignUpState.loading);
      LoginResponse? loginResponse = await apiRepositoryInterface.login(
        LoginRequest(email: email, password: password),
      );

      if (loginResponse != null) {
        signupState(SignUpState.initail);
        return true;
      } else {
        signupState(SignUpState.initail);
        return false;
      }
    } on AuthException catch (_) {
      signupState(SignUpState.initail);
      return false;
    }
  }

  Future<MethodResponse> verifySignUpRequest(bool isByEmail) async {
    if (isByEmail) {
      if (emailTextContoller.text == '' || emailTextContoller.text.isEmpty) {
        return MethodResponse(errorMessage: StringConst.ENTER_EMAIL_PROCEED);
      }
      if (!_emailRegExp.hasMatch(emailTextContoller.text)) {
        return MethodResponse(errorMessage: StringConst.VALID_EMAIL);
      }
    } else {
      if (phoneNumberTextContoller.text == '' ||
          phoneNumberTextContoller.text.isEmpty) {
        return MethodResponse(errorMessage: StringConst.ENTER_MOBILE_PROCEED);
      }
      if (phoneNumberTextContoller.text.length < 8) {
        return MethodResponse(errorMessage: StringConst.CHECK_MOBILE_LENGTH);
      }
      if (!_mobileNumberRegExp.hasMatch(phoneNumberTextContoller.text)) {
        return MethodResponse(errorMessage: StringConst.VALID_MOBILE);
      }
    }
    if (passwordTextContoller.text.isEmpty &&
        confirmpasswordTextContoller.text.isEmpty) {
      return MethodResponse(errorMessage: StringConst.ENTER_PASSWORD_PROCEED);
    }
    if (passwordTextContoller.text == '' ||
        passwordTextContoller.text.isEmpty) {
      return MethodResponse(errorMessage: StringConst.ENTER_PASSWORD);
    }
    if (passwordTextContoller.text.length < 8) {
      return MethodResponse(errorMessage: StringConst.PASSWORD_LENGTH);
    }
    if (!_passwordRegExp.hasMatch(passwordTextContoller.text)) {
      return MethodResponse(errorMessage: StringConst.VALID_PASSWORD);
    }
    if (confirmpasswordTextContoller.text == '' ||
        confirmpasswordTextContoller.text.isEmpty) {
      return MethodResponse(errorMessage: StringConst.ENTER_CONFIRM_PASSWORD);
    }
    if (passwordTextContoller.text != confirmpasswordTextContoller.text) {
      return MethodResponse(
          errorMessage: StringConst.PASWWORD_MATCH_CONFIRM_PASSWORD);
    }
    return MethodResponse(isSuccess: true);
  }
}
