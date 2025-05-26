import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

late MediaQueryData _mediaQueryData;
late double screenWidth;
late double screenHeight;
late double fontSize;

class SizeConfig {
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    fontSize = screenWidth * 0.8;
  }
}