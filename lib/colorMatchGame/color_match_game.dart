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
    colorList = initColor(30);
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

  List<Color> initColor(int count){
    List<Color> list = [];
    int rColor = random.nextInt(100);
    int gColor = random.nextInt(100);
    int bColor = random.nextInt(100);
    var mColor = [rColor,gColor,bColor].reduce(min);
    var rGap = rColor - mColor;
    var gGap = gColor - mColor;
    var bGap = bColor - mColor;
    while(list.length < count){
      bool reset = rColor + 25 > 255 || gColor + 25 > 255 || bColor + 25 > 255;
      rColor = reset ?  rGap : rColor + 25;
      gColor = reset ?  gGap : gColor + 25;
      bColor = reset ?  bGap : bColor + 25;
      var o = random.nextDouble().toStringAsFixed(2).toDouble();
      var tempo = o < 0.3 ? 0.3 : o;
      Color tempCol = Color.fromRGBO(rColor, gColor, bColor, tempo);
      if(!list.contains(tempCol)){
        AppLog('$rColor/$gColor/$bColor/$tempo');
        list.add(tempCol);
      }
    }
    return list.shuffled();
  }
}
