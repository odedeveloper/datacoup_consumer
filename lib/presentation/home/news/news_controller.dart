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
  RxString selectedkeyInterestforReelVideo = 'Awareness_Article'.obs;
  RxString selectedReelVideoType = 'Videos'.obs;
  RxString selectedReelVideoChannels = 'YouTube'.obs;
  RxString selectedReelVideoTrending = ''.obs;
  RxInt newsOfDayCount = 50.obs;
  RxBool newsOfDayLoader = true.obs;
  RxBool videoOfDayLoader = true.obs;
  RxBool interestVideoLoader = true.obs;
  RxBool trendingVideoLoader = true.obs;
  RxBool socialMediaLoader = true.obs;
  RxBool interestNewsLoader = true.obs;
  RxBool favouriteLoader = true.obs;
  RxBool reelVideosLoader = true.obs;
  String? lastEvaluatedKey;

  RxList<Item> allFavouriteNewsItem = <Item>[].obs;

  List<String> keyInterestAreas = [
    "Awareness_Article",
    "Privacy_Article",
    "Risk Exposure_Article",
    "Security_Article",
    "Protect yourself_Article"
  ];

  List<String> favouriteTypes = ["Articles", "Photos", "Videos"];
  List<String> reelVideosTypes = ["Videos"];
  List<String> reelVideosChannels = ["YouTube"];
  List<String> reelVideosTrendingTypes = ["GDPA", "CCPA"];

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

  Future likeAndUnlikeNews({bool? isLiked, Item? data}) async {
    if (isLiked == true) {
      data!.isFavourite = true;
      allFavouriteNewsItem.insert(0, data);
    } else {
      data!.isFavourite = false;
      allFavouriteNewsItem
          .removeWhere((element) => element.newsId == data.newsId);
    }
    await apiRepositoryInterface.postFavouriteNews(
        isLiked: isLiked, newsId: data.newsId);
  }

  Future getAllFavouriteNes({required bool? type, required int? count}) async {
    try {
      NewsModel? newsModel = await apiRepositoryInterface.getFavouriteNews(
        type: type,
        count: count,
        lastEvaluatedKey: lastEvaluatedKey,
      );

      // if (newsModel!.lastEvaluatedKey != null) {
      //   lastEvaluatedKey = newsModel.lastEvaluatedKey;
      // }
      for (var element in newsModel!.items!) {
        if (element.isFavourite == false) {
          element.isFavourite = true;
        }
      }
      allFavouriteNewsItem.addAll(newsModel.items!);
    } catch (e) {
      log("$e");
    }
  }
}
