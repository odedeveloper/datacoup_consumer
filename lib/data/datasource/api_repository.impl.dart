import 'dart:developer';
import 'dart:math' as math;

import 'package:datacoup/export.dart';

class ApiRepositoryImpl extends ApiRepositoryInterface {
  CognitoUserPool? _userPool;
  CognitoUserSession? _session;
  CognitoUser? _cognitoUser;
  CognitoCredentials? _credentials;

  @override
  Future<CognitoUserPool> cogintoRegister() async {
    Map<String, dynamic> serverConfig = appSettingsDev;
    try {
      final userPool = CognitoUserPool(
          serverConfig["awsUserPoolId"], serverConfig["awsClientId"]);
      _userPool = userPool;
      return userPool;
    } catch (e) {
      log("error on cognito register $e");
      throw UnimplementedError();
    }
  }

  @override
  Future<User?> getUserFromToken(String? token) async {
    if (token == _session!.getIdToken().jwtToken) {
      LoginResponse? loginResponse = await fetchUserProfile();
      return loginResponse!.user;
    } else {
      return null;
    }
  }

  // / Check if user's current session is valid
  @override
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
    final iat = math.min(accessTokenIAT, idTokenIAT);
    return (now - iat);
  }

  @override
  Future<String?> login(LoginRequest login) async {
    try {
      _cognitoUser = CognitoUser(login.credentials, _userPool!,
          storage: _userPool!.storage);

      final authDetails = AuthenticationDetails(
          username: login.credentials, password: login.password);

      _session = await _cognitoUser!.authenticateUser(authDetails);

      await saveTokensToDeviceStorage(_session!);
    } on CognitoClientException catch (e) {
      return e.message.toString();
    } catch (e) {
      log("error while login $e");
      return null;
    }
    return null;
  }

  @override
  Future<String?> signUp(LoginRequest login) async {
    try {
      await _userPool!.signUp(login.credentials!, login.password!);
    } on CognitoClientException catch (e) {
      return e.message.toString();
    } catch (e) {
      log("error while Signup $e");
      return null;
    }
    return null;
  }

  saveTokensToDeviceStorage(CognitoUserSession session) {
    GetStorage deviceStorage = GetStorage();

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

  @override
  Future<LoginResponse?> fetchUserProfile() async {
    try {
      final response = await DioInstance().dio.get(fetchUserProfileUrl);
      if (response.statusCode != 503) {
        Map<String, dynamic> data = Map.from(response.data);
        User? user = User.fromJson(data);
        String? token = await LocalRepositoryImpl().getToken();
        return LoginResponse(token: token, user: user);
      } else {
        return null;
      }
    } catch (e) {
      log("error on fetch user profile $e");
      throw UnimplementedError();
    }
  }

  @override
  Future<void> logout(String? token) async {
    log("removing token from server $token");
    return;
  }

  @override
  Future<List<Product>?> getProduct() async {
    await Future.delayed(const Duration(seconds: 2));
    return products;
  }
}
