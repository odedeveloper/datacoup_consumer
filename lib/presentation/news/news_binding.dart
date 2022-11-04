import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/news/news_controller.dart';

class NewsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => NewsController(
        apiRepositoryInterface: Get.find(),
        localRepositoryInterface: Get.find(),
      ),
    );
  }
}
