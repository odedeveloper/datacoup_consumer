import 'package:datacoup/export.dart';

class ProfileController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;

  ProfileController({
    required this.localRepositoryInterface,
  });

  @override
  void onReady() {
    loadUser();
    super.onReady();
  }


void loadUser(){}

}
