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

  ColorMatchBloc() : super(ColorMatchInitial()) {
    on<InitData>(_mapInitDataToState);
    on<Rebuild>((event, emit) => emit(RebuildState()));

  }

  final Random random = Random();
  List<ColorBallModel> dragList = [];
  List<ColorBallModel> targetList = [];
  Level level = Level.easy;
  NumberMode numberMode = NumberMode.n24;


  void _mapInitDataToState(InitData event, Emitter emit){
    List<ColorBallModel> list = [];
    late int rColor;
    late int gColor;
    late int bColor;
    switch (level) {
      case Level.easy:
        while (list.length < numberMode.getCount) {
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
        int mainC = random.nextInt(3); //一個主色，兩個變動色
        while (list.length < numberMode.getCount) {
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
        while (list.length < numberMode.getCount) {
          //以自身為基準點，往上往下取
          if (down) {
            transInt = transInt - 5;
          } else {
            transInt = transInt + 5;
            down = transInt > 255;
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
    emit(InitSuccess());
  }


}

enum Level { easy, medium, hard }

enum NumberMode { n24, n36, n48 }

extension NumberExt on NumberMode {
  // 預設以呈現三行color ball來算
  int get getHorizontalCount {
    switch (this) {
      case NumberMode.n24:
        return 8;
      case NumberMode.n36:
        return 12;
      case NumberMode.n48:
        return 16;
      default:
        return 6;
    }
  }

  int get getCount {
    switch (this) {
      case NumberMode.n24:
        return 24;
      case NumberMode.n36:
        return 36;
      case NumberMode.n48:
        return 48;
      default:
        return 0;
    }
  }
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

