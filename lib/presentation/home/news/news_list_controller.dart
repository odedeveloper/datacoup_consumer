// import 'package:datacoup/domain/model/news_model.dart';
// import 'package:datacoup/presentation/authentication/auth_controller/location_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class NewsListController extends GetxController {
//   int currentKeyInterestAreaIndex = 0;
//   String currentCategory = "Awareness_Article";
//   List<NewsModel> trendingVideos = [];
//   int oneTimeCount = 9;
//   var locationController = Get.find<LocationController>();

//   Map<String, List<NewsModel>> newsList = {
//     "Awareness_Article": [],
//     "Privacy_Article": [],
//     "Risk Exposure_Article": [],
//     "Security_Article": [],
//     "Protect yourself_Article": []
//   };

//   Map<String, int> pageNumberMap = {
//     "Awareness_Article": 1,
//     "Privacy_Article": 1,
//     "Risk Exposure_Article": 1,
//     "Security_Article": 1,
//     "Protect yourself_Article": 1
//   };

//   Map<String, bool> isFinished = {
//     "Awareness_Article": false,
//     "Privacy_Article": false,
//     "Risk Exposure_Article": false,
//     "Security_Article": false,
//     "Protect yourself_Article": false
//   };

//   Map<String, String> lastEvaluatedKeys = {
//     "Awareness_Article": '',
//     "Privacy_Article": '',
//     "Risk Exposure_Article": '',
//     "Security_Article": '',
//     "Protect yourself_Article": ''
//   };

//   Map<String, dynamic> scroller = {};

//   late ScrollController s1;
//   late ScrollController s2;
//   late ScrollController s3;
//   late ScrollController s4;
//   late ScrollController s5;

//   ScrollController trendingVideoController = ScrollController();
//   bool isVideoLoading = false;

//   late ScrollController currentScrollController;

//   bool isLoading = true;
//   bool isLoadMore = false;
//   int pageNumber = 1;
//   List<String> keyInterestAreas = [
//     "Awareness_Article",
//     "Privacy_Article",
//     "Risk Exposure_Article",
//     "Security_Article",
//     "Protect yourself_Article"
//   ];

//   @override
//   onInit() {
//     s1 = ScrollController();
//     s2 = ScrollController();
//     s3 = ScrollController();
//     s4 = ScrollController();
//     s5 = ScrollController();

//     scroller = {
//       "Awareness_Article": s1,
//       "Privacy_Article": s2,
//       "Risk Exposure_Article": s3,
//       "Security_Article": s4,
//       "Protect yourself_Article": s5
//     };
//     currentScrollController = s1;

//     getNewsList("Awareness_Article");
//     getTrendingVideos();
//     super.onInit();
//   }

//   reRunInit() {
//     currentKeyInterestAreaIndex = 0;
//     currentCategory = "Awareness_Article";
//     trendingVideos = [];
//     newsList = {
//       "Awareness_Article": [],
//       "Privacy_Article": [],
//       "Risk Exposure_Article": [],
//       "Security_Article": [],
//       "Protect yourself_Article": []
//     };
//     pageNumberMap = {
//       "Awareness_Article": 1,
//       "Privacy_Article": 1,
//       "Risk Exposure_Article": 1,
//       "Security_Article": 1,
//       "Protect yourself_Article": 1
//     };
//     isFinished = {
//       "Awareness_Article": false,
//       "Privacy_Article": false,
//       "Risk Exposure_Article": false,
//       "Security_Article": false,
//       "Protect yourself_Article": false
//     };
//     lastEvaluatedKeys = {
//       "Awareness_Article": '',
//       "Privacy_Article": '',
//       "Risk Exposure_Article": '',
//       "Security_Article": '',
//       "Protect yourself_Article": ''
//     };
//     isLoading = true;
//     isLoadMore = false;
//     pageNumber = 1;
//     update();
//     getNewsList("Awareness_Article");
//     getTrendingVideos();
//   }

//   // void hitApi() async {
//   //   Response response = await DioInstance().dio.get("https://za4y199la5.execute-api.us-east-1.amazonaws.com/prod/view");
//   //   print(response);

//   // }

//   updateCurrentTab(int value) {
//     currentKeyInterestAreaIndex = value;
//     currentCategory = getCurrentTab(value);
//     if (pageNumberMap[currentCategory]! == 1) {
//       getNewsList(currentCategory);
//     }
//     currentScrollController = scroller[currentCategory];
//     update();
//   }

//   getCurrentTab(int value) {
//     for (int i = 0; i < keyInterestAreas.length; i++) {
//       if (i == value) {
//         return keyInterestAreas[i];
//       }
//     }
//   }

//   NewsModel getCurrentNewsItem(int index, String categoryType) {
//     return newsList[categoryType]![index];
//   }

//   void getNewsList(String categoryType) async {
//     if (isFinished[categoryType] == false) {
//       isLoadMore = true;

//       if (pageNumberMap[categoryType]! == 1) {
//         isLoading = true;
//       }

//       update();
//       List data = await fetchNewsItemsByCategory(
//           oneTimeCount, categoryType, lastEvaluatedKeys[categoryType]!,
//           country: locationController.country,
//           state: locationController.state,
//           zipCode: locationController.zipCode);
//       List<NewsModel> itemsList = data[0];
//       String newLastEvaluatedKey = data[1];

//       if (newLastEvaluatedKey == '' && lastEvaluatedKeys[categoryType] != '') {
//         isFinished[categoryType] = true;
//       }
//       if (oneTimeCount > itemsList.length) {
//         isFinished[categoryType] = true;
//       }

//       lastEvaluatedKeys[categoryType] = newLastEvaluatedKey;

//       if (pageNumberMap[categoryType]! == 1) {
//         if (itemsList.isNotEmpty) {
//           pageNumberMap[categoryType] = pageNumberMap[categoryType]! + 1;
//           newsList[categoryType]?.clear();
//           newsList[categoryType]?.addAll(itemsList);
//         }
//       } else {
//         if (itemsList.isNotEmpty) {
//           newsList[categoryType]?.addAll(itemsList);
//         }
//       }
//       isLoading = false;
//       isLoadMore = false;
//       update();
//     }
//   }

//   Future<bool> likeUnlikeNewsItemUsingId(
//       String id, String categoryType, bool isLiked) async {
//     try {
//       int newsIndex =
//           newsList[categoryType]!.indexWhere((element) => element.newsId == id);
//       await likeUnlikeNews(id, isLiked);
//       newsList[categoryType]![newsIndex].isFavourite =
//           isLiked ? 'true' : 'false';
//       update();
//       return true;
//     } catch (e) {
//       print(e);
//       print("error");
//       return false;
//     }
//   }

//   Future<bool> likeUnlikeVideoUsingId(String id, bool isLiked) async {
//     try {
//       int newsIndex =
//           trendingVideos.indexWhere((element) => element.newsId == id);
//       await likeUnlikeNews(id, isLiked);
//       trendingVideos[newsIndex].isFavourite = isLiked ? 'true' : 'false';
//       update();
//       return true;
//     } catch (e) {
//       print(e);
//       print("error");
//       return false;
//     }
//   }

//   getController(index) {
//     return scroller.values.elementAt(index);
//   }

//   getCurrentScrollController() {
//     print(currentCategory);
//     return scroller[currentCategory];
//   }

//   bool isCurrentNewsListEmpty() {
//     return newsList[currentCategory]!.isEmpty;
//   }

//   void getTrendingVideos() async {
//     isVideoLoading = true;
//     update();
//     String categoryType = getRandomCategory();
//     List<NewsModel> itemsList = (await fetchNewsItemsByCategory(
//         5, categoryType, '',
//         country: locationController.country,
//         state: locationController.state))[0];
//     trendingVideos.clear();
//     trendingVideos.addAll(itemsList);
//     isVideoLoading = false;
//     update();
//   }

//   String getRandomCategory() {
//     Random random = Random();
//     int limit = keyInterestAreas.length;
//     int randomNumber = random.nextInt(limit);
//     return keyInterestAreas[randomNumber].replaceAll("_Article", "_Video");
//   }

//   bool isVideoLiked(String id) {
//     bool isLiked = trendingVideos
//                 .firstWhere((element) => element.newsId == id)
//                 .isFavourite ==
//             'true'
//         ? true
//         : false;
//     return isLiked;
//   }
// }
