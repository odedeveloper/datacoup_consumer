import 'package:datacoup/export.dart';

class QuizController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  QuizController(
      {required this.localRepositoryInterface,
      required this.apiRepositoryInterface});
}
