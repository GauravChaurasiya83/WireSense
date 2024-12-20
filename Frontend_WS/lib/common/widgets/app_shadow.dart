import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

BoxDecoration appBoxShadow(
    {Color color = AppColors.mainThemeColor,
      double radius = 15,
      double sR = 1,
      double bR = 2,
      BoxBorder? boxBorder}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: boxBorder,
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: sR,
            blurRadius: bR,
            offset: const Offset(0, 1))
      ]);
}


BoxDecoration appBoxDecoration(
    {Color color = AppColors.mainThemeColor,
    double radius = 15,
    double borderWidth = 1.5,
      Color borderColor = AppColors.dashBoardSecondaryTextColor}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor, width: borderWidth));
}

BoxDecoration appBoxDecorationWithGradient(
    {Color color = AppColors.mainThemeColor,
    double radius = 15,
    double borderWidth = 1.5,
      Color borderColor = AppColors.dashBoardSecondaryTextColor}) {
  return BoxDecoration(
      color: color,
     gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xff868CFF),
          color
        ],
      ),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor, width: borderWidth));
}

BoxDecoration appBoxShadowWithUnidirectionalRadius(
    {Color color = AppColors.mainThemeColor,
    double radius = 20,
    double sR = 1,
    double bR = 2}) {
  return BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(25),
      ),
      border: Border.all(color: Colors.grey.shade300, width: 1.h),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: sR,
          blurRadius: bR,
        )
      ]);
}
