part of 'color_match_bloc.dart';

abstract class ColorMatchEvent {}

class InitData extends ColorMatchEvent{}

class Rebuild extends ColorMatchEvent{}

class OnAccept extends ColorMatchEvent{}

class OnDragCancel extends ColorMatchEvent{}


