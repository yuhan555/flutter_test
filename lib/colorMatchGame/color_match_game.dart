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
  late String levelVal;
  late String modeVal;


  @override
  void initState(){
    level = Level.easy;
    numberMode = NumberMode.n24;
    levelVal = level.name;
    modeVal = numberMode.name;
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
                        val: levelVal,
                        optPressed: (v){
                          levelVal = v;
                          setState(() {});
                        },
                      ).addBottomMargin(20),
                      RadioBox(
                        radioLabel:'Number of Colors',
                        labelSize: 20,
                        opt: const [['24','n24'],['36','n36'],['48','n48']],
                        val: modeVal,
                        optPressed: (v){
                          modeVal = v;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Expanded(
                      child: Column(
                        children: [
                          Text('Time',style: TextStyle(fontSize: 30),textAlign:TextAlign.center,),
                          Text('00:30',style: TextStyle(fontFamily: 'Rajdhani',fontSize: 65),textAlign:TextAlign.center),
                          PrimaryButton(
                            label: 'Restart',
                            onPressed: (){
                              level = levelVal.toLevel;
                              numberMode = modeVal.toNumberMode;
                              initColor(level,numberMode);
                              setState(() {});
                            },
                          )
                        ],
                      )
                  )
                ],
              ).addBottomMargin(16),
              Expanded(
                flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(border: Border.all(color: Colors.black12),borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Drag to here',style: TextStyle(fontFamily: 'Rajdhani',fontSize: 18),).addBottomMargin(10),
                                getList(colorListA),
                              ],
                            ))
                      ),
                      Expanded(child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(border: Border.all(color: Colors.black12),borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Choice color',style: TextStyle(fontFamily: 'Rajdhani',fontSize: 18),).addBottomMargin(10),
                              getList(colorListB,true),
                            ],
                          ))),
                    ],
                  ),
              )
            ],
          )
      ),
    );
  }

  Widget getList(List<Color> colors,[bool drag = false]){
    List<Widget> colList = [];
    for(var i = 0; i <= colors.length; i = i+numberMode.getHorizontalCount){
      List<Widget> rowList = [];
      if(i+numberMode.getHorizontalCount > colors.length) break;
      List<Color> rowCount = colors.getRange(i, i+numberMode.getHorizontalCount).toList();
      rowList.addAll(List.generate(rowCount.length, (index) => drag ? Draggable(
        feedback: Container(
          margin: const EdgeInsets.all(6),
          width: 40,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: rowCount[index]),
        ),
        childWhenDragging: Container(
          margin: const EdgeInsets.all(6),
          width: 40,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.transparent),
        ),
        child: Container(
          margin: const EdgeInsets.all(6),
          width: 40,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: rowCount[index]),
        ),
      ) : Container(
        margin: const EdgeInsets.all(6),
        width: 40,
        height: 40,
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
        int mainC = random.nextInt(3); //一個主色，兩個變動色
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
        List<int> cList = [random.nextInt(256),random.nextInt(256),random.nextInt(256)];
        int transIndex = random.nextInt(3); //兩個定色，一個變動色
        int transInt = cList[transIndex];
        while(list.length < numberMode.getCount){
          transInt = transInt + 5 > 256 ? 0 : transInt + 5; //256取48個，最多間距5
          var colors = List.generate(3, (index) => index != transIndex ? cList[index] : transInt);
          Color tempCol = Color.fromRGBO(colors[0], colors[1], colors[2], 1);
          if(!list.contains(tempCol)){
            // AppLog('${colors[0]}/${colors[1]}/${colors[2]}');
            list.add(tempCol);
          }
        }
        break;
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

