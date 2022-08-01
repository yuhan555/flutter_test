part of 'test_bloc.dart';


abstract class TestEvent {}

class InitData extends TestEvent{}

class ClickPage extends TestEvent{
  BookMarkType? bookMark;
  bool? clickNext;
  ClickPage({this.bookMark,this.clickNext = false});
}
