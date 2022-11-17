import 'package:datacoup/presentation/home/news/news_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  String country = '';
  String state = '';
  String zipCode = '';
  bool isUpdating = false;
  TextEditingController zipCodeController = TextEditingController();

  updateCountry(String value) {
    country = value;
    update();
  }

  updateState(String value) {
    state = value;
    update();
  }

  updateZipCode(String value) {
    zipCode = value;
    zipCodeController.text = value;
    update();
  }

  updateIsUpdating(bool value) {
    isUpdating = value;
    update();
  }

  //updating different controllers to fetch the latest news
  updateDashboard() {
    updateZipCode(zipCodeController.text);
    var newsController = Get.find<NewsController>();
    // var feedController = Get.find<FeedController>();
    // var newsListController = Get.find<NewsListController>();
    // _newsController.reRunInit();
    // newsListController.reRunInit();
    // feedController.reRunInit();
    isUpdating = false;
  }
}
