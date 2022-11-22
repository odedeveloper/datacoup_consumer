// import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'dart:developer';

import 'package:datacoup/presentation/authentication/auth_controller/authentication_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationController extends GetxController {
  bool isLoggedIn = false;
  bool authInProgress = false;
  var gotoNavigate = false.obs;

  @override
  onInit() {
    initializeUser();
    super.onInit();
  }

  initializeUser() async {
    try {
      bool? rememberStatus = GetStorage().read("RememberMe");
      bool isRememberMe = rememberStatus ?? true;

      if (isRememberMe == false) {
        updateLoggedIn(false);
        return;
      }
      bool isAuthenticated = await UserService(userPool).checkAuthenticated();
      await UserService(userPool).refreshSession();
      // -- need to fix here....
      log("is rem@@@@ = $isRememberMe");
      if (isRememberMe) {
        updateLoggedIn(true);
      } else {
        updateLoggedIn(false);
      }
      gotoNavigate.value = true;
    } catch (e) {
      log("init user error $e");
      gotoNavigate.value = true;
      updateLoggedIn(false);
    }
  }

  updateLoggedIn(bool value) {
    isLoggedIn = value;
    update();
  }

  updateAuthInProgress(bool value) {
    authInProgress = value;
    update();
  }

  logOut() {
    GetStorage().write("RememberMe", false);
    updateLoggedIn(false);
  }
}
