import 'package:datacoup/export.dart';

class DailyNewsController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;

  DailyNewsController({
    required this.apiRepositoryInterface,
  });

  RxList<Item> allFavouriteNewsItem = <Item>[].obs;

  List<String> keyInterestAreas = [
    "Awareness_Article",
    "Privacy_Article",
    "Risk Exposure_Article",
    "Security_Article",
    "Protect yourself_Article"
  ];

  @override
  void onReady() {
    loadUser();
    super.onReady();
  }

  void loadUser() {}
}
