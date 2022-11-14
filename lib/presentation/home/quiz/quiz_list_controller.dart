import 'package:datacoup/data/datasource/qna_api.dart';
import 'package:datacoup/domain/model/quiz_item_model.dart';
import 'package:datacoup/presentation/home/home_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class QuizListController extends GetxController {
  List<QuizItemModel> quizzesList = [];

  bool isUpdating = false;
  bool isProcess = false;

  String odenId = Get.find<HomeController>().user!.value.odenId!;

  @override
  onInit() {
    fetchQuizzesList(odenId, '');
    super.onInit();
  }

  updateIsUpdating(bool value) {
    isUpdating = value;
    update();
  }

  fetchQuizzesList(String odenId, String topic) async {
    try {
      isUpdating = true;

      List<QuizItemModel> data = await getActivity(odenId, topic = '');
      quizzesList = data;
      print(quizzesList);
      isUpdating = false;
      isProcess = false;
      update();
    } catch (error) {
      isProcess = false;
      isUpdating = false;
      update();
      print(error.toString());
    }
  }
}