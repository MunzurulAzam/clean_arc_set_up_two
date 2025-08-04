import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
    orientation = _mediaQueryData.orientation;
  }

  static bool isMobile() => SizeConfig.screenWidth < 768;

  static bool isTablet() => SizeConfig.screenWidth < 1366 && SizeConfig.screenWidth >= 768;

  static bool isDesktop() => SizeConfig.screenWidth >= 1366;

  // Scale size proportionally to the screen width, using 375.0 as the reference width (iPhone 8).
  static double scaleSize(double inputSize) {
    double screenWidth = SizeConfig.screenWidth;
    return (inputSize / 375.0) * screenWidth;
  }
}

//------------------------------------------------------------ Get the proportionate height as per screen size
double getScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;

  // Scale based on a reference height (e.g., 812.0 for iPhone 8)
  return (inputHeight / 812.0) * screenHeight;
}

//-------------------------------------------------------------- Get the proportionate width as per screen size
double getScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;

  // Scale based on a reference width (e.g., 375.0 for iPhone 8)
  return (inputWidth / 375.0) * screenWidth;
}

//----------------------------------------------------------- Font size scaling according to screen width
double getFontSize(double inputFontSize) {
  // Scale the font size based on the screen width
  return (inputFontSize / 375.0) * SizeConfig.screenWidth;
}

//--------------------------------------------------- Get the appropriate border radius as per screen size
double getBorderRadius(double inputRadius) {
  double screenWidth = SizeConfig.screenWidth;
  return (inputRadius / 375.0) * screenWidth;
}

//---------------------------------------------- For vertical space
Widget getVerticalSpace(double inputSpace) {
   return SizedBox(
    height: getScreenHeight(inputSpace), // Use scaled height
  );
}

//---------------------------------------------- For horizontal space
Widget getHorizontalSpace(double inputSpace) {
  return SizedBox(
    width: getScreenWidth(inputSpace), // Use scaled width
  );
}
