import 'package:datacoup/export.dart';

enum LoginState { loading, initail }

final RegExp _mobileNumberRegExp = RegExp(r'^[0-9]*$');
final RegExp _emailRegExp = RegExp(
  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
);
final RegExp _passwordRegExp = RegExp(
  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
);

class LoginController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  LoginController({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  final emailTextContoller = TextEditingController();
  final phoneNumberTextContoller = TextEditingController();
  final passwordTextContoller = TextEditingController();
  RxString selectedCountryCode = "1".obs;
  var loginState = LoginState.initail.obs;
  RxBool loginByPhone = false.obs;
  RxBool showPassword = true.obs;

  RxBool rememberMe = false.obs;

  @override
  void onReady() {
    apiRepositoryInterface.cogintoRegister();
    super.onReady();
  }

  clearState() {
    phoneNumberTextContoller.text = '';
    emailTextContoller.text = '';
    passwordTextContoller.text = '';
    loginByPhone.value = false;
    selectedCountryCode("1");
  }

  Future<bool> updateLoginMode(bool byPhone) async {
    emailTextContoller.clear();
    phoneNumberTextContoller.clear();
    passwordTextContoller.clear();
    loginByPhone(byPhone);
    return byPhone;
  }

  Future<bool> updateShowPassword(bool show) async {
    showPassword(show);
    return show;
  }

  Future<bool> updateRememberMe(bool rMe) async {
    rememberMe(rMe);
    return rMe;
  }

  Future<String> updateCountryCode(String code) async {
    selectedCountryCode(code);
    return code;
  }

  Future<String?> login() async {
    final email = emailTextContoller.text;
    final mobileNumber = phoneNumberTextContoller.text;
    final password = passwordTextContoller.text;

    try {
      loginState(LoginState.loading);
      String data = loginByPhone.value
          ? (selectedCountryCode.value + mobileNumber)
          : email;
      String? res = await apiRepositoryInterface.login(
        LoginRequest(credentials: data, password: password),
      );
      loginState(LoginState.initail);
      return res;
    } on CognitoClientException catch (e) {
      loginState(LoginState.initail);

      if (e.code == 'NetworkError') {
        return StringConst.INTERNET_NOT_AVAILABLE;
      } else {
        return e.message!;
      }
    } on AuthException catch (_) {
      loginState(LoginState.initail);
      return null;
    } catch (e) {
      return StringConst.UNKNOWN_ERROR_OCCURRED;
    }
  }

  Future<MethodResponse> verifyLogInRequest() async {
    if (!loginByPhone.value) {
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

    if (passwordTextContoller.text == '' ||
        passwordTextContoller.text.isEmpty) {
      return MethodResponse(errorMessage: StringConst.ENTER_PASSWORD);
    }
    if (passwordTextContoller.text.length < 8) {
      return MethodResponse(errorMessage: "Incorrect username or password");
    }
    if (!_passwordRegExp.hasMatch(passwordTextContoller.text)) {
      return MethodResponse(errorMessage: "Incorrect username or password");
    }
    return MethodResponse(isSuccess: true);
  }
}
