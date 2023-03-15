part of 'color_match_bloc.dart';

abstract class ColorMatchEvent {}

class InitData extends ColorMatchEvent{}

class Rebuild extends ColorMatchEvent{
  bool finish;
  Rebuild({this.finish = false});
}

class OnAccept extends ColorMatchEvent{}

class OnDragCancel extends ColorMatchEvent{}

class Timeout extends ColorMatchEvent{}

class Bonus extends ColorMatchEvent{}

class Finish extends ColorMatchEvent{}



