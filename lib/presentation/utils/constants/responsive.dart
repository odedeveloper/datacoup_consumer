import 'package:datacoup/presentation/utils/constants/image.dart';
import 'package:flutter/material.dart';

const kBorderRadius = 10.0;

double? height(BuildContext context) {
  double? size = MediaQuery.of(context).size.height;
  return size;
}

double? width(BuildContext context) {
  double? size = MediaQuery.of(context).size.width;
  return size;
}

double? fontSize(BuildContext context) {
  // final scale = MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.3);
  double? size = MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0);
  return size;
}

double? kminiFont(BuildContext context) {
  double? size = fontSize(context)! * 12;
  return size;
}

double? ksmallFont(BuildContext context) {
  double? size = fontSize(context)! * 14;
  return size;
}

double? kmediumFont(BuildContext context) {
  double? size = fontSize(context)! * 16;
  return size;
}

double? klargeFont(BuildContext context) {
  double? size = fontSize(context)! * 18;
  return size;
}

double? kextraLargeFont(BuildContext context) {
  double? size = fontSize(context)! * 20;
  return size;
}

double? kmaxExtraLargeFont(BuildContext context) {
  double? size = fontSize(context)! * 22;
  return size;
}

themeTextStyle(
        {context,
        double? fsize,
        FontWeight? fweight,
        String? fontFamily,
        FontStyle? fontStyle,
        double? letterSpacing,
        Color? tColor,
        TextOverflow? ovrflow = TextOverflow.ellipsis}) =>
    TextStyle(
      color: tColor ?? Theme.of(context).primaryColor,
      fontSize:
          fsize != null ? fontSize(context)! * fsize : kmediumFont(context),
      fontStyle: fontStyle,
      fontWeight: fweight,
      fontFamily: fontFamily ?? AssetConst.ralewayFont,
      letterSpacing: letterSpacing,
    );
