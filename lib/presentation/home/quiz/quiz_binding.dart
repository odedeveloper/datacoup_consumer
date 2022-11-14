import 'package:datacoup/export.dart';

class QuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => QuizController(),
    );
  }
}
