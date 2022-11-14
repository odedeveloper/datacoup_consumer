import 'dart:io';
import 'dart:math';

import 'package:datacoup/data/datasource/user_account_api.dart';
import 'package:datacoup/domain/model/user.dart';
import 'package:datacoup/presentation/authentication/auth_controller/location_controller.dart';
import 'package:datacoup/presentation/authentication/auth_controller/signup_controller.dart';
import 'package:datacoup/presentation/utils/constants/string.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

class UserProfileController extends GetxController {
  String errorMessage = '';
  UserModel? user;
  UserModel? updatedUser;
  RxBool isUpdating = false.obs;
  bool isProcess = false;
  RxBool loadUserData = false.obs;
  String deviceImagePath = '';
  List<String> genderOptions = ['Male', 'Female', 'Other'];
  var locationController = Get.find<LocationController>();
  String bestScore = '';
  bool verificationInProgress = false;
  String generatedOtp = '';

  // String badge = 'Digital Novice';

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController bestScoreController = TextEditingController();

  @override
  onInit() {
    fetchUserProfile();
    super.onInit();
  }

  loadUpdatedUserData() async {
    loadUserData(true);
    await fetchUserProfile();
    loadUserData(false);
  }

  updateIsUpdating(bool value) {
    isUpdating.value = value;
    update();
  }

  updateErrorMessage(String value) {
    errorMessage = value;
    update();
  }

  _updateUserModel(UserModel updatedUser) {
    user = updatedUser;
    update();
  }

  updateUserProfile(Map<String, dynamic> map) {
    isUpdating.value = false;
    update();
  }

  updateDeviceImagePath(String value) {
    deviceImagePath = value;
    update();
  }

  updateGender(String value) {
    updatedUser!.gender = value;
    update();
  }

  updateCountry(String value) {
    updatedUser!.country = value;
    update();
  }

  updatezipCode(String value) {
    updatedUser!.zipCode = value;
    update();
  }

  updateState(String value) {
    updatedUser!.state = value;
    update();
  }

  updateVerificationUnderProgress(bool value) {
    verificationInProgress = value;
    update();
  }

  updateBestScore(String value) {
    updatedUser!.bestScore = value;
    update();
  }

  // updateBadge(String value) {
  //   updatedUser!.badge = value;
  //   update();
  // }
  generateOtp() {
    var rng = Random();
    var code = rng.nextInt(900000) + 100000;
    print(code);
    return code.toString();
  }

  updateIsEmailVerified(bool value) async {
    isProcess = true;

    updatedUser!.emailVerified = value ? "True" : 'False';
    print('EMAIL VERIFICATION');
    print(updatedUser!.emailVerified);
    update();
    await createUserProfile(updatedUser!);
    update();
  }

  updateIsPhoneVerified(bool value) async {
    isProcess = true;
    update();

    updatedUser!.phoneVerified = value ? "True" : 'False';

    createUserProfile(updatedUser!);
  }

  secondVerification(bool isByEmail, String value) async {
    generatedOtp = generateOtp();
    String verificationRequestResponse;

    try {
      verificationRequestResponse =
          await verificationByOtp(isByEmail, value, generatedOtp);

      print(verificationRequestResponse);

      SignUpController signUpController = Get.put(SignUpController());
      updateVerificationUnderProgress(true);
      print('VERIFICATION IN PROGRESS');
      print(verificationInProgress);
      signUpController.updateGeneratedOtp(generatedOtp);
      update();
      return verificationRequestResponse;
    } catch (e) {
      print(e);
    }
  }

  createUserProfile(UserModel user) async {
    try {
      if (deviceImagePath != '') {
        String awsImageUrl = await uploadProfileImageApi(deviceImagePath);
        user.profileImage = awsImageUrl;
      }
      UserModel data = await createUserProfileApi(user);
      updatedUser = data;
      locationController.updateCountry(updatedUser!.country!);
      locationController.updateState(updatedUser!.state!);
      locationController.updateZipCode(updatedUser!.zipCode!);
      // locationController.zipCodeController.text = updatedUser!.zipCode;

      print(updatedUser!);
      user = data;
      updateDeviceImagePath('');
      isUpdating.value = false;
      isProcess = false;
      update();
    } catch (error) {
      // log("image uploade erro $error");
      updatedUser = user;
      deviceImagePath = '';
      isProcess = false;
      update();
    }
  }

  updateUserUsingController() async {
    isProcess = true;
    update();
    updatedUser!.firstName = firstNameController.text.trim();
    updatedUser!.lastName = lastNameController.text.trim();
    updatedUser!.phone = phoneController.text.trim();
    updatedUser!.dob = dobController.text.trim();
    updatedUser!.zipCode = zipCodeController.text.trim();
    updatedUser!.bestScore = bestScoreController.text.trim();

    createUserProfile(updatedUser!);
  }

  fetchUserProfile() async {
    try {
      user = await fetchUserProfileApi("hjh");
      updatedUser = user;
      firstNameController.text = user!.firstName!;
      lastNameController.text = user!.lastName!;
      phoneController.text = user!.phone!;
      dobController.text = user!.dob!;
      zipCodeController.text = user!.zipCode!;
      bestScoreController.text = user!.bestScore!;

      //for updating the location in dashboard when profile is fetched
      locationController.updateCountry(user!.country!);
      locationController.updateState(user!.state!);
      locationController.zipCodeController.text = user!.zipCode!;
      locationController.updateZipCode(user!.zipCode!);
      print(user!.odenId);
      update();
    } catch (error) {
      if (error is DioError) {
        if (error.error is SocketException ||
            error.error is HttpException ||
            error.type == DioErrorType.connectTimeout ||
            error.type == DioErrorType.receiveTimeout) {
          errorMessage = StringConst.CHECK_YOUR_NETWORK_MESSAGE;
        }
        if (error.response?.statusCode == 404) {
          errorMessage = error.response?.data['error'];
        } else {
          errorMessage = StringConst.SOMETHING_WENT_WRONG_MESSAGE;
        }
      }
      rethrow;
    } finally {}
  }
}
