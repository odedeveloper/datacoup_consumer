import 'package:flutter/widgets.dart';

class SizeConfig {
  static final SizeConfig _instance = SizeConfig._internal();

  static const double _originalWidth = 392.7272;
  static const double _originalHeight = 781.0909;

  double deviceWidth = 0.0;
  double deviceHeight = 0.0;
  double widthScale = 0.0;
  double heightScale = 0.0;

  factory SizeConfig() {
    return _instance;
  }

  SizeConfig._internal();

  void init(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    widthScale = deviceWidth / _originalWidth;
    deviceHeight = MediaQuery.of(context).size.height;
    heightScale = deviceHeight / _originalHeight;
  }
}
