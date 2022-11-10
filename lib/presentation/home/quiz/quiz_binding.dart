import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/quiz_controller.dart';

class QuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => QuizController(
        localRepositoryInterface: Get.find(),
        apiRepositoryInterface: Get.find(),
      ),
    );
  }
}
