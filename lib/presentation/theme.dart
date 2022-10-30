import 'package:datacoup/presentation/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    primaryColor: darkSkyBlueColor,
    primaryColorLight: mediumGreyColor,
    primaryColorDark: darkBlueGreyColor,
    highlightColor: whiteColor,
    cardColor: extraLightGreyColor,
    dividerColor: extraLightGreyColor,
    canvasColor: whiteColor,
    secondaryHeaderColor: darkBlueGreyColor,
    buttonTheme: const ButtonThemeData().copyWith(buttonColor: redOpacityColor),
    backgroundColor: lightBlueGreyColor,
    splashColor: mediumGreyColor,
    splashFactory: InkRipple.splashFactory,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: darkBlueGreyColor),
  );
  static final dark = ThemeData.dark().copyWith(
    primaryColor: lightBlueGreyColor,
    primaryColorLight: lightBlueGreyColor,
    primaryColorDark: lightBlueGreyColor,
    highlightColor: darkSkyBlueColor,
    dividerColor: extraLightBlackColor,
    cardColor: redOpacityColor,
    canvasColor: redOpacityColor,
    secondaryHeaderColor: darkSkyBlueColor,
    buttonTheme: const ButtonThemeData().copyWith(buttonColor: redOpacityColor),
    backgroundColor: lightBlackColor,
    splashColor: mediumBlueGreyColor,
    splashFactory: InkRipple.splashFactory,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
  );
}
