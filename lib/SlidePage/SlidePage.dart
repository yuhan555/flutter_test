import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_test/widgets/widgets.dart';

class SlidePage extends StatefulWidget {
  const SlidePage({Key? key}) : super(key: key);

  @override
  State<SlidePage> createState() => _SlidePageState();
}

class _SlidePageState extends State<SlidePage> with SingleTickerProviderStateMixin{
  late List itemList;
  late AnimationController animationController;
  late List<GlobalKey<ItemState>> keyList;

  @override
  void initState() {
    itemList = List.generate(20, (index) => {"index":index,"content":'content $index'});
    keyList = List.generate(20, (index) => GlobalKey<ItemState>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black87)),
          width: 600,
          height: 600,
          child: LayoutBuilder(
            builder: (context, constraints) =>
                ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    for (var item in itemList)
                    /// 方法一，用另一個Container包相同字段，去撐開Stack高度，根據Stack高度去設置按鈕高度
                    // Stack(
                    //   children: [
                    //     Container(
                    //         width: constraints.maxWidth,
                    //         padding: const EdgeInsets.all(10),
                    //         alignment: Alignment.centerLeft,
                    //         child: const Text("測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試",style: TextStyle(color: Colors.transparent),),
                    //     ),
                    //     LayoutBuilder(builder: (t,c)=> Row(
                    //       mainAxisAlignment: MainAxisAlignment.end,
                    //       children: [
                    //         buildAction("置頂", Colors.grey,c.maxHeight, () {}),
                    //         // buildAction( "標為未讀", Colors.amber,c.maxHeight, () {}),
                    //         buildAction("刪除", Colors.red, c.maxHeight,() {}),
                    //       ],
                    //     ),),
                    //     Positioned(
                    //       left: -120,
                    //       child: Container(
                    //           width: constraints.maxWidth,
                    //           padding: const EdgeInsets.all(10),
                    //           alignment: Alignment.centerLeft,
                    //           color: Colors.white,
                    //           // decoration: BoxDecoration(border: Border.all(color: Colors.red),color: Colors.white),
                    //           child: const Text("測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試",)
                    //       ),
                    //     )
                    //   ],
                    // ),
                    /// 方法二，使用Transform來位移
                      ClipRect(
                        child:SizedBox(
                          width: constraints.maxWidth,
                          child: Slider(
                            item: item,
                            constraints:constraints,
                            itemKey: keyList[itemList.indexOf(item)],
                            onDrag: (key){
                              for (var itemKey in keyList) {
                                if(itemKey != key){
                                  itemKey.currentState?.close();
                                }
                              }
                            },
                            onDelete: (key){
                              final i = keyList.indexOf(key);
                              keyList[i].currentState?.delete();
                              Future.delayed(const Duration(milliseconds: 390),(){
                                keyList.removeAt(i);
                                itemList.removeAt(i);
                                // print(itemList);
                                setState(() {});
                              });
                            },
                          ),
                        ),
                    )
                  ],
                ),
          ),
        ),
      )
    );
  }

}

class Slider extends StatefulWidget {
  final dynamic item;
  final BoxConstraints constraints;
  final GlobalKey<ItemState> itemKey;
  final Function? onDrag;
  final Function? onDelete;

  const Slider({
    Key? key,
    required this.item,
    required this.constraints,
    required this.itemKey,
    this.onDrag,
    this.onDelete,
  }) : super(key: itemKey); /// 注意！key要放進來，父層才抓得到currentState

  @override
  ItemState createState() => ItemState();

}

class ItemState extends State<Slider> with TickerProviderStateMixin{
   double translateX = 0.0;
   double? itemHeight = 45;
   double maxDragDistance = 180;
   late AnimationController animationController;
   late AnimationController animationController2;
   late Animation animation;
   bool isOpen = false;
   @override
   void initState() {
     animationController = AnimationController(
         lowerBound: -maxDragDistance,
         upperBound: 0,
         vsync: this,
         duration: const Duration(milliseconds: 180))
       ..addListener(() {
         translateX = animationController.value;
         setState(() {});
       });
     animationController2 = AnimationController(
         vsync: this,
         duration: const Duration(milliseconds: 180));
     animation = Tween(begin:itemHeight,end: 0.0).animate(animationController2)..addListener(() {
       setState(() {
         itemHeight = animation.value;
       });
     });
     super.initState();
   }

   void close(){
     if(translateX!=0){
       animationController.animateTo(0);
     }
   }

   void delete(){
     animationController.animateTo(0);
     Future.delayed(const Duration(milliseconds: 200),(){
       animationController2.forward();
     });
   }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: LayoutBuilder(builder: (t,c){
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildAction('置頂',Colors.grey,c.maxHeight,(){}),
              buildAction('已讀',Colors.amber,c.maxHeight,(){}),
              buildAction('刪除',Colors.red,c.maxHeight,(){
                if(widget.onDelete!=null){
                  widget.onDelete!(widget.itemKey);
                }
              }),
            ],
          );
        },)),
        GestureDetector(
          onTap: (){
            if(isOpen){
              close();
            }
          },
          onHorizontalDragStart: (details){
            if(widget.onDrag!=null){
              widget.onDrag!(widget.itemKey);
            }
          },
          onHorizontalDragUpdate: (details){
            translateX += details.delta.dx;
            if(translateX > 0.0){
              translateX = 0.0;
            }
            if(translateX.abs() > maxDragDistance){
              translateX = -maxDragDistance;
            }
            setState(() {});
          },
          onHorizontalDragEnd: (details){
            animationController.value = translateX;
            if (details.velocity.pixelsPerSecond.dx < -200){
              animationController.animateTo(-maxDragDistance);
              isOpen = true;
            }else if (details.velocity.pixelsPerSecond.dx > 200){
              animationController.animateTo(0);
            }else{
              if (translateX.abs() > maxDragDistance / 2) {
                animationController.animateTo(-maxDragDistance);
                isOpen = true;
              } else{
                animationController.animateTo(0);
              }
            }
          },
          child: Transform.translate(
            offset: Offset(translateX,0),
            child:  Container(
                width: widget.constraints.maxWidth,
                height:itemHeight,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                color: Colors.white,
                // decoration: BoxDecoration(border: Border.all(color: Colors.red),color: Colors.white),
                child: Text('${widget.item['content']} 測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試')
            ),
          ),
        )
      ],
    );
  }
}

Widget buildAction(String text, Color color, double height,GestureTapCallback tap) {
  return InkWell(
    onTap: tap,
    child: Container(
      padding: const EdgeInsets.all(10),
      height: height,
      width: 60,
      color: color,
      alignment: Alignment.center,
      child: Text(text,
          style: const TextStyle(
            color: Colors.white,
          )),
    ),
  );
}




