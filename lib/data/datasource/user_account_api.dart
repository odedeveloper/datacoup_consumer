import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:datacoup/data/configs/api_endpoints.dart';
import 'package:datacoup/data/configs/dio_utils.dart';
import 'package:datacoup/domain/model/user.dart';
import 'package:dio/dio.dart';
import 'package:global_configuration/global_configuration.dart';

Future<String> setUsername(String username) async {
  try {
    print(username);
    Response response = await Dio().get(
        GlobalConfiguration().get("baseURL") + getSetUsernameUrl(username));
    // (await DioInstance().dio.get(getSetUsernameUrl(username)));
    print(response);
    if (response.statusCode != 503) {
      Map<String, dynamic> data = Map.from(response.data);
      print('returning 1');

      return data['message'];
    } else {
      print('returning 2');
      return 'Username already exists';
    }
  } catch (error) {
    log("error to get userProfile $error");
    print(error);
    rethrow;
  } finally {}
}

Future<String> getPrimaryFromCognito(String username) async {
  try {
    // await Amplify.Auth.signOut();

    Response response;
    if (username.startsWith(new RegExp(r'[0-9]')) &&
        username.indexOf('+') != 0) {
      response = await Dio().post(
          GlobalConfiguration().get("baseURL") + GET_PRIMARY_FROM_CONGITO,
          data: {'username': '+$username'});
    } else {
      response = await Dio().post(
          GlobalConfiguration().get("baseURL") + GET_PRIMARY_FROM_CONGITO,
          data: {'username': username});
    }

    // await DioInstance().dio.get(getPrimaryFromCognitoUrl(username));
    // await Dio.get(getPrimaryFromCognitoUrl(username));

    if (response.statusCode != 503) {
      Map<String, dynamic> data = Map.from(response.data);
      print(data['username']);
      return data['username'];
    } else {
      Map<String, dynamic> data = Map.from(response.data);
      print(data['message']);
      return data['message'];
    }
  } catch (error) {
    log("error to get userProfile $error");
    print(error);
    rethrow;
  } finally {}
}

Future<UserModel?> fetchUserProfileApi(String deviceId) async {
  try {
    Response response = await DioInstance().dio.get(FETCH_PROFILE_URL);
    if (response.statusCode != 503) {
      Map<String, dynamic> data = Map.from(response.data);
      UserModel userModel = UserModel.fromJson(data);
      return userModel;
    } else {
      return null;
    }
  } catch (error) {
    log("error to get userProfile $error");
    rethrow;
  } finally {}
}

Future<UserModel> createUserProfileApi(UserModel userModel,
    {String username = ''}) async {
  try {
    Response response;

    response = await DioInstance().dio.post(
      CREATE_PROFILE_URL,
      data: {
        "email": userModel.email,
        "firstName": userModel.firstName,
        "lastName": userModel.lastName,
        'phone': userModel.phone,
        'country': userModel.country,
        'state': userModel.state,
        'zipCode': userModel.zipCode,
        'profileImage': userModel.profileImage,
        'gender': userModel.gender,
        'dob': userModel.dob,
        'bestScore': userModel.bestScore,
        'emailVerified': userModel.emailVerified,
        'phoneVerified': userModel.phoneVerified,
        'password': userModel.password,
        'odenId': username.isEmpty ? userModel.odenId : username,
        'primary': userModel.primary
      },
    );
    Map<String, dynamic> data = Map.from(response.data);
    UserModel user = UserModel.fromJson(data);
    return user;
  } catch (error) {
    print('-----_____----- SIGN UP ERROR');
    print(error);
    rethrow;
  } finally {}
}

Future<String> uploadProfileImageApi(String filePath) async {
  File imageFile = File(filePath);
  List<int> imageBytes = imageFile.readAsBytesSync();
  String base64Image = base64.encode(imageBytes);
  try {
    Response response =
        await DioInstance().dio.put(UPLOAD_PROFILE_IMG_URL, data: {
      "fileData": base64Image,
      "mimeType": "image/jpeg",
    });
    log("pic update response ${response.extra} ${response.data}");
    Map data = Map.from(response.data);
    return data['data']['url'];
  } catch (error) {
    log("data pic error $error");
    rethrow;
  } finally {}
}

Future<String> adminResetPasswordApi(String value, String password) async {
  try {
    Response response;
    String primaryFromCognitoResponse = '';
    primaryFromCognitoResponse = await getPrimaryFromCognito(value);
    print(primaryFromCognitoResponse);
    if (primaryFromCognitoResponse == "No account found") {
      return primaryFromCognitoResponse;
    }
    response = await DioInstance().dio.post(ADMIN_RESET_PASSWORD,
        data: {"username": primaryFromCognitoResponse, "password": password});
    print(response);
    if (response.statusCode != 503) {
      Map<String, dynamic> data = Map.from(response.data);
      print(data['status']);
      return data['status'];
    } else {
      Map<String, dynamic> data = Map.from(response.data);
      print(data['status']);
      return data['status'];
    }
  } catch (error) {
    print(error);
    rethrow;
  } finally {}
}

Future<String> resetPasswordApi(bool isEmail, String value, String otp) async {
  try {
    Response response;
    if (isEmail) {
      response = await DioInstance().dio.post(RESET_PASSWORD,
          data: {"email": value, "type": 'email', "OTP": otp});
    } else {
      if (value.startsWith('+')) {
        response = await DioInstance().dio.post(RESET_PASSWORD,
            data: {"phone": value, "type": 'phone', "OTP": otp});
      } else {
        response = await DioInstance().dio.post(RESET_PASSWORD,
            data: {"phone": '+$value', "type": 'phone', "OTP": otp});
      }
    }
    if (response.statusCode != 503) {
      Map<String, dynamic> data = Map.from(response.data);
      print(data['message']);
      return data['message'];
    } else {
      Map<String, dynamic> data = Map.from(response.data);
      print(data['message']);
      return data['message'];
    }
  } catch (error) {
    rethrow;
  } finally {}
}

Future<String> verificationByOtp(bool isEmail, String value, String otp) async {
  try {
    Response response;
    if (isEmail) {
      response = await DioInstance().dio.post(DO_VERIFICATION,
          data: {"email": value, "type": 'email', "OTP": otp});
    } else {
      if (!value.startsWith("+")) {
        response = await DioInstance().dio.post(DO_VERIFICATION,
            data: {"phone": '+$value', "type": 'phone', "OTP": otp});
      } else {
        response = await DioInstance().dio.post(DO_VERIFICATION,
            data: {"phone": value, "type": 'phone', "OTP": otp});
      }
    }
    if (response.statusCode != 503) {
      Map<String, dynamic> data = Map.from(response.data);
      print(data['message']);
      return data['message'];
    } else {
      Map<String, dynamic> data = Map.from(response.data);
      print(data['message']);
      return data['message'];
    }
  } catch (error) {
    rethrow;
  } finally {}
}

Future<String> editEmailPhone(bool isByEmail, String value) async {
  try {
    Response response;
    if (!isByEmail) {
      if (value.startsWith('+')) {
        response = await DioInstance()
            .dio
            .post(EDIT_EMAIL_PHONE, data: {"type": 'phone', "phone": value});
      } else {
        response = await DioInstance().dio.post(EDIT_EMAIL_PHONE,
            data: {"type": 'phone', "phone": '+$value'});
      }
    } else {
      response = await DioInstance()
          .dio
          .post(EDIT_EMAIL_PHONE, data: {"type": 'email', "email": value});
    }
    Map<String, dynamic> data = Map.from(response.data);
    print(data['Attributes']['emailVerified']);

    return data['Attributes']['emailVerified'];
  } catch (error) {
    print('EDIT DETAILS ERROR -_-');
    print(error);
    rethrow;
  } finally {}
}
