import 'package:datacoup/export.dart';


class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ProfileController(
        localRepositoryInterface: Get.find(),
      ),
    );
  }
}
