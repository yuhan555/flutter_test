
import 'package:flutter/material.dart';


class SearchTab extends StatefulWidget {
  final List? tabsName; //各頁籤名稱
  final int currentTabIndex; //目前頁籤index
  final Function? onTab; //點擊分頁動作
  final Widget? showPage; //此頁籤顯示之畫面
  final EdgeInsetsGeometry outMargin; //頁籤外邊距
  final double tabHeight; //頁籤高度
  final double fontSize; //頁籤文字大小
  final EdgeInsetsGeometry margin; //頁籤與下方頁面間距


  const SearchTab({
    Key? key,
    this.tabsName,
    this.currentTabIndex = 0,
    this.onTab,
    this.showPage,
    this.outMargin = const EdgeInsets.all(15),
    this.tabHeight = 40,
    this.fontSize = 20,
    this.margin = const EdgeInsets.only(bottom: 20),

  }): super(key: key);
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  int? index;

  @override
  void initState(){
    index = widget.currentTabIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
        margin: widget.outMargin,
        child: Column(
          children: [
            Container(
              margin: widget.margin,
              child: Row(
                children: [
                  for(var i in widget.tabsName!)
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                            decoration: BoxDecoration(
                              color: index == widget.tabsName!.indexOf(i) ? const Color(0xFFA1E0DE) : const Color(0xFFFFFFFF),
                              border: Border(top: const BorderSide(color: Color(0xffdae5ec),width: 1) ,left: const BorderSide(color: Color(0xffdae5ec),width: 1),right: const BorderSide(color: Color(0xffdae5ec),width: 1) ,bottom: BorderSide(color:index == widget.tabsName!.indexOf(i) ? const Color(0xFF0DA1A3) : const Color(0xFFDAE5EC),width: 5)),
                            ),
                            height: widget.tabHeight,
                            child: Center(
                              child: Text(i,style: TextStyle(
                                fontSize: widget.fontSize,
                                fontStyle: FontStyle.normal,
                                color: index == widget.tabsName!.indexOf(i) ? Colors.black : Colors.grey,
                              )),
                            )
                        ),
                        onTap: (){
                          setState(() {
                            index = widget.tabsName!.indexOf(i);
                          });
                          if(widget.onTab!=null){
                            widget.onTab!(widget.tabsName!.indexOf(i));
                          }
                        },
                      ),),
                ],
              ),
            ),
            ///顯示頁面
            widget.showPage!,
          ],
        )
    );

  }
}
