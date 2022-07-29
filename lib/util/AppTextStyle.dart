// william
import 'package:flutter/material.dart';

import 'package:my_test/util/AppColors.dart';


// ignore: must_be_immutable
class AppTextStyle extends TextStyle {
  Color color;
  FontWeight fontWeight;
  double fontSize;
  TextDecoration? decoration;

//  final String fontFamily;

  /* fontSize:字型大小 預設24
 * color:字型顏色 預設白色
 * fontWeight:字型粗細: 預設正常 w400
 * */
  AppTextStyle(
      {this.color = AppColors.white,
        this.fontWeight = FontWeight.normal,
        this.fontSize = 24,
        this.decoration
//      this.fontFamily = "PingFangTC-Regular"
      })
      : super(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
          decoration:decoration,

//          fontFamily: fontFamily,
        );

//  /* fontSize:字型大小 預設24
// * color:字型顏色 預設白色
// * fontWeight:字型粗細: 預設正常 w400
// * */
//  static TextStyle getRegular({double fontSize = 24, Color color = AppColors
//      .white, FontWeight fontWeight = FontWeight.normal}) {
//    String fontFamily = "PingFangTC-Regular";
//    return TextStyle(fontFamily: fontFamily,
//        fontSize: fontSize,
//        color: color,
//        fontWeight: fontWeight);
//  }
}
