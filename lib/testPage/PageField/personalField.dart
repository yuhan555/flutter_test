import 'package:my_test/model/FieldModel.dart';

class PersonalField{
  //要保人
  FieldModel name = FieldModel('');
  FieldModel mobile = FieldModel('');
  FieldModel birth = FieldModel('');
  FieldModel sex = FieldModel('',prop: {});

  static Personal _type = Personal.owner;

  static Personal get type => _type;

  static set setType(Personal value) {
    _type = value;
  }

  PersonalField(Personal type){
    setType = type;
  }


  void clearPage(){
    for (var element in [name,mobile,birth,sex]) {
      element..clear()..clearMsg();
    }
  }

  int getErrCount(){
    int i = 0;
    for (var field in [name,mobile,birth,sex]) {
      i += field.getErrCount();
    }
    return i;
  }


}

enum Personal{
  owner,
  policy,
}