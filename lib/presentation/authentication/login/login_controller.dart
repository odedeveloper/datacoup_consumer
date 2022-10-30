import 'package:datacoup/export.dart';

enum LoginState { loading, initail }

class LoginController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  LoginController({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  final fullNameTextContoller = TextEditingController();
  final usernameTextContoller = TextEditingController();
  final emailTextContoller = TextEditingController();
  final phoneNumberTextContoller = TextEditingController();
  final passwordTextContoller = TextEditingController();
  final confirmpasswordTextContoller = TextEditingController();
  var loginState = LoginState.initail.obs;
  RxBool loginByPhone = false.obs;
  RxBool showPassword = true.obs;
  RxBool rememberMe = false.obs;

  RxList<String> genderlist = ["Male", "Female", "Other"].obs;
  RxString selectedreturnGender = "".obs;
  RxString selectedCountryCode = "1".obs;
  RxString selectedCountry = "".obs;
  RxString selectedstate = "".obs;

  @override
  void onReady() {
    apiRepositoryInterface.cogintoRegister();
    super.onReady();
  }

  updateCountry(String value) {
    selectedCountry(value);
  }

  updateState(String value) {
    selectedstate(value);
  }

  Future<bool> updateLoginMode(bool byPhone) async {
    emailTextContoller.clear();
    phoneNumberTextContoller.clear();
    passwordTextContoller.clear();
    confirmpasswordTextContoller.clear();
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

  Future<bool> login() async {
    final email = emailTextContoller.text;
    final password = passwordTextContoller.text;

    try {
      loginState(LoginState.loading);
      LoginResponse? loginResponse = await apiRepositoryInterface.login(
        LoginRequest(email: email, password: password),
      );

      if (loginResponse != null) {
        loginState(LoginState.initail);
        return true;
      } else {
        loginState(LoginState.initail);
        return false;
      }
    } on AuthException catch (_) {
      loginState(LoginState.initail);
      return false;
    }
  }

  Future<bool> signUp() async {
    final email = emailTextContoller.text;
    final password = passwordTextContoller.text;

    try {
      loginState(LoginState.loading);
      LoginResponse? loginResponse = await apiRepositoryInterface.login(
        LoginRequest(email: email, password: password),
      );

      if (loginResponse != null) {
        loginState(LoginState.initail);
        return true;
      } else {
        loginState(LoginState.initail);
        return false;
      }
    } on AuthException catch (_) {
      loginState(LoginState.initail);
      return false;
    }
  }
}
