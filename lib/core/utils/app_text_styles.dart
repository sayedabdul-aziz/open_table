import 'package:flutter/material.dart';
import 'package:open_table/core/utils/colors.dart';

TextStyle getHeadlineStyle(
        {Color? color, double? fontSize, FontWeight? fontWeight}) =>
    TextStyle(
      fontSize: fontSize ?? 18,
      color: color ?? AppColors.bottomBarColor,
      fontWeight: fontWeight ?? FontWeight.bold,
    );

TextStyle getTitleStyle(
        {Color? color, double? fontSize, FontWeight? fontWeight}) =>
    TextStyle(
      fontSize: fontSize ?? 16,
      color: color ?? AppColors.bottomBarColor,
      fontWeight: fontWeight ?? FontWeight.bold,
    );

TextStyle getbodyStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
}) =>
    TextStyle(
      fontSize: fontSize ?? 14,
      color: color ?? AppColors.bottomBarColor,
      fontWeight: fontWeight ?? FontWeight.normal,
    );

TextStyle getsmallStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
}) =>
    TextStyle(
      fontSize: fontSize ?? 12,
      color: color ?? AppColors.shadeColor,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
