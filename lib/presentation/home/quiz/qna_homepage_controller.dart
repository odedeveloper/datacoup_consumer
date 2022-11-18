import 'package:datacoup/data/datasource/qna_api.dart';
import 'package:datacoup/domain/model/activity_item_model.dart';
import 'package:datacoup/export.dart';

class QnaHomePageController extends GetxController {
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
      const Duration(seconds: 4),
      () async {
        await ApiRepositoryImpl().fetchUserProfile().then(
          (_) async {
            quizMainLoader(false);
            odenId = Get.find<HomeController>().user!.value.odenId!;
            await fetchUserHistory(odenId, '');
            await fetchBestScore(odenId);
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
    // try {
    dynamic data = await getBestScore(odenId);

    if (data != null) {
      bestScore = data['score'];

      badge = data['badge'];
    }

    isUpdating = false;
    isProcess = false;
    update();
  }
}
