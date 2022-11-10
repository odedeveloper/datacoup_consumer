import 'package:datacoup/domain/model/quiz_model.dart';
import 'package:datacoup/export.dart';

class QuizController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  QuizController(
      {required this.localRepositoryInterface,
      required this.apiRepositoryInterface});

  List<Option>? options = [];
  QuizModel? quizModel;
  RxBool quizListLoader = true.obs;
  RxBool showSubmitButtom = false.obs;
  RxBool showNextButtom = false.obs;
  RxList<int> progressList = <int>[].obs;

  Future selectUserOptions({int? index, Option? option}) async {
    progressList.add(index!);
    options!.add(option!);
  }

  Future<void> getAllQuiz({String? odenId, String? topic}) async {
    quizModel =
        await apiRepositoryInterface.getQuizzies(odenId: odenId, topic: topic);
  }

  Future subimtAnswer({String? odenId}) async {
    await apiRepositoryInterface.submitQuizActivity(
        odenId: odenId, option: options);
  }
}
