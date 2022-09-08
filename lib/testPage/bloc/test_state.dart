part of 'test_bloc.dart';


abstract class TestState {}

class TestInitial extends TestState {}

class ActivePage extends TestState{
  BookMarkType? bookMark;
  ActivePage({this.bookMark});
}

class FieldChangeState extends TestState{}
