import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/authentication/auth_controller/location_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        localRepositoryInterface: Get.find(),
        apiRepositoryInterface: Get.find(),
      ),
    );

    Get.lazyPut(
      () => UserProfileController(),
    );

    Get.lazyPut(
      () => LocationController(),
    );
  }
}
