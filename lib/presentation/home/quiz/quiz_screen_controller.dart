import 'dart:developer';

import 'package:datacoup/data/datasource/qna_api.dart';
import 'package:datacoup/domain/model/activity_item_model.dart';
import 'package:datacoup/export.dart';

class QuizScreenController extends GetxController {
  List<ActivityItemModel> userHistory = [];
  RxBool quizMainLoader = true.obs;
  String bestScore = '';
  String badge = 'Digital Novice';

  bool isUpdating = false;
  bool isProcess = false;

  String odenId = "";

  // @override
  // onInit() {
  //   loadUserDataFirst();
  //   super.onInit();
  // }

  loadUserDataFirst() async {
    quizMainLoader(true);
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        await ApiRepositoryImpl().fetchUserProfile().then(
          (_) async {
            odenId = Get.find<HomeController>().user!.value.odenId!;
            await fetchUserHistory(odenId, '');
            await fetchBestScore(odenId);
            quizMainLoader(false);
          },
        );
      },
    );
  }

  updateIsUpdating(bool value) {
    isUpdating = value;
    update();
  }

  fetchData() async {
    var profileController = Get.find<HomeController>();

    await fetchUserHistory(profileController.user!.value.odenId!, '');
    await fetchBestScore(profileController.user!.value.odenId!);
    update();
  }

  fetchUserHistory(String odenId, String topic) async {
    try {
      List<ActivityItemModel> data = await getHistory(odenId, topic = '');
      data.sort((a, b) =>
          DateTime.parse(a.timestamp).compareTo(DateTime.parse(b.timestamp)));
      data = data.reversed.toList();
      userHistory = data;

      isUpdating = false;
      isProcess = false;

      update();
    } catch (error) {
      isProcess = false;
      update();
      print(error.toString());
    }
  }

  fetchBestScore(String odenId) async {
    try {
      Map<String, dynamic>? data = await getBestScore(odenId);

      if (data != null || data!.isNotEmpty) {
        bestScore = data['score'].toString().split(".")[0];

        badge = data['badge'];
      }
    } catch (e) {
      log("$e");
    }
    isUpdating = false;
    isProcess = false;
    update();
  }
}
