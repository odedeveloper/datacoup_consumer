import 'dart:convert';
import 'dart:developer';
import 'dart:io';
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
  Future<UserModel?> getUserFromToken(String? token) async {
    String? refToken = await LocalRepositoryImpl().getRefreshToken();
    _cognitoUser = CognitoUser('', _userPool!, storage: _userPool!.storage);
    CognitoRefreshToken refreshToken = CognitoRefreshToken(refToken);
    _session = (await _cognitoUser!.refreshSession(refreshToken))!;
    log("checkign time ${_session!.getIdToken().jwtToken}");
    if (token == _session!.getIdToken().jwtToken) {
      LoginResponse? loginResponse = await fetchUserProfile();
      return loginResponse!.user;
    } else {
      await saveTokensToDeviceStorage(_session!);
      LoginResponse? loginResponse = await fetchUserProfile();
      return loginResponse!.user;
    }
  }

  // / Check if user's current session is valid
  @override
  Future<bool> checkAuthenticated() async {
    bool? result = await LocalRepositoryImpl().getuserLoggedIn();
    String? token = GetStorage().read("idToken");
    try {
      if (token != null) {
        LoginResponse? loginResponse = await fetchUserProfile();
        bool isRememberMe = GetStorage().read("RememberMe") ?? true;

        if (loginResponse != null) {
          // token valid
          if (isRememberMe == true) {
            return true;
          } else {
            logout(token);
            return false;
          }
        } else {
          // token Exipre and going to refresh Token
          UserModel? user = await getUserFromToken(token);
          if (user != null && result == true) {
            return true;
          } else {
            logout(token);
            return false;
          }
        }
      } else {
        // for new user creating new token
        UserModel? user = await getUserFromToken(token);
        if (user != null && result == true) {
          return true;
        } else {
          logout(token);
          return false;
        }
      }
    } catch (e) {
      log("error in checkAuthenticate $e");
      return false;
    }
  }

  int calculateClockDrift(int idTokenIAT, int accessTokenIAT) {
    final now = (DateTime.now().millisecondsSinceEpoch / 1000).floor();
    final iat = math.min(accessTokenIAT, idTokenIAT);
    return (now - iat);
  }

  @override
  Future<String?> login(LoginRequest login) async {
    _cognitoUser =
        CognitoUser(login.credentials, _userPool!, storage: _userPool!.storage);

    final authDetails = AuthenticationDetails(
        username: login.credentials, password: login.password);

    try {
      _session = await _cognitoUser!.authenticateUser(authDetails);
      await LocalRepositoryImpl().storeUserLogin(log: true);
      await saveTokensToDeviceStorage(_session!);
      return "success";
    } on CognitoClientException catch (e) {
      return e.message.toString();
    } catch (e) {
      _session = await _cognitoUser!.authenticateUser(authDetails);
      await LocalRepositoryImpl().storeUserLogin(log: true);
      await saveTokensToDeviceStorage(_session!);
      log("error while login $e");
      return "success";
    }
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
    LocalRepositoryImpl().saveIdToken(idToken: session.getIdToken().jwtToken);
    if (session.getRefreshToken() != null) {
      deviceStorage.write("refreshToken", session.getRefreshToken()?.token);
      LocalRepositoryImpl()
          .saveRefreshToken(refToken: session.getRefreshToken()?.token);
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
      final response = await DioInstance().dio.get(FETCH_PROFILE_URL);
      if (response.statusCode != 503) {
        UserModel? user = UserModel.fromJson(response.data);
        String? token = GetStorage().read("idToken") ?? "";
        return LoginResponse(token: token, user: user);
      } else {
        return null;
      }
    } catch (e) {
      log("error on fetch user profile $e");
      if (e is IOException) {
        log("no Internet");
      }
      return null;
    }
  }

  @override
  Future<void> logout(String? token) async {
    await LocalRepositoryImpl().clearAllData();
    log("removing token from server $token");
    return;
  }

  @override
  Future<NewsModel?> getNews({
    required String? type,
    required int? count,
    required String? lastEvaluatedKey,
    required Location? location,
  }) async {
    try {
      final response = await DioInstance().dio.get(
            newsVideoListUrl(
              type: type,
              count: count,
              lastEvaluatedKey: lastEvaluatedKey,
              location: location,
            ),
          );

      NewsModel? newsModel = NewsModel.fromJson(response.data);
      return newsModel;
    } catch (e) {
      log("error to get news type =$type, =$e");
      return null;
    }
  }

  @override
  Future<NewsModel?> getFavouriteNews(
      {required bool? type,
      required int? count,
      required String? lastEvaluatedKey}) async {
    try {
      final response =
          await DioInstance().dio.get(favouriteNewsUrl(count: count));

      NewsModel? newsModel = NewsModel.fromJson(response.data);
      return newsModel;
    } catch (e) {
      log("error to get fav and unfav news type =$type, =$e");
      return null;
    }
  }

  @override
  Future<String?> postFavouriteNews({String? newsId, bool? isLiked}) async {
    try {
      final uri = isLiked! ? FAVOURITE_NEWS : UNFAVOURITE_NEWS;
      await DioInstance().dio.post(uri, data: {'newsId': newsId});
    } catch (e) {
      log("error on post fav news $e");
    }
    return null;
  }

  @override
  Future<UserModel?> createUpdateUser(UserModel? user) async {
    try {
      final response = await DioInstance()
          .dio
          .post(CREATE_PROFILE_URL, data: userModelToJson(user!));
      UserModel updateduser = UserModel.fromJson(response.data);
      return updateduser;
    } catch (e) {
      log("error to create or update user $e");
      return null;
    }
  }

  @override
  Future<String?> uploadProfileImage(String filePath) async {
    try {
      File imageFile = File(filePath);
      List<int> imageBytes = imageFile.readAsBytesSync();
      String base64Image = base64.encode(imageBytes);

      final response =
          await DioInstance().dio.put(UPLOAD_PROFILE_IMG_URL, data: {
        "fileData": base64Image,
        "mimeType": "image/jpeg",
      });
      Map data = Map.from(response.data);
      return data['data']['url'];
    } catch (e) {
      log("error to upload profile img $e");
      return null;
    }
  }

  @override
  Future<void> submitQuizActivity(
      {String? odenId, List? option, int? score, int? quizId}) async {
    try {
      final response = await DioInstance().dio.post(
        SUBMIT_ACTIVITY,
        data: {
          'selectedAnswers': option,
          'score': score,
          'quizId': quizId,
          'odenId': odenId
        },
      );
      if (response.statusCode == 200) {
        log("${response.data["status"]}");
      } else {
        log("${response.data["status"]} * ${response.statusCode}");
      }
    } catch (e) {
      log("error on post QNA activity $e");
    }
  }

  @override
  Future<void> generateNewToken() async {}
}
