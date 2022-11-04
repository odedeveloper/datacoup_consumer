import 'dart:developer';

import 'package:datacoup/export.dart';

class NewsController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  NewsController({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  RxString selectedcountry = ''.obs;
  RxString selectedState = ''.obs;
  RxString selectedzipCode = ''.obs;
  RxString selectedkeyInterest = 'Awareness_Article'.obs;
  RxString selectedkeyInterestforVideo = 'Awareness_Article'.obs;
  RxInt newsOfDayCount = 5.obs;
  RxBool newsOfDayLoader = true.obs;
  RxBool videoOfDayLoader = true.obs;
  RxBool interestVideoLoader = true.obs;
  RxBool trendingVideoLoader = true.obs;
  RxBool socialMediaLoader = true.obs;
  RxBool interestNewsLoader = true.obs;
  String? lastEvaluatedKey;

  List<String> keyInterestAreas = [
    "Awareness_Article",
    "Privacy_Article",
    "Risk Exposure_Article",
    "Security_Article",
    "Protect yourself_Article"
  ];

  Future<NewsModel?> getAllNews(
      {required String? type, required int? count}) async {
    try {
      Location location = Location(
        country: [selectedcountry.value],
        state: [selectedState.value],
        zipCode: selectedzipCode.value,
      );

      NewsModel? newsModel = await apiRepositoryInterface.getNews(
          type: type,
          count: count,
          lastEvaluatedKey: lastEvaluatedKey,
          location: location);

      // if (newsModel!.lastEvaluatedKey != null) {
      //   lastEvaluatedKey = newsModel.lastEvaluatedKey;
      // }

      return newsModel;
    } catch (e) {
      log("$e");
      return null;
    }
  }
}
