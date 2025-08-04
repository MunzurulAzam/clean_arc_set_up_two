
import 'package:flutter/material.dart';

import '../../core/constants/colors/app_colors.dart';

// ignore: non_constant_identifier_names
Widget CircularProgress({double? height,double size = 20, Color? color, double width = 2, Alignment alignment=Alignment.center}) {
  return Container(
    height: height,
    alignment: alignment,
    child: SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
          strokeWidth: width,
          valueColor: AlwaysStoppedAnimation<Color>(
              color ?? AppColors.kPrimaryColor)),
    ),
  );
}
