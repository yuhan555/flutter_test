import 'package:my_test/util/AppColors.dart';
import 'package:flutter/material.dart';


class SubCard extends StatefulWidget {
  final String title; //卡片標題文字
  final String wording; //提示訊息文字
  final Color wordingColor; //提示訊息文字顏色
  final double wordingSize; //提示訊息文字大小
  final bool hasTitleChild; //是否有卡片標題旁widget
  final Widget? titleChild; //卡片標題旁的widget
  final Widget? child; //卡片內容
  final double? width; //卡片寬，可給可不給
  final double? height; //卡片高，可給可不給
  final EdgeInsetsGeometry? margin; //卡片邊距
  final bool showInfo; //是否有info按鈕
  final GestureTapCallback? onTap; //按下info按鈕動作
  final double paddingTop; //子widget TopPadding
  final double paddingLeft; //子widget Left padding
  final bool titleBottomLeftCircular; //title左下border是否圓角
  final String imgPath; //卡片標題文字
  final Color bgColor; //背景色
  final Color rectColor; //左上區塊背景色
  final Color fontColor; //左上區塊背景色
  final bool isWordingMax;//是否設定說明最大寬度
  final double? wordingMaxLength;//說明最大寬度
  const SubCard({
    Key? key,
    this.width,
    this.height,
    this.child,
    this.hasTitleChild = false,
    this.titleChild,
    this.wording = '',
    this.wordingColor = const Color(0xFFD0021B),
    this.wordingSize = 15,
    this.margin,
    this.title = '',
    this.showInfo = false,
    this.onTap,
    this.paddingTop = 55,
    this.paddingLeft = 20,
    this.titleBottomLeftCircular = false,
    this.bgColor = Colors.white,
    this.fontColor = Colors.white,
    this.imgPath = 'assets/img/infoWhite.png',
    this.rectColor = AppColors.darkSkyBlue,
    this.isWordingMax = false,
    this.wordingMaxLength
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return SubCardState();
  }
}

class SubCardState extends State<SubCard> {
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Container(
      margin: widget.margin,
      child: Stack(
        children: <Widget>[
          Container(
            height: widget.height,
            width: widget.width,
            padding: EdgeInsets.only(top: widget.paddingTop, left: widget.paddingLeft, right: 20, bottom: 20),
            decoration: BoxDecoration(
              color: widget.bgColor,
              border: Border.all(
                color: const Color(0xff979797),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: widget.child,
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Row(
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left:20, right: 40),
                        constraints: const BoxConstraints(minWidth: 220),
                        height: 45,
                        decoration: BoxDecoration(
                          color: widget.rectColor,//Color(0xff4d97cf),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(5),
                            bottomLeft: Radius.circular(widget.titleBottomLeftCircular?5:0),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Visibility(
                              visible: widget.showInfo,
                              child: InkWell(
                                onTap: widget.onTap,
                                child: Container(
                                width: 30,
                                height: 30,
                                child: Image.asset(widget.imgPath),//Image.asset('assets/img/infoWhite.png'),
                              ),),
                            ),
                            Container(
                              margin:EdgeInsets.only(left: 10),
                              child: Text(widget.title,
                                style: TextStyle(
                                  color: widget.fontColor,//Color(0xffffffff),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                )),),

                          ],
                        ),
                      ),
                      Positioned(
                          top: -14,
                          right: -45,
                          child: Transform.rotate(angle: -100,child: Icon(
                            Icons.play_arrow,
                            color: widget.bgColor,
                            size: 90,
                          ),)
                      ),
                    ],
                  ),
                ),
                Container(
                  constraints: widget.isWordingMax ? BoxConstraints(maxWidth: widget.wordingMaxLength!) : const BoxConstraints(),
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(widget.wording,
                      style: TextStyle(
                        color: widget.wordingColor,
                        fontSize: widget.wordingSize,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      )),
                ),
              ],
            ),
          ),
          //設定常用保額按鈕的位置
          Positioned(
            top:10,
            left:240,
            child: Visibility(
                visible: widget.hasTitleChild,
                child: Container(
                  child: widget.titleChild ?? Container(),
                )
            ),
          ),
        ],
      ),
    );
  }
}
