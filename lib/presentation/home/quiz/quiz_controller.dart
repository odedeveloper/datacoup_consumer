import 'package:datacoup/export.dart';

class QuizController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  QuizController(
      {required this.localRepositoryInterface,
      required this.apiRepositoryInterface});

  QuizModel? quizModel;
  RxBool quizListLoader = true.obs;

  Future<void> getAllQuiz({String? odenId, String? topic}) async {
    quizModel =
        await apiRepositoryInterface.getQuizzies(odenId: odenId, topic: topic);
  }
}
