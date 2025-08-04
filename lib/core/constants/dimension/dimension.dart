
import 'package:flutter/material.dart';

class Dimension{
  static FontWeight textRegular=FontWeight.w400;
  static FontWeight textMedium=FontWeight.w500;
  static FontWeight textSemiMedium=FontWeight.w600;
  static FontWeight textBold=FontWeight.w700;

    // Get the status bar height using MediaQuery
  static double paddingTop(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }
  // static double get paddingBottom=>MediaQuery.of(appContext).padding.bottom;
  // static double get screenRatio=>appSize().width/AppConstant.defaultScreenSize.width;
  // static double get appbarHeight => DefaultAppbar(title: '').preferredSize.height;
  // static Widget get bottomSpace => (paddingBottom+16.h).verticalSpace;
}