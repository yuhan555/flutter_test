import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:dartx/dartx.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test/base/BaseState.dart';
import 'package:my_test/colorMatchGame/model/color_ball_model.dart';

part 'color_match_event.dart';
part 'color_match_state.dart';

class ColorMatchBloc extends Bloc<ColorMatchEvent, ColorMatchState> {
  final Random random = Random();
  List<ColorBallModel> dragList = [];
  List<ColorBallModel> targetList = [];
  Level level = Level.easy;
  NumberMode numberMode = NumberMode.n24;
  late int scoreRange;
  int score = 0;
  bool disabledDrag = false;
  late int time;
  int match = 0; //答對個數


  ColorMatchBloc() : super(ColorMatchInitial()) {
    on<InitData>(_mapInitDataToState);
    on<Rebuild>((event,emit) => emit(RebuildState()));
    on<OnAccept>(_mapOnAcceptToState);
    on<OnDragCancel>(_mapOnDragCancelToState);
    on<Timeout>((event,emit) => emit(RestartState()));
    on<Bonus>(_mapBonusToState);
    on<Finish>((event, emit) => emit(RestartState(finish: true)));

  }





  void _mapInitDataToState(InitData event, Emitter emit){
    List<ColorBallModel> list = [];
    late int rColor;
    late int gColor;
    late int bColor;
    switch (level) {
      case Level.easy:
        while (list.length < numberMode.count) {
          rColor = random.nextInt(256);
          gColor = random.nextInt(256);
          bColor = random.nextInt(256);
          ColorBallModel model = ColorBallModel(color: Color.fromRGBO(rColor, gColor, bColor, 1));
          if (list.where((element) => element.color == model.color).isEmpty) {
            list.add(model);
          }
        }
        break;
      case Level.medium:
        List<int> cList = [
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256)
        ];
        int mainC = random.nextInt(3); //一個定色，兩個變動色
        while (list.length < numberMode.count) {
          var colors = List.generate(3, (index) => index == mainC ? cList[mainC] : random.nextInt(256));
          ColorBallModel model = ColorBallModel(color: Color.fromRGBO(colors[0], colors[1], colors[2], 1));
          if (list.where((element) => element.color == model.color).isEmpty) {
            list.add(model);
          }
        }
        break;
      case Level.hard:
        List<int> cList = [
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256)
        ];
        int transIndex = random.nextInt(3); //兩個定色，一個變動色
        int transInt = cList[transIndex];
        bool down = false;
        while (list.length < numberMode.count) {
          //以自身為基準點，往上往下取
          if (down) {
            transInt = transInt - 5;
          } else {
            transInt = transInt + 5;
            down = transInt > 255; //往上取超過255，改為往下取
            if(down){
              transInt = cList[transIndex];
              continue;
            }
          }
          // transInt = transInt + 5 > 256 ? 0 : transInt + 5; //256取48個，最多間距5 取的顏色少時 超過直接跳0 顏色會差距過大
          var colors = List.generate(3, (index) => index != transIndex ? cList[index] : transInt);
          ColorBallModel model = ColorBallModel(color: Color.fromRGBO(colors[0], colors[1], colors[2], 1));
          if (list.where((element) => element.color == model.color).isEmpty) {
            list.add(model);
          }
        }
        break;
    }
    dragList = list.toList().shuffled();
    targetList = list.map((e) => e.copyWith()).shuffled();
    disabledDrag = false;
    scoreRange = level.score;
    score = 0;
    match = 0;
    time = numberMode.seconds + level.timePlus;
    emit(InitSuccess());
  }

  void _mapOnAcceptToState(OnAccept event, Emitter emit) async{
    score += scoreRange;
    scoreRange += level.score;
    match += 1;
    emit(AcceptState());
  }

  void _mapOnDragCancelToState(OnDragCancel event, Emitter emit){
    scoreRange = level.score;
    emit(RebuildState());
  }

  void _mapBonusToState(Bonus event, Emitter emit){
    scoreRange = 100;
    score += 100;
    emit(BonusState());
  }




}

enum Level {
  easy(score: 1,timePlus: 0),
  medium(score: 2, timePlus: 30),
  hard(score: 3,timePlus: 60);

  final int score;
  final int timePlus;

  const Level({required this.score, required this.timePlus});
}

enum NumberMode {
  // horizontalCount預設以呈現三行color ball來算
  n24(horizontalCount: 8,count: 24, seconds: 60),
  n36(horizontalCount: 12,count: 36, seconds: 90),
  n48(horizontalCount: 16,count: 48, seconds: 120);

  final int horizontalCount;
  final int count;
  final int seconds;

  const NumberMode({required this.horizontalCount, required this.count,required this.seconds});
}


extension StrToLevelExt on String {
  // 將字串轉為等級enum
  Level get toLevel {
    return Level.values
        .firstWhere((elem) => elem.name == this, orElse: () => Level.easy);
  }

  // 將字串轉為數量enum
  NumberMode get toNumberMode {
    return NumberMode.values.firstWhere((element) => element.name == this,
        orElse: () => NumberMode.n24);
  }
}

