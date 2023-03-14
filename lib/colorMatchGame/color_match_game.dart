import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test/colorMatchGame/bloc/color_match_bloc.dart';
import 'package:my_test/colorMatchGame/model/color_ball_model.dart';
import 'package:my_test/colorMatchGame/widget/color_ball_list.dart';
import 'package:my_test/extension/WidgetExtension.dart';
import 'package:my_test/util/AppLog.dart';
import 'package:my_test/widgets/widgets.dart';

class ColorMatchGame extends StatefulWidget {
  const ColorMatchGame({Key? key}) : super(key: key);

  @override
  State<ColorMatchGame> createState() => _ColorMatchGameState();
}

class _ColorMatchGameState extends State<ColorMatchGame> {
  final ColorMatchBloc colorMatchBloc = ColorMatchBloc();

  late String levelVal;
  late String modeVal;
  Timer? timer;

  @override
  void initState() {
    levelVal = colorMatchBloc.level.name;
    modeVal = colorMatchBloc.numberMode.name;
    colorMatchBloc.add(InitData());
    super.initState();
  }

  void startTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(colorMatchBloc.time==0){
        cancelTimer();
      }else{
        colorMatchBloc.time--;
      }
      setState(() {});
    });
  }

  void cancelTimer(){
    timer?.cancel();
    timer = null;
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final cWidth = screenSize.width;
    final cHeight = screenSize.height;

    return Scaffold(
      body: BlocProvider<ColorMatchBloc>(
        create: (context) => colorMatchBloc,
        child: BlocListener<ColorMatchBloc, ColorMatchState>(
          listener: (context, state) {
            if(state is InitSuccess){
              cancelTimer();
              Future.delayed(const Duration(seconds: 1),(){
                startTimer();
              });
            }
          },
          child: BlocBuilder<ColorMatchBloc, ColorMatchState>(
            builder: (context, state) {
              if(state is ColorMatchInitial){
                return Container();
              }else{
                return Container(
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
                                  radioLabel: 'Level',
                                  labelSize: 20,
                                  opt: const [
                                    ['Easy', 'easy'],
                                    ['Medium', 'medium'],
                                    ['Hard', 'hard']
                                  ],
                                  val: levelVal,
                                  optPressed: (v) {
                                    levelVal = v;
                                    colorMatchBloc.add(Rebuild());
                                  },
                                ).addBottomMargin(20),
                                RadioBox(
                                  radioLabel: 'Number of Colors',
                                  labelSize: 20,
                                  opt: const [
                                    ['24', 'n24'],
                                    ['36', 'n36'],
                                    ['48', 'n48']
                                  ],
                                  val: modeVal,
                                  optPressed: (v) {
                                    modeVal = v;
                                    colorMatchBloc.add(Rebuild());
                                  },
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                              children: [
                                const Text(
                                  'Time',
                                  style: TextStyle(fontSize: 30),
                                  textAlign: TextAlign.center,
                                ),
                                Text('${(colorMatchBloc.time/60).floor().toString().padLeft(2,'0')}:${(colorMatchBloc.time%60).toString().padLeft(2,'0')}',
                                    style: const TextStyle(
                                        fontFamily: 'Rajdhani', fontSize: 55),
                                    textAlign: TextAlign.center),
                                PrimaryButton(
                                  label: 'Restart',
                                  onPressed: () {
                                    colorMatchBloc.level = levelVal.toLevel;
                                    colorMatchBloc.numberMode = modeVal.toNumberMode;
                                    colorMatchBloc.add(InitData());
                                  },
                                )
                              ],
                            ),),
                            Expanded(child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Score',
                                  style: TextStyle(fontSize: 45),
                                  textAlign: TextAlign.center,
                                ),
                                Text('${colorMatchBloc.score}',
                                    style: const TextStyle(
                                        fontFamily: 'Rajdhani', fontSize: 80),
                                    textAlign: TextAlign.center),
                              ],
                            ),),
                          ],
                        ).addBottomMargin(20),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          border:
                                          Border.all(color: Colors.black12),
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Drag to here',
                                            style: TextStyle(
                                                fontFamily: 'Rajdhani',
                                                fontSize: 22),
                                          ).addBottomMargin(10),
                                          getList(colorMatchBloc.targetList),
                                        ],
                                      ))),
                              Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          border:
                                          Border.all(color: Colors.black12),
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Choice color',
                                            style: TextStyle(
                                                fontFamily: 'Rajdhani',
                                                fontSize: 22),
                                          ).addBottomMargin(10),
                                          getList(colorMatchBloc.dragList, drag: true),
                                        ],
                                      ))),
                            ],
                          ),
                        )
                      ],
                    ));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget getList(List<ColorBallModel> colors, {bool drag = false}) {
    List<Widget> colList = [];
    for (var i = 0; i <= colors.length; i = i + colorMatchBloc.numberMode.horizontalCount) {
      List<Widget> rowList = [];
      if (i + colorMatchBloc.numberMode.horizontalCount > colors.length) break;
      List<ColorBallModel> rowCount = colors.getRange(i, i + colorMatchBloc.numberMode.horizontalCount).toList();
      rowList.addAll(List.generate(rowCount.length, (index) =>
          ColorBall(
            colorModel: rowCount[index],
            drag: drag,
            data: rowCount[index].color,
            disabledDrag: colorMatchBloc.over,
            onDragCompleted: (){
              rowCount[index].visible = false;
              colorMatchBloc.add(Rebuild());
            },
            onDraggableCanceled: (v,o){
              colorMatchBloc.add(OnDragCancel());
            },
            onWillAccept: (Color? color){
              rowCount[index].hover = true;
              colorMatchBloc.add(Rebuild());
              return rowCount[index].color == color;
            },
            onAccept: (Color? color){
              rowCount[index].checked = true;
              colorMatchBloc.add(OnAccept());
            },
            onLeave: (Color? color){
              rowCount[index].hover = false;
              colorMatchBloc.add(Rebuild());
            },
          )));
      colList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowList,
      ));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: colList,
    );
  }

  @override
  void dispose() {
    timer = null;
    super.dispose();
  }

}

