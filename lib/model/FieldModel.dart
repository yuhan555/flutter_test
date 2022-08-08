import 'package:flutter/material.dart';

class FieldModel extends TextEditingController{
  String errMsg = '';
  bool visible = true;
  bool disable = false;
  Map props = {};

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

  void reset(FieldModel field){
    field = FieldModel('');
  }
}

abstract class FieldRule{
  void pageLoading();
  void pageChange();
}

///要分頁各自class底下欄位 還是攤開不分頁的欄位 另外定義每頁下有的欄位陣列
///
/// 