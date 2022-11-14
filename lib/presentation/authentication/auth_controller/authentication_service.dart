import 'dart:math';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';

final userPool = CognitoUserPool(GlobalConfiguration().get("awsUserPoolId"),
    GlobalConfiguration().get("awsClientId"));

class User {
  late String email;
  late String name;
  late String password;
  late bool confirmed = false;
  late bool hasAccess = false;

  User({required this.email, required this.name});
}

class UserService {
  late final CognitoUserPool _userPool;
  late CognitoUser _cognitoUser;
  late CognitoUserSession _session;

  UserService(this._userPool);
  late CognitoCredentials credentials;

  /// Login user
  Future<bool> login(String email, String password) async {
    print(email);
    print(password);
    _cognitoUser = CognitoUser(email, _userPool, storage: _userPool.storage);

    final authDetails = AuthenticationDetails(
      username: email,
      password: password,
    );

    bool isConfirmed;
    try {
      try {
        _session = (await _cognitoUser.authenticateUser(authDetails))!;
        print(_session);
        saveTokensToDeviceStorage(_session);
      } catch (e) {
        print(authDetails);
        print(e);
        _session = (await _cognitoUser.authenticateUser(authDetails))!;
        saveTokensToDeviceStorage(_session);
      }
    } on CognitoClientException catch (e) {
      print(e);
      if (e.code == 'UserNotConfirmedException') {
        return false;
      } else {
        print(e);
        rethrow;
      }
    }

    if (!_session.isValid()) {
      return false;
    }
    print("yeah");
    return true;
  }

  saveTokensToDeviceStorage(CognitoUserSession session) {
    GetStorage deviceStorage = GetStorage();
    print('PRINTING TOKEN----');
    print(session.getIdToken().jwtToken);
    deviceStorage.write("idToken", session.getIdToken().jwtToken);
    deviceStorage.write("idTokenExp", session.getIdToken().payload['exp']);
    deviceStorage.write("idTokenIAT", session.getIdToken().payload['iat']);
    if (session.getRefreshToken() != null) {
      deviceStorage.write("refreshToken", session.getRefreshToken()?.token);
    }
    deviceStorage.write("accessToken", session.getAccessToken().jwtToken);
    deviceStorage.write(
        "accessTokenExp", session.getAccessToken().payload['exp']);
    deviceStorage.write(
        "accessTokenIAT", session.getAccessToken().payload['iat']);
  }

  /// Fetch Device List
  Future<Map> fetchDeviceList(String email, String accessToken) async {
    _cognitoUser = CognitoUser(email, _userPool, storage: _userPool.storage);

    Map<String, dynamic> paramsReq = {
      'AccessToken': accessToken,
    };

    try {
      try {
        Map<String, dynamic> response =
            await _cognitoUser.client?.request('ListDevices', paramsReq);
        return response;
      } catch (e) {
        rethrow;
      }
    } on CognitoClientException {
      rethrow;
    }
  }

  /// Update Device List
  Future updateDeviceStatus(String email, String accessToken, String deviceKey,
      String rememberStatus) async {
    _cognitoUser = CognitoUser(email, _userPool, storage: _userPool.storage);
    Map<String, dynamic> paramsReq = {
      'AccessToken': accessToken,
      'DeviceKey': deviceKey,
      'DeviceRememberedStatus': rememberStatus
    };
    try {
      try {
        await _cognitoUser.client?.request('UpdateDeviceStatus', paramsReq);
      } catch (e) {
        rethrow;
      }
    } on CognitoClientException {
      rethrow;
    }
  }

  /// Forgot Device
  Future forgotDevice(
      String email, String accessToken, String deviceKey) async {
    _cognitoUser = CognitoUser(email, _userPool, storage: _userPool.storage);

    Map<String, dynamic> paramsReq = {
      'AccessToken': accessToken,
      'DeviceKey': deviceKey,
    };

    try {
      try {
        await _cognitoUser.client?.request('ForgetDevice', paramsReq);
      } catch (e) {
        rethrow;
      }
    } on CognitoClientException {
      rethrow;
    }
  }

  /// Forgot user
  Future forgotUser(String email) async {
    _cognitoUser = CognitoUser(email, _userPool, storage: _userPool.storage);
    try {
      try {
        await _cognitoUser.forgotPassword();
      } catch (e) {
        rethrow;
      }
    } on CognitoClientException {
      rethrow;
    }
  }

  Future<bool> changePassword(
      String email, String otpCode, String password) async {
    bool passwordConfirmed = false;
    try {
      try {
        _cognitoUser =
            CognitoUser(email, _userPool, storage: _userPool.storage);
        passwordConfirmed =
            await _cognitoUser.confirmPassword(otpCode, password);
      } catch (e) {
        rethrow;
      }
    } on CognitoClientException {
      rethrow;
    }
    return passwordConfirmed;
  }

  /// Sign up new user
  Future<bool> signUp(String email, String password) async {
    CognitoUserPoolData data;
    try {
      try {
        data = await _userPool.signUp(email, password);
        // print(data.user.getUserAttributes());
        // CognitoUserSession? session = await data.user.getCognitoUserSession();
        // saveTokensToDeviceStorage(session!);
        return true;
      } catch (e) {
        print(e);
        rethrow;
      }
    } on CognitoClientException {
      rethrow;
    }
  }

  /// Confirm user's account with confirmation code sent to email
  Future<bool> confirmAccount(
      String email, String confirmationCode, String password) async {
    try {
      try {
        _cognitoUser =
            CognitoUser(email, _userPool, storage: _userPool.storage);
        bool isValid = await _cognitoUser.confirmRegistration(confirmationCode);
        if (isValid) {
          final authDetails = AuthenticationDetails(
            username: email,
            password: password,
          );
          _session = (await _cognitoUser.authenticateUser(authDetails))!;
          saveTokensToDeviceStorage(_session);
        }
        // print(_cognitoUser.getSession());
        return isValid;
      } catch (e) {
        rethrow;
      }
    } on CognitoClientException {
      rethrow;
    }
  }

  /// Resend confirmation code to user's email
  Future<void> resendConfirmationCode(String email) async {
    try {
      try {
        _cognitoUser =
            CognitoUser(email, _userPool, storage: _userPool.storage);
        await _cognitoUser.resendConfirmationCode();
      } catch (e) {
        rethrow;
      }
    } on CognitoClientException {
      rethrow;
    }
  }

  // / Check if user's current session is valid
  Future<bool> checkAuthenticated() async {
    GetStorage deviceStorage = GetStorage();

    var idTokenExp = await deviceStorage.read("idTokenExp");
    var idTokenIAT = await deviceStorage.read("idTokenIAT");
    var accessTokenExp = await deviceStorage.read("accessTokenExp");
    var accessTokenIAT = await deviceStorage.read("accessTokenIAT");

    if (idTokenExp == null &&
        idTokenIAT == null &&
        accessTokenExp == null &&
        accessTokenIAT == null) {
      return false;
    }

    final now = (DateTime.now().millisecondsSinceEpoch / 1000).floor();
    final adjusted = now - calculateClockDrift(idTokenIAT, accessTokenIAT);

    return adjusted < accessTokenExp && adjusted < idTokenExp;
  }

  int calculateClockDrift(int idTokenIAT, int accessTokenIAT) {
    final now = (DateTime.now().millisecondsSinceEpoch / 1000).floor();
    final iat = min(accessTokenIAT, idTokenIAT);
    return (now - iat);
  }

  /// Logout User
  Future<void> signOut() async {
    await credentials.resetAwsCredentials();
    return _cognitoUser.signOut();
  }

  //refreshSession
  Future<void> refreshSession() async {
    GetStorage deviceStorage = GetStorage();
    _cognitoUser = CognitoUser('', _userPool, storage: _userPool.storage);
    var refreshToken = CognitoRefreshToken(deviceStorage.read("refreshToken"));
    _session = (await _cognitoUser.refreshSession(refreshToken))!;
    saveTokensToDeviceStorage(_session);
  }

  /// SignIn with Social
  Future signUserInWithAuthCode(
      String iDToken, String deviceName, String acsToken) async {
    final idToken = CognitoIdToken(iDToken);
    final accessToken = CognitoAccessToken(acsToken);
    final session = CognitoUserSession(idToken, accessToken);
    saveTokensToDeviceStorage(session);
  }
}
