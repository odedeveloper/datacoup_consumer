import 'package:datacoup/export.dart';

class DailyNewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ProfileController(
        localRepositoryInterface: Get.find(),
      ),
    );
  }
}
