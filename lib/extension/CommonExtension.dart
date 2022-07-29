
import 'dart:convert';

import "package:intl/intl.dart";


extension ecString on String {
  String toTWY({String rStr = '/',String fStr = '/'}){
    if(this == null || this.isEmpty) return '';
    var s = this.replaceAll(rStr, '');
    if(s.length == 7){
      return '${ int.parse(s.substring(0,3))}$fStr${s.substring(3,5)}$fStr${s.substring(5,7)}';
    }else{
     return '${ int.parse(s.substring(0,4)) -1911}$fStr${s.substring(4,6)}$fStr${s.substring(6,8)}';
    }
  }
  String toAD({String rStr = '/',String fStr = '/'}){
    if(this == null || this.isEmpty) return '';
    var s = this.replaceAll(rStr, '').padLeft(7,'0');
    return '${ int.parse(s.substring(0,3)) + 1911}$fStr${s.substring(3,5)}$fStr${s.substring(5,7)}';
  }

  String hideId(){
    if(this == null || this.isEmpty) return '';
    int sDive = 3;//(s.length / 3).floor();
    if(this.length == 10){
      return '${this.substring(0,sDive)}${''.padLeft((this.length - sDive *2),'*')}${this.substring(this.length-sDive)}';
    }else{
      return this;
    }
  }

  String hideName(){
    if(this == null || this.isEmpty) return '';
    return '${this.substring(0,1)}${''.padLeft((this.length - 1),'*')}';
  }

  String hideNamePOP(){
    if(this == null || this.isEmpty) return '';
    return '${this.substring(0,1)}${''.padLeft((this.length - 2),'*')}${ this.length==1?'':this.length==2?'*':this.substring(this.length-1)}';
  }

  String hideEngine(){
    if(this == null || this.isEmpty) return '';
    if( this.length < 7){
      return this;
    }
    return '${this.substring(0,4)}${''.padLeft(3,'*')}${this.substring(7)}';
  }

  String hideCarNo(){
    if(this == null || this.isEmpty) return '';
    var s =this;
    if(s == null || s.length < 7){
      return this;
    }

    if(s.indexOf('-') >-1){
      var sa = s.split('-');
      return '${sa[0]}-${sa[1].length <4?(''.padLeft(sa[1].length,'*')):(''.padLeft(3,'*')+sa[1].substring(3))}';
    }else{
      return this;
    }
  }

  String hideBirth(){
    if(this == null || this.isEmpty) return '';
    var s =this;
    if(s.indexOf('/') >-1){
      var sa = s.split('/');
      return '${sa[0]}/**/**';
    }else{
      return this;
    }
  }

  String hideCreditCard(){
    if(this == null || this.isEmpty) return '';
    var head = this.substring(0,4);
    var end = this.substring(this.length - 4, this.length);
    var star = '********';
    var putOut = head+star+end ;
    return '${putOut}' ;
  }

  //判斷是否為數字
  bool get isNumeric {
    if(this == null) {
      return false;
    }
    return double.tryParse(this) != null;
  }

  String defaultEmpty(String v){
     return (this ==null || this.isEmpty)?v:this;
  }

  bool checkInjection(List<String> items){
    //sql injection
    if(items.contains('S')){
      if(this.toUpperCase().indexOf('OR') > -1 && this.indexOf('=') > 0) return true;
    }
    //javascript injection
    if(items.contains('J')){
      if(this.toUpperCase().indexOf('SCRIPT') > -1) return true;
    }
    //command injection
    if(items.contains('C')){
      if(this.toUpperCase().indexOf('|REBOOT') > -1) return true;
    }
    //file injection
    if(items.contains('L')){
      if(this.indexOf('/') > -1 || this.indexOf('\\') > -1) return true;
    }
    //xml injection
    if(items.contains('X')){
      if(this.indexOf('<') > -1 || this.indexOf('>') > -1) return true;
    }
    //xml injection
    if(items.contains('F')){
      if(this.toUpperCase().indexOf('%N') > -1 ||
          this.toUpperCase().indexOf('%P') > -1 ||
          this.toUpperCase().indexOf('%C') > -1 ||
          this.toUpperCase().indexOf('%S') > -1 ||
          this.toUpperCase().indexOf('%D') > -1 ||
          this.indexOf('"') > -1 || this.indexOf("'") > -1) return true;
    }
    return false;
  }

  //字串(去除/,)轉為數字
  double? get stringToDouble {
    String str = this.replaceAll(RegExp(r"[\/,]"), "");
    if(str.isNumeric) {
      return double.parse(str);
    }
    return null;
  }

  ///字串轉base64
  String get convertToBase64 {
    if(this == null || this.isEmpty) {
      return this;
    }
    return base64.encode(utf8.encode(this));
  }

}

extension ecDateTime on DateTime {

  String toTWY({String fStr = ''}){
    return '${this.year-1911}$fStr${this.month.toString().padLeft(2,'0')}$fStr${this.day.toString().padLeft(2,'0')}'.padLeft(7,'0');
  }
  String toAD({String fStr = ''}){
    return '${this.year}$fStr${this.month.toString().padLeft(2,'0')}$fStr${this.day.toString().padLeft(2,'0')}';
  }

  String toTimeStr({String fStr = ''}){
    return '${this.hour.toString().padLeft(2,'0')}$fStr${this.minute.toString().padLeft(2,'0')}$fStr${this.second.toString().padLeft(2,'0')}';
  }

  bool isInMonths(DateTime sd,int months){
    var addMonthDate  = DateTime(sd.year,(sd.month +months),sd.day);
    // if(this.day != addMonthDate.day){
    //   addMonthDate  = DateTime(sd.year,(sd.month +months-1),0);
    // }
    return  !(int.parse(this.toAD()) <= int.parse(addMonthDate.toAD()));
    // return !this.isBefore(addMonthDate);
  }

}

extension ecInt on int {

  String toThousand(){
    if (this.toString().length < 3 )
    {
      return this.toString();
    }
    return NumberFormat(',000').format(this);

  }

}

extension ecDouble on double
{
  String convertNumToChinese() {
    double num = this;
    final List<String> CN_UPPER_NUMBER = [
      "零",
      "壹",
      "貳",
      "參",
      "肆",
      "伍",
      "陸",
      "柒",
      "捌",
      "玖"
    ];
    final List<String> CN_UPPER_MONETRAY_UNIT = [
      "分",
      "角",
      "元",
      "拾",
      "佰",
      "仟",
      "萬",
      "拾",
      "佰",
      "仟",
      "億",
      "拾",
      "佰",
      "仟",
      "兆",
      "拾",
      "佰",
      "仟"
    ];
    final String CN_FULL = "整";
    final String CN_NEGATIVE = "負";
    final String CN_ZEOR_FULL = "零元" + CN_FULL;
    double sign = num.sign;
    if (sign == num) {
      return CN_ZEOR_FULL;
    }
    if (num.toStringAsFixed(0).length > 15) {
      return '超出最大限額';
    }
    num = num * 100;
    int tempValue = int.parse(num.toStringAsFixed(0)).abs();

    int p = 10;
    int i = -1;
    String CN_UP = '';
    bool lastZero = false;
    bool finish = false;
    bool tag = false;
    bool tag2 = false;
    while (!finish) {
      if (tempValue == 0) {
        break;
      }
      int positionNum = tempValue % p;
      double n = (tempValue - positionNum) / 10;
      tempValue = int.parse(n.toStringAsFixed(0));
      String tempChinese = '';
      i++;
      if (positionNum == 0) {
        if (CN_UPPER_MONETRAY_UNIT[i] == "萬" ||
            CN_UPPER_MONETRAY_UNIT[i] == "億" ||
            CN_UPPER_MONETRAY_UNIT[i] == "兆" ||
            CN_UPPER_MONETRAY_UNIT[i] == "元") {
          if (lastZero && tag2) {
            CN_UP = CN_UPPER_NUMBER[0] + CN_UP;
          }
          CN_UP = CN_UPPER_MONETRAY_UNIT[i] + CN_UP;
          lastZero = false;
          tag = true;
          continue;
        }
        if (!lastZero) {
          lastZero = true;
        } else {
          continue;
        }
      } else {
        if (lastZero && !tag && tag2) {
          CN_UP = CN_UPPER_NUMBER[0] + CN_UP;
        }
        tag = false;
        tag2 = true;
        lastZero = false;
        tempChinese = CN_UPPER_NUMBER[positionNum] + CN_UPPER_MONETRAY_UNIT[i];
      }
      CN_UP = tempChinese + CN_UP;
    }
    if (sign < 0) {
      CN_UP = CN_NEGATIVE + CN_UP;
    }
    // return CN_UP;
    //尾數加整
    return CN_UP + CN_FULL;
  }
}

extension MapExtension on Map {
  ///過濾Map屬性
  Map where(List<String> keys) {
    var _keys = this.keys.where((element) => keys.contains(element));
    var _result = Map();
    _keys.forEach((key) {
      if(this[key] != null){
        _result[key] = this[key];
      }
    });
    return _result;
  }

  ///過濾Map屬性並將屬性合併成Map
  Map whereAndMerge(List<String> keys) {
    var _keys = this.keys.where((element) => keys.contains(element));
    var _result = Map();
    _keys.forEach((key) {
      if(this[key] != null){
        _result.addAll(this[key]);
      }
    });
    return _result;
  }
}