import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/qna_homepage_controller.dart';
import 'package:datacoup/presentation/home/quiz/quiz_history_result_controller.dart';

class QuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => QuizController(),
    );
    Get.lazyPut(
      () => QnaHomePageController(),
    );
    Get.lazyPut(
      () => QuizHistoryResultController(),
    );
  }
}
