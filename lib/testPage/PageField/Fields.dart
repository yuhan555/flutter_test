import 'package:my_test/model/FieldModel.dart';
import 'package:my_test/testPage/HomePage.dart';

class Fields{
  //被保人
  FieldModel iName = FieldModel('');
  FieldModel iMobile = FieldModel('');
  FieldModel iBirth = FieldModel('');
  FieldModel iSex = FieldModel('', prop:{});
  //要保人
  FieldModel oName = FieldModel('');
  FieldModel oMobile = FieldModel('');
  FieldModel oBirth = FieldModel('');
  FieldModel oSex = FieldModel('',prop: {});


  List<FieldModel> getPageField(BookMarkType page){
    switch(page){
      case BookMarkType.InsuredOwner:
        return [iName,iMobile,iBirth];
      case BookMarkType.PolicyHolder:
        return [oName,oMobile,oBirth];
      default:
        return [];
    }
  }

  void clearPage(BookMarkType page){
    getPageField(page).forEach((field) {
      field..clear()..clearMsg();
    });
  }

  int getErrCount(BookMarkType page){
    int i = 0;
    getPageField(page).forEach((field) {
      i += field.getErrCount();
    });
    return i;
  }

  setProp(FieldModel field, String attr, dynamic prop){
    field.props[attr] = prop;
  }

}