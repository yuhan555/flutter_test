
import 'package:my_test/extension/CommonExtension.dart';
import 'package:intl/intl.dart' as intl;

class CheckId {
  final String id; //身分證字號 or 登錄證字號
  final List type; // 欲驗證的類型 ex:['TWN', 'foreigner'];

  CheckId(this.id, this.type);

  /// 驗證身分證字號
  /// @return {boolean} true-驗證結果正確, false-驗證結果錯誤
  bool checkTWN() {
    String alph = 'ABCDEFGHJKLMNPQRSTUVXYWZIO';
    List num = [
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29',
      '30',
      '31',
      '32',
      '33',
      '34',
      '35'
    ];
    var myid = id.toUpperCase();
    var total2 = 0;
    RegExp reg = RegExp(r'^[A-Z][1-2][0-9]{8}$');
    if (reg.hasMatch(myid)) {
      //驗證本國人
      var numstr = num[alph.indexOf(myid[0])];
      var total1 =
          int.parse(numstr[0]) + int.parse(numstr[1]) * 9;
      for (var i = 1; i < 9; i++) {
        total2 += int.parse(myid[i]) * (9 - i);
      }
      if ((total1 + total2 + int.parse(myid[9])) % 10 != 0) {
        return (false);
      } else {
        return (true);
      }
    } else {
      return (false);
    }
  }

  /// 驗證居留證號碼
  /// @return {boolean} true-驗證結果正確, false-驗證結果錯誤
  bool checkForeigner() {
    var alph = 'ABCDEFGHJKLMNPQRSTUVXYWZIO';
    List num = [
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29',
      '30',
      '31',
      '32',
      '33',
      '34',
      '35'
    ];
    var myid = id.toUpperCase();
    var total1 = 0;
    var total2 = 0;
    RegExp reg = RegExp(r'^[A-Z][A-D][0-9]{8}$');
    RegExp newReg = RegExp(r'^[A-Z][8-9][0-9]{8}$'); //110年新制
    if (reg.hasMatch(myid)) {
  //驗證外國人
      var numstr1 = num[alph.indexOf(myid[0])];
      var numstr2 = num[alph.indexOf(myid[1])];
      total1 += int.parse(numstr1[0]) + ((int.parse(numstr1[1]) * 9) % 10);
      total1 += int.parse(numstr2[1]) * 8 % 10;
      for (var i = 2; i < 9; i++) {
        total2 += int.parse(myid[i]) * (9 - i) % 10;
      }
      if ((total1 + total2 + int.parse(myid[9])) % 10 != 0) {
        return (false);
      } else {
        return (true);
      }
    }
    else if(newReg.hasMatch(myid)){
      var numstr1 = num[alph.indexOf(myid[0])];
      var numstr2 = myid[1];
      total1 += int.parse(numstr1[0]) + ((int.parse(numstr1[1]) * 9) % 10);
      total1 += int.parse(numstr2) * 8 % 10;
      for (var i = 2; i < 9; i++) {
        total2 += int.parse(myid[i]) * (9 - i) % 10;
      }
      if ((total1 + total2 + int.parse(myid[9])) % 10 != 0) {
        return (false);
      } else {
        return (true);
      }
    }
    else {
      return (false);
    }
  }

  /// 驗證統一編號
  /// @return {boolean} true-驗證結果正確, false-驗證結果錯誤
  bool checkUniformNumber() {
    var myid = id.toUpperCase();
    RegExp reg = RegExp(r'^[0-9]{8}$');
    if (reg.hasMatch(myid)) {
  //驗證統一編號
      var pa = [1, 2, 1, 2, 1, 2, 4, 1];
      var nSum = 0;
      for (var i = 0; i < myid.length; i++) {
        var tp = int.parse(myid.substring(i, i+1)) * pa[i];
        nSum += (tp/10).floor() + tp % 10;
      }
      return (nSum % 10 == 0) || (nSum % 10 == 9 && myid.substring(6, 7) == "7");
    } else {
      return (false);
    }
  }

  /// 驗證法人無統編
  /// @return {boolean} true-驗證結果正確, false-驗證結果錯誤
  bool checkLegalPerson() {
    var myid = id.toUpperCase();
    if(myid.length>1 &&(myid.substring(0,2)=='*D' || myid.substring(0,2)=='*F')){
      return (true);
    } else {
      return (false);
    }
  }


  bool check(){
    bool result = false;
    Map funMap = {
      'TWN': checkTWN,
      'foreigner': checkForeigner,
      'uniform': checkUniformNumber,
      'LegalPerson': checkLegalPerson,
    };
    type.forEach((e) {
      if(!funMap.containsKey(e)) return;
      result = result||funMap[e].call();
    });
    return result;
  }
}

class RuleUtil{

  ///檢核輸入之民國日期是否正確
  static bool checkDateFormat(date) {
    if (date.isEmpty) {
      return true;
    }
    var isDateFormat = false;
    date += '';
    date = date.replaceAll(RegExp(r"[\/]"), '');
    RegExp correctDate = RegExp(r'^[0-9]{6,7}$');
    if (correctDate.hasMatch(date)) {
      //print(date);
      num intTmp = 0;
      intTmp = 7 - date.length;
      var intYear = int.parse(date.substring(0, 3 - intTmp), radix: 10);
      var intMonth = int.parse(date.substring(3 - intTmp, 5 - intTmp), radix: 10);
      var intDay = int.parse(date.substring(5 - intTmp, 7 - intTmp), radix: 10);
      if (intYear > 0 && intMonth > 0 && intMonth <= 12 && intDay > 0) {
        var tmpDate = DateTime(intYear + 1911, intMonth + 1, 0);
        isDateFormat = intDay <= tmpDate.day;
      }
    }
    return isDateFormat;
  }

  ///檢核輸入之西元日期是否正確
  static bool checkDateFormatAD(date) {
    if(date==null) return false;
    if (date.isEmpty) {
      return true;
    }
    var isDateFormat = false;
    date += '';
    date = date.replaceAll(RegExp(r'[/-]'),'');
    RegExp correctDate = RegExp(r'^[0-9]{8}$');
    if (correctDate.hasMatch(date)) {
      //print(date);
      num intTmp = 0;
      intTmp = 8 - date.length;
      var intYear = int.parse(date.substring(0, 4 - intTmp), radix: 10);
      var intMonth = int.parse(date.substring(4 - intTmp, 6 - intTmp), radix: 10);
      var intDay = int.parse(date.substring(6 - intTmp, 8 - intTmp), radix: 10);
      if (intMonth > 0 && intMonth <= 12 && intDay > 0) {
        var tmpDate = DateTime(intYear, intMonth + 1, 0);
        isDateFormat = intDay <= tmpDate.day;
      }
    }
    return isDateFormat;
  }

  ///檢核輸入之西元日期是否正確(年/月)
  static bool checkDateMonthFormatVid(date) {
    if (date.isEmpty) {
      return true;
    }
    var isDateFormat = false;
    date += '';
    date = date.replaceAll(RegExp(r'[/-]'),'');
    RegExp correctDate = RegExp(r'^[0-9]{6}$');
    if (correctDate.hasMatch(date)) {
      var intMonth = int.parse(date.substring(4, 6), radix: 10);
      if (intMonth > 0 && intMonth <= 12) {
        isDateFormat = true;
      }
    }
    return isDateFormat;
  }

  ///將西元日期字串轉為日期物件
  static DateTime transDateADStrToDateObj(String dateStr) {
    String dateVal = dateStr.replaceAll('/', '');
    return DateTime(int.parse(dateVal.substring(0, 4), radix: 10),int.parse(dateVal.substring(4, 6), radix: 10),int.parse(dateVal.substring(6, 8), radix: 10));
  }

  ///將民國日期字串轉為日期物件
  static DateTime transDateStrToDateObj(String dateStr) {
    String dateVal = dateStr.replaceAll('/', '');
    var intTmp = 7 - dateVal.length;
    return DateTime(int.parse(dateVal.substring(0, 3 - intTmp), radix: 10) + 1911,int.parse(dateVal.substring(3 - intTmp, 5 - intTmp), radix: 10),int.parse(dateVal.substring(5 - intTmp, 7 - intTmp), radix: 10));
  }

  ///將日期物件轉為民國日期字串
  static String transDateObjToDateStr(DateTime date) {
    return '${(date.year-1911).toString().padLeft(3,'0')}/${date.month.toString().padLeft(2,'0')}/${date.day.toString().padLeft(2,'0')}';
  }

  ///返回指定日期加 N 年
  static DateTime dateTimePlusYears(DateTime date ,int years){
    DateTime newDate = DateTime(date.year+years, date.month, date.day);
    if(date.day!=newDate.day){
      newDate = newDate.subtract(Duration(days:1));
    }
    return newDate;
  }

  ///返回指定日期加 N 月
  static DateTime dateTimePlusMonths(DateTime date ,int months){
    DateTime newDate = DateTime(date.year, date.month+months, date.day);
    if(date.day!=newDate.day){
      date = date.subtract(Duration(days:1));
      newDate = dateTimePlusMonths(date,months);
    }
    return newDate;
  }

  ///返回指定日期加 N 天
  static DateTime dateTimePlusDays(DateTime date ,int days){
    DateTime newDate = date.add(Duration(days: days));
    return newDate;
  }

  ///返回指定時間加 N 小時
  static DateTime dateTimePlusHours(DateTime date ,int hours){
    DateTime newTime = date.add(Duration(hours: hours));
    return newTime;
  }

  ///計算指定時間相差天數
  static int calculateDays(DateTime startDate ,DateTime endDate){
    int days = startDate.difference(endDate).inDays;
    return days;
  }

  ///返回指定日期相差月數
  static int dateTimeDifferenceMonths(DateTime date1 ,DateTime date2){
    DateTime d1;
    DateTime d2;
    if(date1.isBefore(date2)){
      d1 = date1;
      d2 = date2;
    }else{
      d1 = date2;
      d2 = date1;
    }
    int count = 1;
    while(dateTimePlusMonths(d1,count).isBefore(d2)||dateTimePlusMonths(d1,count).isAtSameMomentAs(d2)){
      count++;
    }
    return count-1;
  }

  static bool checkEmail(String email){
    RegExp reg = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return email != null && reg.hasMatch(email);
  }


  /*
   *計算保險年齡(與date2比)
   * @param date 生日
   * @param date2 今日或保險起日
   * @param m 控制實際年齡(0)或保險年齡(6)
   */
  static String calculateAge(String date, String date2, int m) {

    date2 = date2.replaceAll(RegExp(r"[\/]"), '');
    int year2 = int.parse(date2.substring(0, 3)) + 1911;
    int month2 = int.parse(date2.substring(3, 5));
    int day2 = int.parse(date2.substring(5));

    List myBirth = date.split('/');
    int myYear = int.parse(myBirth[0]) + 1911;
    int myMonth = int.parse(myBirth[1]);
    int myDay = int.parse(myBirth[2]);

    var d2 = DateTime(year2, month2 + m , day2); // +6個月

    year2 = d2.year;
    month2 = d2.month ;
    day2 = d2.day;

    // 以下年齡計算
    int age =year2 - myYear ;
    if(month2 - myMonth <0){
      age = age -1 ;
    }else if(month2 - myMonth == 0){
      if(day2 - myDay <0){
        age = age -1 ;
      }
    }
    return age.toString();
  }


  //弱點偵測檢查輸入文字(要保書規則用)
  static List checkInsInjection(Map pageFieldState,String page,List fieldNameList,List<String> injectionType){
    fieldNameList.forEach((fieldName) {
      Map a1State = pageFieldState[page][fieldName];
      String a1Text = a1State['controller'].text;
      if (a1Text.checkInjection(injectionType)) {
        a1State['errMsg'] = '不可含有不合法字元';
      }
    });
    return fieldNameList;
  }
}
