import 'package:flutter/widgets.dart';

class SizeConfig {
  static final SizeConfig _instance = SizeConfig._internal();

  static const double _originalWidth = 392.7272;
  static const double _originalHeight = 781.0909;

  late double deviceWidth;
  late double deviceHeight;
  late double widthScale;
  late double heightScale;

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
