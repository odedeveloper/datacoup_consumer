import 'package:datacoup/export.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SignUpController(),
    );
  }
}
