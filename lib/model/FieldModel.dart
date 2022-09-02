import 'package:flutter/material.dart';

class FieldModel extends TextEditingController{
  String errMsg = '';
  bool visible = true;
  bool disable = false;
  Map? props = {};

  FieldModel({prop}){
    text = '';
    props = prop;
  }

  set setVal(String val) => text = val;

  String get getVal => text;

  set hide(_) => visible = false;

  set show(_) => visible = true;

  set enabled(_) => disable = false;

  set disabled(_) => disabled = true;

  int getErrCount(){
    return errMsg.isNotEmpty ? 1 : 0;
  }

  void clearMsg(){
    errMsg = '';
  }
}