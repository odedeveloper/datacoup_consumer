import 'package:datacoup/export.dart';

class SignupController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  SignupController({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });
}
