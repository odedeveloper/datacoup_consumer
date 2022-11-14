import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppSettingController extends GetxController {
  bool isDark = false;
  String language = "English";
  List<String> supportedLanguages =["English", "Hindi"];
  final Map<String,Locale> _locales = {"English":const Locale('en','US'), "Hindi": const Locale('hi','IN')};

  @override
  onInit(){
    initializeDarkMode();
    initializeLanguage();
    super.onInit();
  }

  initializeDarkMode(){
    bool darkMode = GetStorage().hasData("DarkMode");
    if(!darkMode){
      GetStorage().write("DarkMode","false");
    }
    else{
      String darkModeValue = GetStorage().read("DarkMode");
      if(darkModeValue=="true"){
        updateDarkMode(true);
      }
      else if(darkModeValue=="false"){
        updateDarkMode(false);
      }
    }
  }

  initializeLanguage(){
    bool isPresent = GetStorage().hasData("Language");
    if(!isPresent){
      GetStorage().write("Language","English");
    }
    else{
      String value = GetStorage().read("Language");
      updateLanguage(value);
    }
  }

  updateDarkMode(bool value){
    isDark = value;
    Get.changeThemeMode(isDark?ThemeMode.dark:ThemeMode.light);
    if(isDark){
      GetStorage().write("DarkMode","true");
    }
    else{
      GetStorage().write("DarkMode","false");
    }
    update();
  }

  updateLanguage(String value){
    language = value;
    Get.updateLocale(_locales[value]!);
    GetStorage().write("Language",value);
    update();
  }

}