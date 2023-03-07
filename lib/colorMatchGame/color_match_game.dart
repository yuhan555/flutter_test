import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:my_test/util/AppLog.dart';

class ColorMatchGame extends StatefulWidget {
  const ColorMatchGame({Key? key}) : super(key: key);

  @override
  State<ColorMatchGame> createState() => _ColorMatchGameState();
}

class _ColorMatchGameState extends State<ColorMatchGame> {
  final Random random = Random();
  late List<Color> colorList;

  @override
  void initState(){
    colorList = initColor(Level.hard,24).shuffled();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SizedBox(
          width: 350,
          child: Wrap(
            spacing: 20, // 主轴(水平)方向间距
            runSpacing: 20, // 纵轴（垂直）方向间距
            children: [
              for(var c in colorList)
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: c),
                ),
            ],
          ),
        )
      )
    );
  }

  List<Color> initColor(Level level,int count){
    List<Color> list = [];
    late int rColor;
    late int gColor;
    late int bColor;
    switch(level){
      case Level.easy:
        while(list.length < count){
          rColor = random.nextInt(256);
          gColor = random.nextInt(256);
          bColor = random.nextInt(256);
          Color tempCol = Color.fromRGBO(rColor, gColor, bColor, 1);
          if(!list.contains(tempCol)){
            list.add(tempCol);
          }
        }
        break;
      case Level.medium:
        List<int> cList = [random.nextInt(256),random.nextInt(256),random.nextInt(256)];
        int mainC = random.nextInt(3);
        while(list.length < count){
          var colors = List.generate(3, (index) => index == mainC ? cList[mainC] : random.nextInt(256));
          Color tempCol = Color.fromRGBO(colors[0], colors[1], colors[2], 1);
          if(!list.contains(tempCol)){
            AppLog('${colors[0]}/${colors[1]}/${colors[2]}');
            list.add(tempCol);
          }
        }
        break;
      case Level.hard:
        rColor = random.nextInt(100);
        gColor = random.nextInt(100);
        bColor = random.nextInt(100);
        var mColor = [rColor,gColor,bColor].reduce(min);
        var rGap = rColor - mColor;
        var gGap = gColor - mColor;
        var bGap = bColor - mColor;
        while(list.length < count){
          bool reset = rColor + 25 > 255 || gColor + 25 > 255 || bColor + 25 > 255;
          rColor = reset ? rGap : rColor + 25;
          gColor = reset ? gGap : gColor + 25;
          bColor = reset ? bGap : bColor + 25;
          var o = random.nextDouble().toStringAsFixed(2).toDouble();
          var tempo = o < 0.3 ? 0.3 : o;
          Color tempCol = Color.fromRGBO(rColor, gColor, bColor, tempo);
          if(!list.contains(tempCol)){
            // AppLog('$rColor/$gColor/$bColor/$tempo');
            list.add(tempCol);
          }
        }
    }
    return list;
  }
}


enum Level{
 easy, medium, hard
}

