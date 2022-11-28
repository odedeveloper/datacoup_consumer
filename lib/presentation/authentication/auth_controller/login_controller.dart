// import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:datacoup/data/datasource/user_account_api.dart';
import 'package:datacoup/export.dart';

final RegExp _mobileNumberRegExp = RegExp(r'^[0-9]*$');
final RegExp _emailRegExp = RegExp(
  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
);
final RegExp _passwordRegExp = RegExp(
  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
);

class LoginController extends GetxController {
  // String email = '';
  String password = '';
  // String countryCode = '+91';
  String username = '';
  // String mobile = '';
  String errorMessage = '';
  bool isAllNumbers = false;
  bool formProcessing = false;
  // bool isByEmail = false;
  // bool isByMobile = false;
  // bool isByUsername = true;
  bool rememberMe = true;
  // TextEditingController emailController = TextEditingController();
  // TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool passwordHidden = true;
  static int callLogin = 0;

  @override
  onInit() {
    bool isRememberMe = GetStorage().read("RememberMe") ?? true;
    // updateRememberMe(isRememberMe);
    super.onInit();
  }

  updatePasswordHiddens(bool value) {
    passwordHidden = value;
    update();
  }

  // updateEmail(String value) {
  //   email = value;
  //   update();
  // }

  updatePassword(String value) {
    password = value;
    update();
  }

  // updateMobile(String value) {
  //   mobile = value;
  //   update();
  // }

  updateErrorMessage(String value) {
    errorMessage = value;
    update();
  }

  Future<bool> deleteAccount() async {
    try {
      bool deleteAccountResponse = await deleteAccountApi();

      if (deleteAccountResponse) {
        return true;
      }
      return false;
    } on Exception catch (e) {
      rethrow;
    }
  }

  // updateCountryCode(String value) {
  //   countryCode = value;
  //   update();
  // }

  updateFormProcessing(bool value) {
    formProcessing = value;
    update();
  }

  // updateIsByEmail(bool value) {
  //   isByEmail = value;
  //   isByMobile = !value;
  //   isByUsername = false;
  //   if (isByEmail) {
  //     emailController.text = '';
  //   } else {
  //     mobileController.text = '';
  //     usernameController.text = '';
  //   }
  //   passwordController.text = '';
  //   update();
  // }

  // updateIsByMobile(bool value) {
  //   isByMobile = value;
  //   isByEmail = !value;
  //   isByUsername = !value;
  //   if (isByMobile) {
  //     mobileController.text = '';
  //   } else {
  //     emailController.text = '';
  //     usernameController.text = '';
  //   }
  //   passwordController.text = '';
  //   update();
  // }

  // updateIsByUsername(bool value) {
  //   isByMobile = !value;
  //   isByEmail = !value;
  //   isByUsername = value;
  //   if (isByUsername) {
  //     usernameController.text = '';
  //   } else {
  //     emailController.text = '';
  //     mobileController.text = '';
  //   }
  //   passwordController.text = '';
  //   update();
  // }

  updateRememberMe(bool value) {
    rememberMe = value;
    GetStorage().write("RememberMe", rememberMe);
    update();
  }

  Future<MethodResponse> verifyLogInRequest() async {
    // if (isByEmail) {
    //   if (email == '' || email.isEmpty) {
    //     return MethodResponse(errorMessage: StringConst.ENTER_EMAIL_PROCEED);
    //   }
    //   if (!_emailRegExp.hasMatch(email)) {
    //     return MethodResponse(errorMessage: StringConst.VALID_EMAIL);
    //   }
    // } else if (isByMobile) {
    //   if (mobile == '' || mobile.isEmpty) {
    //     return MethodResponse(errorMessage: StringConst.ENTER_MOBILE_PROCEED);
    //   }
    //   if (mobile.length < 8) {
    //     return MethodResponse(errorMessage: StringConst.CHECK_MOBILE_LENGTH);
    //   }
    //   if (!_mobileNumberRegExp.hasMatch(mobile)) {
    //     return MethodResponse(errorMessage: StringConst.VALID_MOBILE);
    //   }
    // } else if (isByUsername) {
    //   if (usernameController.text == '' || usernameController.text.isEmpty) {
    //     return MethodResponse(errorMessage: StringConst.ENTER_USERNAME_PROCEED);
    //   }
    //   if (username.length < 8) {
    //     return MethodResponse(errorMessage: StringConst.CHECK_USERNAME_LENGTH);
    //   }
    //   if (!_mobileNumberRegExp.hasMatch(username)) {
    //     return MethodResponse(errorMessage: StringConst.VALID_USERNAME);
    //   }
    // }
    bool flag = true;
    if (username.contains(' ')) {
      flag = false;
      return MethodResponse(errorMessage: StringConst.VALID_USERNAME);
    }

    for (var i = 0; i < username.length; i++) {
      bool found = username[i].contains(RegExp(r'[0-9]'));
      if (username[i] == ' ') {
        flag = false;

        return MethodResponse(errorMessage: StringConst.VALID_USERNAME);
      }
      if (!found) {
        flag = false;
        break;
      }
    }
    isAllNumbers = flag;
    if (flag) {
      if (username.length < 10) {
        print(username);
        print(username.length);
        return MethodResponse(errorMessage: StringConst.VALID_MOBILE);
      }
    }
    if (password == '' || password.isEmpty) {
      return MethodResponse(errorMessage: StringConst.ENTER_PASSWORD);
    }
    if (password.length < 8) {
      return MethodResponse(errorMessage: "Incorrect username or password");
    }
    if (!_passwordRegExp.hasMatch(password)) {
      return MethodResponse(errorMessage: "Incorrect username or password");
    }
    return MethodResponse(isSuccess: true);
  }

  updateUsername(value) {
    username = value;
  }

  updateUsernamePassword() {
    // updateEmail(emailController.text.toLowerCase());
    // updateMobile(mobileController.text);
    updateUsername(usernameController.text);
    updatePassword(passwordController.text);
  }

  Future<bool> login(UserService userService) async {
    try {
      String getPrimaryUsername = usernameController.text;
      if (usernameController.text[0] == '+') {
        getPrimaryUsername = usernameController.text.split('+')[1];
        print(getPrimaryUsername);
      }
      String primaryFromCognitoResponse =
          await getPrimaryFromCognito(getPrimaryUsername);

      if (primaryFromCognitoResponse == "No account found") {
        updateErrorMessage(primaryFromCognitoResponse);
        return false;
      }
      try {
        bool isUserValid =
            await userService.login(primaryFromCognitoResponse, password);
        print('LOGIN ERROR---');
        print(isUserValid);
        return isUserValid;
      } on CognitoClientException catch (e) {
        String errorMessage = '';
        if (e.code == 'NetworkError') {
          errorMessage = StringConst.INTERNET_NOT_AVAILABLE;
        } else {
          errorMessage = e.message!;
        }
        updateErrorMessage(errorMessage);
        rethrow;
      } catch (e) {
        // callLogin++;

        // if (callLogin < 1) {
        //   try {
        //     bool isUserValid =
        //         await _userService.login(primaryFromCognitoResponse, password);
        //     return isUserValid;
        //   } on CognitoClientException catch (e) {
        //     String _errorMessage = '';
        //     if (e.code == 'NetworkError') {
        //       _errorMessage = StringConst.INTERNET_NOT_AVAILABLE;
        //     } else {
        //       _errorMessage = e.message!;
        //     }
        //     updateErrorMessage(_errorMessage);
        //     rethrow;
        //   }
        // }

        updateFormProcessing(false);
        updateErrorMessage(StringConst.UNKNOWN_ERROR_OCCURRED);

        rethrow;
      }
    }
    // on AuthException catch (e) {
    //   String _errorMessage = '';

    //   _errorMessage = e.message;

    //   updateErrorMessage(_errorMessage);
    //   rethrow;
    // }
    catch (e) {
      print('LOGIN FAILED______-----_______');
      print(e);

      updateFormProcessing(false);
      updateErrorMessage(StringConst.UNKNOWN_ERROR_OCCURRED);
      rethrow;
    }
  }
}
