part of 'color_match_bloc.dart';

abstract class ColorMatchState {}

class ColorMatchInitial extends ColorMatchState {}

class InitSuccess extends ColorMatchState {}

class RebuildState extends ColorMatchState {}

class AcceptState extends ColorMatchState {}

class BonusState extends ColorMatchState {}

class RestartState extends ColorMatchState {
  bool finish;
  RestartState({this.finish = false});
}


