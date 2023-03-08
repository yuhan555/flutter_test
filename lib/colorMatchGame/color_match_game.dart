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
    numberMode = NumberMode.n48;
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
          padding: const EdgeInsets.all(40),
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
                        labelSize: 20,
                        opt: const [['Easy','easy'],['Medium','medium'],['Hard','hard']],
                        val: level.name,
                        optPressed: (v){
                          level = v.toString().toLevel;
                          setState(() {});
                        },
                      ).addBottomMargin(20),
                      RadioBox(
                        radioLabel:'Number of Colors',
                        labelSize: 20,
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
                flex: 2,
                  child: Column(
                    children: [
                      Expanded(child: getList(colorListA)),
                      Expanded(child: getList(colorListB)),
                    ],
                  ),
              )
            ],
          )
      ),
    );
  }

  Widget getList(List<Color> colors){
    List<Widget> colList = [];
    for(var i = 0; i <= colors.length; i = i+numberMode.getHorizontalCount){
      List<Widget> rowList = [];
      if(i+numberMode.getHorizontalCount > colors.length) break;
      List<Color> rowCount = colors.getRange(i, i+numberMode.getHorizontalCount).toList();
      rowList.addAll(List.generate(rowCount.length, (index) => Container(
        margin: const EdgeInsets.all(8),
        width: 35,
        height: 35,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: rowCount[index]),
      ),));
      colList.add(Row(mainAxisAlignment:MainAxisAlignment.center,children: rowList,));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: colList,
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

enum NumberMode{
  n24,n36,n48
}

extension NumberExt on NumberMode{
  int get getHorizontalCount {
    switch (this) {
      case NumberMode.n24:
        return 6;
      case NumberMode.n36:
        return 9;
      case NumberMode.n48:
        return 12;
      default:
        return 6;
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

