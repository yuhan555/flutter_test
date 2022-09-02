import 'package:my_test/model/FieldModel.dart';

class PersonalField{
  FieldModel name = FieldModel();
  FieldModel mobile = FieldModel();
  FieldModel birth = FieldModel();
  FieldModel sex = FieldModel(prop: {});

  Personal type = Personal.def;

  PersonalField(Personal type){
    type = type;
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
  def,
}