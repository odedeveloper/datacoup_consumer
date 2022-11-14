
// import 'package:carousel_slider/carousel_controller.dart';
// import 'package:datacoup/domain/model/news_model.dart';
// import 'package:datacoup/presentation/authentication/auth_controller/location_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class FeedController extends GetxController {
//   int currentIndex = 0;
//   int pageNumber = 0;
//   bool isLoadMore = false;
//   bool isLoading = true;
//   int oneTimeCount = 10;
//   String lastEvaluatedKey = '';
//   bool itemsFinished = false;
//   String creator = 'Twitter';
//   ScrollController scroller = ScrollController();
//   CarouselController carouselController = CarouselController();
//   var locationController = Get.find<LocationController>();

//   List<NewsModel> feedItems = [];

//   @override
//   onInit() {
//     getFeedItems();
//     super.onInit();
//   }

//   //re running used in locationController when location is updated
//   reRunInit() {
//     pageNumber = 0;
//     isLoadMore = false;
//     lastEvaluatedKey = '';
//     itemsFinished = false;
//     feedItems = [];
//     update();
//     getFeedItems();
//   }

//   void getFeedItems() async {
//     if (itemsFinished == false) {
//       isLoadMore = true;

//       if (pageNumber == 1) {
//         isLoading = true;
//       }

//       update();
//       // List data = await fetchNewsItemsByCategory(
//       //     oneTimeCount, "Feed", lastEvaluatedKey,
//       //     state: locationController.state,
//       //     country: locationController.country,
//       //     zipCode: locationController.zipCode);

//       List<NewsModel> itemsList = data[0];
//       String newLastEvaluatedKey = data[1];
//       if (newLastEvaluatedKey == '' && lastEvaluatedKey != '') {
//         itemsFinished = true;
//       }
//       if (oneTimeCount > itemsList.length) {
//         itemsFinished = true;
//       }
//       lastEvaluatedKey = newLastEvaluatedKey;
//       if (pageNumber == 1) {
//         if (itemsList.isNotEmpty) {
//           pageNumber = pageNumber + 1;
//           feedItems.clear();
//           feedItems.addAll(itemsList);
//         }
//       } else {
//         if (itemsList.isNotEmpty) {
//           feedItems.addAll(itemsList);
//         }
//       }
//       if (oneTimeCount > itemsList.length) {
//         itemsFinished = true;
//       }
//       isLoading = false;
//       isLoadMore = false;
//       update();
//     }
//   }
// }
