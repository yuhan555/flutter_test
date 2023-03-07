import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:my_test/extension/WidgetExtension.dart';
import 'package:my_test/util/AppLog.dart';
import 'package:my_test/widgets/widgets.dart';

class ColorMatchGame extends StatefulWidget {
  const ColorMatchGame({Key? key}) : super(key: key);

  @override
  State<ColorMatchGame> createState() => _ColorMatchGameState();
}

class _ColorMatchGameState extends State<ColorMatchGame> {
  final Random random = Random();
  late List<Color> colorListA;
  late List<Color> colorListB;
  late Level level;
  late NumberMode numberMode;


  @override
  void initState(){
    level = Level.easy;
    numberMode = NumberMode.n24;
    initColor(level,numberMode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final cWidth = screenSize.width;
    final cHeight = screenSize.height;


    return Scaffold(
      body: Container(
          width: cWidth,
          height: cHeight,
          padding: const EdgeInsets.all(50),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RadioBox(
                        radioLabel:'Level',
                        opt: const [['Easy','easy'],['Medium','medium'],['Hard','hard']],
                        val: level.name,
                        optPressed: (v){
                          level = v.toString().toLevel;
                          setState(() {});
                        },
                      ).addBottomMargin(40),
                      RadioBox(
                        radioLabel:'Number of Colors',
                        opt: const [['24','n24'],['36','n36'],['48','n48']],
                        val: numberMode.name,
                        optPressed: (v){
                          numberMode = v.toString().toNumberMode;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: const [
                        Text('Time',style: TextStyle(fontSize: 30),textAlign:TextAlign.center,),
                        Text('00:30',style: TextStyle(fontFamily: 'Rajdhani',fontSize: 65),textAlign:TextAlign.center),
                        PrimaryButton(
                          label: 'Restart',
                        )
                      ],
                    )
                  )
                ],
              ),
              Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: numberMode.getWidth,
                          child: Wrap(
                            spacing: 15, // 主轴(水平)方向间距
                            runSpacing: 15, // 纵轴（垂直）方向间距
                            children: [
                              for(var c in colorListA)
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: c),
                                ),
                            ],
                          ),
                        ).addBottomMargin(60),
                        SizedBox(
                          width: numberMode.getWidth,
                          child: Wrap(
                            spacing: 15, // 主轴(水平)方向间距
                            runSpacing: 15, // 纵轴（垂直）方向间距
                            children: [
                              for(var c in colorListB)
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: c),
                                ),
                            ],
                          ),
                        )

                      ],
                    ),
                  )
              )
            ],
          )
      ),
    );
  }

  initColor(Level level,NumberMode numberMode){
    List<Color> list = [];
    late int rColor;
    late int gColor;
    late int bColor;
    switch(level){
      case Level.easy:
        while(list.length < numberMode.getCount){
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
        while(list.length < numberMode.getCount){
          var colors = List.generate(3, (index) => index == mainC ? cList[mainC] : random.nextInt(256));
          Color tempCol = Color.fromRGBO(colors[0], colors[1], colors[2], 1);
          if(!list.contains(tempCol)){
            // AppLog('${colors[0]}/${colors[1]}/${colors[2]}');
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
        while(list.length < numberMode.getCount){
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
    colorListA = list.shuffled();
    colorListB = list.shuffled();
  }
}


enum Level{
 easy, medium, hard
}

extension StrToLevelExt on String {
  // 將字串轉為等級enum
  Level get toLevel{
    return Level.values.firstWhere((elem) => elem.name == this, orElse: ()=> Level.easy);
  }
  // 將字串轉為數量enum
  NumberMode get toNumberMode{
    return NumberMode.values.firstWhere((element) => element.name == this,orElse: ()=> NumberMode.n24);
  }

}

enum NumberMode{
  n24,n36,n48
}

extension NumberExt on NumberMode{
  double get getWidth {
    switch (this) {
      case NumberMode.n24:
        return 650;
      case NumberMode.n36:
      case NumberMode.n48:
        return 650;
      default:
        return 350;
    }
  }

  int get getCount{
    switch(this){
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

