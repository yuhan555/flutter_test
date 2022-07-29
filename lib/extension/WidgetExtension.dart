import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  addContainer(
      {AlignmentGeometry? alignment,
        EdgeInsetsGeometry padding = EdgeInsets.zero,
        EdgeInsetsGeometry margin = EdgeInsets.zero,
        Decoration? decoration,
        double? width,
        double? height,
        Color? color}) {
    return Container(
      alignment: alignment,
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      color: color,
      decoration: decoration,
      child: this,
    );
  }
  
  addBottomMargin({
    double bottom = 0,
}){
    return Container(margin: EdgeInsets.only(bottom: bottom),child:this);
    
  }
}