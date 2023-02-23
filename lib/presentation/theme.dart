import 'package:datacoup/presentation/utils/constants/colors.dart';
import 'package:datacoup/presentation/utils/constants/image.dart';
import 'package:flutter/material.dart';

class MyThemeData {
  static final darkTheme = ThemeData(
    fontFamily: AssetConst.RALEWAY_FONT,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFF1a1c1e),
    cardColor: Colors.grey.shade800,
    primaryColor: greyColor,
    primaryColorDark: darkBlueGreyColor,
    secondaryHeaderColor: const Color(0xFF2f3338),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Color(0xffFFFFFF)),
      centerTitle: false,
      backgroundColor: Color(0xFF2f3338),
    ),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Color(0xff37474F)),
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: Color(0xff37474F)),
    iconTheme: const IconThemeData(color: Color(0xffFFFFFF)),
    listTileTheme: const ListTileThemeData(iconColor: Colors.white),
    unselectedWidgetColor: Colors.white,
  );

  static final lightTheme = ThemeData(
    fontFamily: AssetConst.RALEWAY_FONT,
    brightness: Brightness.light,
    cardColor: greyColor,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: darkBlueGreyColor,

    visualDensity: VisualDensity.adaptivePlatformDensity,
    secondaryHeaderColor: Colors.white,
    primaryColorDark: darkBlueGreyColor,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Color(0xff192E51)),
        centerTitle: false,
        backgroundColor: Colors.white),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Color(0xffDEE4E7)),
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: Color(0xffDEE4E7)),
    iconTheme: const IconThemeData(color: Color(0xff222222)),
    // floatingActionButtonTheme: const FloatingActionButtonThemeData(
    //   backgroundColor: Colors.red,
    // ),
  );
}
