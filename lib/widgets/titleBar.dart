
import 'package:flutter/material.dart';


//長版
class TitleBar extends StatefulWidget {
  final String title; //標題文字
  final String subTitle; //子標題文字
  final double? width; //欄位寬度，可給可不給
  final EdgeInsetsGeometry? margin; //欄位邊距

  const TitleBar({
    Key? key,
    this.width,
    this.subTitle = '',
    this.title = '',
    this.margin,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return TitleBarState();
  }
}

class TitleBarState extends State<TitleBar> {
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Container(
      width: widget.width,
      height: 46,
      margin: widget.margin,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffe0f0f7),
                border: Border.all(
                color: const Color(0xff979797),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
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
                        padding: const EdgeInsets.only(left: 30, right: 40),
                        constraints: const BoxConstraints(minWidth: 220),
                        height: 45,
                        decoration: const BoxDecoration(
                          color: Color(0xff4d97cf),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                        ),
                        child: Text(widget.title,
                            style: const TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            )),
                      ),
                      Positioned(
                          top: -14,
                          right: -45,
                          child: Transform.rotate(angle: -100,child: const Icon(
                            Icons.play_arrow,
                            color: Color(0xffe0f0f7),
                            size: 92,
                          ),)
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left:35),
                  child: Text(widget.subTitle,style: const TextStyle(
                    color: Color(0xff373a3c),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



//短版
class MiniTitleBar extends StatefulWidget {
  final String title; //標題文字
  final String subTitle; //子標題文字
  final double? width; //欄位寬度，可給可不給
  final EdgeInsetsGeometry? margin; //欄位邊距
  final EdgeInsetsGeometry subTitlePadding; //子標題內padding

  const MiniTitleBar({
    Key? key,
    this.width,
    this.subTitle = '',
    this.title = '',
    this.margin,
    this.subTitlePadding = const EdgeInsets.only(left: 20),
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return MiniTitleBarState();
  }
}

class MiniTitleBarState extends State<MiniTitleBar> {
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Container(
      width: widget.width,
      height: 46,
      margin: widget.margin,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffe0f0f7),
              border: Border.all(
                color: const Color(0xff979797),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
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
                        padding: const EdgeInsets.only(left: 30, right: 40),
                        constraints: const BoxConstraints(minWidth: 80),
                        height: 45,
                        decoration: const BoxDecoration(
                          color: Color(0xff4d97cf),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                        ),
                        child: Text(widget.title,
                            style: const TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 20 ,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            )),
                      ),
                      Positioned(
                          top: -14,
                          right: -45,
                          child:Transform.rotate(angle: -100,child: const Icon(
                            Icons.play_arrow,
                            color: Color(0xffe0f0f7),
                            size: 92,
                          ),)
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: widget.subTitlePadding,
                  child: Text(widget.subTitle,style: const TextStyle(
                    color: Color(0xff373a3c),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
