
import 'package:flutter/material.dart';


class TabCard extends StatefulWidget {
  List? tabsName; //各標籤名稱
  double? width; //卡片總寬，可給可不給
  double? tabTitleMinWidth; //tab名稱的最小寬
  EdgeInsetsGeometry? margin; //卡片邊距
  double? contentHeight; //卡片內容高度，若不設則根據卡片內容長高度
  Widget? tabChild1; //分頁一之內容
  Widget? tabChild2; //分頁二之內容
  Widget? tabChild3; //分頁三之內容
  Widget? tabChild4; //分頁四之內容
  Widget? tabChild5; //分頁五之內容
  Widget? tabChild6; //分頁六之內容
  Function? onTab; //點擊分頁動作
  Color? bgColor;
  bool avgWidth;
  double contentPaddingTop; //內容 top padding
  double contentPaddingBottom; //內容 bottom padding
  double contentPaddingLeft; //內容 top padding
  double contentPaddingRight; //內容 bottom padding
  int currentTabIndex;
  bool isCurrentTabIndex;//是否允許外面指定TabIndex
  double tabHeight;
  double contentBorder; //內容 bottom padding
  Color? contentBorderColor; //內容 border color
  Color bottomActiveColor; //下方點擊後的顏色
  Color bottomDeActiveColor; //下方點擊後的顏色
  Color? activeColor; //點擊後的顏色
  bool maxTabWidth;//上方tab寬度設為最大

  AlignmentGeometry textAlign;

  TabCard({
    Key? key,
    this.width,
    this.tabTitleMinWidth,
    this.margin,
    this.tabsName,
    this.tabHeight = 40,
    this.tabChild1,
    this.tabChild2,
    this.tabChild3,
    this.tabChild4,
    this.tabChild5,
    this.tabChild6,
    this.contentHeight,
    this.onTab,
    this.contentPaddingTop = 10,
    this.avgWidth = false,
    this.contentPaddingBottom = 10,
    this.contentPaddingLeft =20,
    this.contentPaddingRight =20,
    this.bgColor,
    this.currentTabIndex = 0,
    this.isCurrentTabIndex = false,
    this.contentBorder = 1,
    this.contentBorderColor,
    this.textAlign = Alignment.centerLeft,
    this.bottomActiveColor = Colors.transparent,
    this.bottomDeActiveColor = Colors.transparent,
    this.activeColor,
    this.maxTabWidth = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return TabCardState();
  }
}

class TabCardState extends State<TabCard> {
  List? tabChild;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    List tabs = widget.tabsName!;
    tabChild = [
      widget.tabChild1,
      widget.tabChild2,
      widget.tabChild3,
      widget.tabChild4,
      widget.tabChild5,
      widget.tabChild6
    ];
    var tabWidth = widget.width!=null ? widget.width! / tabs.length:null;
    return Container(
//        decoration:
//        BoxDecoration(border: Border.all(width: 1, color: Colors.red)),
        child: Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            height: widget.tabHeight,
            width: widget.avgWidth ? widget.width : widget.maxTabWidth ? screenSize.width : (screenSize.width - screenSize.width * 0.279),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                for (var i in tabs)
                  SizedBox(
                    height: 40,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xff979797),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                        width:widget.avgWidth?tabWidth: null,
                        child: Stack(
                          children: <Widget>[
                            FlatButton(
                              minWidth:widget.tabTitleMinWidth,
                              color: (widget.isCurrentTabIndex ? widget.currentTabIndex == tabs.indexOf(i) :_index == tabs.indexOf(i))
                                  ? widget.activeColor ?? const Color(0xffe0f0f7)
                                  : Colors.white,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  )),
                              onPressed: () {
                                //print(tabs.indexOf(i));
                                setState(() {
                                  _index = tabs.indexOf(i);
                                  widget.currentTabIndex = tabs.indexOf(i);
                                });
                                if(widget.onTab!=null){
                                  widget.onTab!(i);
                                }
                              },
                              child: Align(
                                alignment: widget.textAlign,
                                child: Text(i,
                                    style: TextStyle(
                                      color: (widget.isCurrentTabIndex?widget.currentTabIndex == tabs.indexOf(i):_index == tabs.indexOf(i))
                                          ? const Color(0xff373a3c)
                                          : const Color(0xff979797),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    )),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child:  Container(
                                height: 4,
                                color: (widget.isCurrentTabIndex?widget.currentTabIndex == tabs.indexOf(i):_index == tabs.indexOf(i))
                                    ? widget.bottomActiveColor
                                    : widget.bottomDeActiveColor,
                              )
                            )
                          ],
                        ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: (widget.tabHeight - 1)),
          child: Container(
            width: widget.width,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
                border: Border.all(
                  color: widget.contentBorderColor ?? const Color(0xff979797),
                  width: widget.contentBorder,
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                )),
            child: IndexedStack(
              index: widget.isCurrentTabIndex?widget.currentTabIndex:_index,
              children: <Widget>[

                for (var i in tabs)

                  Container(
                      constraints: const BoxConstraints(minHeight: 0),
                      decoration: BoxDecoration(color:widget.bgColor,borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      )),
                      height: widget.contentHeight,
                      padding: EdgeInsets.only(
                          top: widget.contentPaddingTop, bottom: widget.contentPaddingBottom, left: widget.contentPaddingLeft, right: widget.contentPaddingRight),
                      child: tabChild![tabs.indexOf(i)]),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
