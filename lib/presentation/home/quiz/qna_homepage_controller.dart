import 'package:datacoup/data/datasource/qna_api.dart';
import 'package:datacoup/domain/model/activity_item_model.dart';
import 'package:datacoup/presentation/home/home_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class QnaHomePageController extends GetxController {
  List<ActivityItemModel> userHistory = [];
  String bestScore = '';
  String badge = 'Digital Novice';

  bool isUpdating = false;
  bool isProcess = false;

  String odenId = Get.find<HomeController>().user!.value.odenId!;

  @override
  onInit() {
    fetchUserHistory(odenId, '');
    fetchBestScore(odenId);
    super.onInit();
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

    if (data.isNotEmpty) {
      bestScore = data['score'];

      badge = data['badge'];
    }

    isUpdating = false;
    isProcess = false;
    update();
  }
}
