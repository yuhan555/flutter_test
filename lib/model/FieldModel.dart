import 'package:flutter/material.dart';

class FieldModel extends TextEditingController{
  String errMsg = '';
  bool visible = true;
  bool disable = false;
  Map? props = {};

  FieldModel(String val,{prop}){
    text = val;
    props = prop;
  }

  int getErrCount(){
    return errMsg.isNotEmpty ? 1 : 0;
  }

  void clearMsg(){
    errMsg = '';
  }
}