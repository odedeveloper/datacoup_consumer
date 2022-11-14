import 'package:datacoup/export.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AuthenticationController(),
    );
  }
}
