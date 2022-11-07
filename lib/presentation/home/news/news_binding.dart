import 'package:datacoup/export.dart';

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
