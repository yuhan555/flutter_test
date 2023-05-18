import 'dart:async';
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

class _ColorMatchGameState extends State<ColorMatchGame> with TickerProviderStateMixin{
  final ColorMatchBloc colorMatchBloc = ColorMatchBloc();

  late String levelVal;
  late String modeVal;
  Timer? timer;

  // 動畫
  late AnimationController controller;
  late AnimationController scaleController;
  late Animation<Offset> offsetAnimation;
  late Animation<double> fadeAnimation;
  @override
  void initState() {
    levelVal = colorMatchBloc.level.name;
    modeVal = colorMatchBloc.numberMode.name;
    controller = AnimationController(duration: const Duration(milliseconds: 1300), vsync: this)..addStatusListener((status) {
      if (status == AnimationStatus.completed){
        // 動畫完成後重新reset
        controller.reset();
        scaleController.reset();
      }
    });
    CurvedAnimation cure = CurvedAnimation(parent: controller, curve: Curves.decelerate); //定義動畫曲線
    scaleController = AnimationController(duration: const Duration(milliseconds: 10), vsync: this);
    // 移動和淡出用同一個controller控制
    offsetAnimation = Tween(begin: const Offset(0.0, 0.4), end: Offset.zero).animate(cure);
    fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(cure);
    colorMatchBloc.add(InitData());
    super.initState();
  }

  void startTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(colorMatchBloc.time==0){
        cancelTimer();
        colorMatchBloc.disabledDrag = true;
        colorMatchBloc.add(Timeout());
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

  void showAppDialog(BuildContext context, Widget dialog, {bool barrierDismissible = false}) {
    showDialog(
      barrierDismissible: barrierDismissible, //点击遮罩不关闭对话框
      context: context,
      builder: (context) {
        return dialog;
      });
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
          listener: (context, state){
            if(state is InitSuccess){
              Future.delayed(const Duration(seconds: 1),(){
                startTimer();
              });
            }else if(state is AcceptState){
              // 啟動動畫
              controller.forward();
              scaleController.forward();
              if(colorMatchBloc.match == colorMatchBloc.numberMode.count){
                cancelTimer();
                Future.delayed(const Duration(seconds: 1),(){
                  colorMatchBloc.add(Bonus());
                });
              }
            }else if(state is BonusState){
              controller.forward();
              scaleController.forward();
              Future.delayed(const Duration(seconds: 2),(){
                colorMatchBloc.add(Finish());
              });
            }else if(state is RestartState){
              showAppDialog(context,
                AlertDialog(
                  // contentPadding: EdgeInsets.zero,
                  // titlePadding: EdgeInsets.zero,
                  // insetPadding: EdgeInsets.zero,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(state.finish ? "Well done" : "Time's up",style: const TextStyle(
                          fontFamily: 'Rajdhani', fontSize: 40)),
                      Text('Score ${colorMatchBloc.score}',
                          style: const TextStyle(
                              fontFamily: 'Rajdhani', fontSize: 80),
                          textAlign: TextAlign.center),
                      PrimaryButton(
                        label: 'OK',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),);
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            Column(
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
                                    cancelTimer();
                                    colorMatchBloc.level = levelVal.toLevel;
                                    colorMatchBloc.numberMode = modeVal.toNumberMode;
                                    colorMatchBloc.add(InitData());
                                  },
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Score',
                                  style: TextStyle(fontSize: 40),
                                  textAlign: TextAlign.center,
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 60),
                                      child: Text('${colorMatchBloc.score}',
                                          style: const TextStyle(
                                              fontFamily: 'Rajdhani', fontSize: 70),
                                          textAlign: TextAlign.center),
                                    ),
                                  Positioned(
                                      top: 0,
                                      right:0,
                                      child: SlideTransition(
                                        position: offsetAnimation,
                                        child: FadeTransition(
                                          opacity: fadeAnimation,
                                          child: ScaleTransition(
                                            scale: scaleController,
                                            child: Text('+${colorMatchBloc.scoreRange}',style: const TextStyle(
                                                fontFamily: 'Rajdhani', fontSize: 45,color:Colors.deepOrangeAccent)),
                                          )
                                        ))
                                    )
                                  ],
                                )
                              ],
                            ),
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
            disabledDrag: colorMatchBloc.disabledDrag,
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

