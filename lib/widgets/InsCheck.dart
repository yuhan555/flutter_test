
import 'package:my_test/widgets/button.dart';
import 'package:flutter/material.dart';

class InsCheck extends StatefulWidget {
  final bool display; //是否顯示欄位
  final Function? onTap; //勾選後動作
  final String? value; //勾選後的值，必須給
  final String val; //勾選匡值
  final EdgeInsetsGeometry? margin; //欄位外間距
  final String? label; //勾選匡文字
  final String header; //標題文字
  final Color labelColor; //勾選匡文字顏色
  final String errMsg; //錯誤訊息
  final bool hasErr; //是否有錯誤
  final bool enabled; //是否禁用
  final double? labelWidth; //label寬度
  final TextEditingController? controller; //controller
  final MainAxisAlignment checkBoxMainAxisAlignment;
  final CrossAxisAlignment checkBoxCrossAxisAlignment;
  final EdgeInsetsGeometry? checkBoxMargin;
  final bool infoIcon; //是否有info按鈕
  final Function? infoPressed; //info按鈕按下後動作
  const InsCheck(
      {Key? key,
        this.onTap,
        this.display = true,
        this.value,
        this.val = '',
        this.margin,
        this.label,
        this.header = '',
        this.labelColor = const Color(0xff373a3c),
        this.hasErr = false,
        this.errMsg = '',
        this.enabled = true,
        this.infoIcon = false,
        this.infoPressed,
        this.labelWidth,
        this.controller,
        this.checkBoxMainAxisAlignment = MainAxisAlignment.start,
        this.checkBoxCrossAxisAlignment = CrossAxisAlignment.start,
        this.checkBoxMargin
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return InsCheckState();
  }
}

class InsCheckState extends State<InsCheck> {
  EdgeInsetsGeometry? checkBoxMargin;
  @override
  void initState() {
    super.initState();
    checkBoxMargin = widget.checkBoxMargin ?? EdgeInsets.only(right: 10, top: 3);
  }

  @override
  Widget build(BuildContext context) {
    final cWidth = MediaQuery.of(context).size.width;
    final cHeight = MediaQuery.of(context).size.height;
// TODO: implement build
    return Visibility(
      visible: widget.display,
      child: Container(
          margin: widget.margin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: widget.header.isNotEmpty,
                child: Container(
                  padding: const EdgeInsets.only(left: 3, bottom: 5),
                  child: Text(
                    widget.header,
                    style: const TextStyle(
                      color: Color(0xff2d73a5),
                      fontSize: 15 ,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                    ),
                  ),
                ),),
              Stack(
                children: <Widget>[
                  Container(
                      child: Row(
                        mainAxisAlignment: widget.checkBoxMainAxisAlignment,
                        children: <Widget>[
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: this.widget.enabled ? (){
                              if (widget.onTap != null) {
                                widget.onTap!();
                              }
                            } : null,
                            child: Row(
                              crossAxisAlignment: widget.checkBoxCrossAxisAlignment,
                              children: <Widget>[
                                Container(
                                  margin: widget.checkBoxMargin,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      border: Border.all(
                                        color:
                                        widget.value == widget.val ? widget.enabled ? Color(0xfffa8080) : Color(0xff888888) :Color(0xff888888),
                                        width: 1,
                                      ),
                                      shape: BoxShape.rectangle,
                                      color: widget.value == widget.val ? widget.enabled ? Color(0xfffa8080) : Color(0xff888888) : widget.enabled ? Colors.white : Color(0xff888888)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Icon(
                                        Icons.check,
                                        size: 20.0,
                                        color: widget.value == widget.val ? Colors.white : widget.enabled ? Colors.white : Color(0xff888888),
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: widget.labelWidth,
                                  child: Text(
                                    widget.label ?? "",
                                    style: TextStyle(
                                      color: widget.labelColor,
                                      fontSize: 20,
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: widget.infoIcon,
                            child: AlertButton(
                              display: true,
                              onPressed: (){
                                if(widget.infoPressed!=null){
                                  widget.infoPressed!();
                                }
                              },
                            ),
                          ),
                        ],
                      )),
                  Positioned(
                    right: 0,
                    child: Visibility(
                    visible: widget.hasErr,
                    child: Container(
                      color: const Color(0xFFD0021B),
                      padding: const EdgeInsets.only(
                          top: 4, bottom: 4, left: 10, right: 10),
                      child: Text(widget.errMsg,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 0,
                          )),
                    ),
                  ),
                  )
                ],
              ),
            ],)
      ),
    );
  }
}



//無錯誤訊息之勾選匡
class InsCheckNoMsg extends StatefulWidget {
  final bool display; //是否顯示欄位
  final Function? onTap; //勾選後動作
  final String? value; //勾選後的值，必須給
  final String val; //勾選匡值
  final EdgeInsetsGeometry? margin; //欄位外間距
  final String? label; //勾選匡文字
  final String header; //標題文字
  final Color labelColor; //勾選匡文字顏色
  final String errMsg; //錯誤訊息
  final bool hasErr; //是否有錯誤
  final bool enabled; //是否禁用
  final double? labelWidth; //label寬度
  final TextEditingController? controller; //controller
  final MainAxisAlignment checkBoxMainAxisAlignment;
  final EdgeInsetsGeometry? checkBoxMargin;
  final bool infoIcon; //是否有info按鈕
  final Function? infoPressed; //info按鈕按下後動作
  const InsCheckNoMsg(
      {Key? key,
        this.onTap,
        this.display = true,
        this.value,
        this.val = '',
        this.margin,
        this.label,
        this.header = '',
        this.labelColor = const Color(0xff373a3c),
        this.hasErr = false,
        this.errMsg = '',
        this.enabled = true,
        this.infoIcon = false,
        this.infoPressed,
        this.labelWidth,
        this.controller,
        this.checkBoxMainAxisAlignment = MainAxisAlignment.start,
        this.checkBoxMargin
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return InsCheckNoMsgState();
  }
}

class InsCheckNoMsgState extends State<InsCheckNoMsg> {
  EdgeInsetsGeometry? checkBoxMargin;
  @override
  void initState() {
    super.initState();
    checkBoxMargin = widget.checkBoxMargin ?? EdgeInsets.only(right: 10, top: 3);
  }

  @override
  Widget build(BuildContext context) {
    final cWidth = MediaQuery.of(context).size.width;
    final cHeight = MediaQuery.of(context).size.height;
// TODO: implement build
    return Visibility(
      visible: widget.display,
      child: Container(
          margin: widget.margin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: widget.header.isNotEmpty,
                child: Container(
                  padding: const EdgeInsets.only(left: 3, bottom: 5),
                  child: Text(
                    widget.header,
                    style: const TextStyle(
                      color: Color(0xff2d73a5),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                    ),
                  ),
                ),),
              Stack(
                children: <Widget>[
                  Container(
                      child: Row(
                        mainAxisAlignment: widget.checkBoxMainAxisAlignment,
                        children: <Widget>[
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: widget.enabled ? (){
                              if (widget.onTap != null) {
                                widget.onTap!();
                              }
                            } : null,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: widget.checkBoxMargin,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      border: Border.all(
                                        color:
                                        widget.value == widget.val ? widget.enabled ? const Color(0xfffa8080) : const Color(0xff888888) : const Color(0xff888888),
                                        width: 1,
                                      ),
                                      shape: BoxShape.rectangle,
                                      color: widget.value == widget.val ? widget.enabled ? const Color(0xfffa8080) : const Color(0xff888888) : widget.enabled ? Colors.white : const Color(0xff888888)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Icon(
                                        Icons.check,
                                        size: 20.0,
                                        color: widget.value == widget.val ? Colors.white : widget.enabled ? Colors.white : const Color(0xff888888),
                                      )),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: widget.labelWidth,
                                  child: Text(
                                    widget.label ?? "",
                                    style: TextStyle(
                                      color: widget.labelColor,
                                      fontSize: 20,
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: widget.infoIcon,
                            child: AlertButton(
                              display: true,
                              onPressed: (){
                                if(widget.infoPressed!=null){
                                  widget.infoPressed!();
                                }
                              },
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ],)
      ),
    );
  }
}



//無錯誤訊息之多選勾選匡
class InsCheckGroup extends StatefulWidget {
  final bool display; //是否顯示欄位
  final Function? onTap; //勾選後動作
  final String? value; //欄位儲存值
  final EdgeInsetsGeometry? margin; //欄位外間距
  final List? boxList; //勾選匡文字及val，例：[['本國籍','1'],['外國籍','2']]
  final String header; //標題文字
  final Color labelColor; //勾選匡文字顏色
  final bool enabled; //是否禁用
  final double? labelWidth; //label寬度
  final TextEditingController? controller; //controller
  final MainAxisAlignment checkBoxMainAxisAlignment;
  final EdgeInsetsGeometry checkBoxMargin;
  final bool infoIcon; //是否有info按鈕
  final Function? infoPressed; //info按鈕按下後動作
  final bool isWrap ; // 是否換行 預設為false
  final EdgeInsetsGeometry itemMargin ; // 選項外間距

  const InsCheckGroup(
      {Key? key,
        this.onTap,
        this.display = true,
        this.value = '',
        this.margin,
        this.boxList,
        this.header = '',
        this.labelColor = const Color(0xff373a3c),
        this.enabled = true,
        this.infoIcon = false,
        this.infoPressed,
        this.labelWidth,
        this.controller,
        this.checkBoxMainAxisAlignment = MainAxisAlignment.start,
        this.checkBoxMargin = const EdgeInsets.only(right: 10, top: 3),
        this.isWrap = false, // 是否換行 預設為false
        this.itemMargin = const EdgeInsets.only(right: 16),
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return InsCheckGroupState();
  }
}

class InsCheckGroupState extends State<InsCheckGroup> {
  EdgeInsetsGeometry? checkBoxMargin;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cWidth = MediaQuery.of(context).size.width;
    final cHeight = MediaQuery.of(context).size.height;
    List boxList = widget.boxList!;
    var valList = widget.value!.split(',');

// TODO: implement build
    if(widget.isWrap == false){
//      不換行
      return Visibility(
        visible: widget.display,
        child: Container(
            margin: widget.margin,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Visibility(
                  visible: widget.header.isNotEmpty,
                  child: Container(
                    padding: EdgeInsets.only(left: 3, bottom: 5),
                    child: Text(
                      widget.header,
                      style: const TextStyle(
                        color: Color(0xff2d73a5),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                      ),
                    ),
                  ),),
                Stack(
                  children: <Widget>[
                    Container(
                        child: Row(
                          mainAxisAlignment: widget.checkBoxMainAxisAlignment,
                          children: <Widget>[
                            for (var i in boxList)
                              Container(
                                margin: widget.itemMargin,
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: this.widget.enabled ? (){
                                    if (widget.onTap != null) {
                                      widget.onTap!(i[1]);
                                    }
                                  } : null,
                                  child: Wrap(
                                    alignment:WrapAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                margin: widget.checkBoxMargin,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(2),
                                                    border: Border.all(
                                                      color:
                                                      valList.contains(i[1]) ? widget.enabled ? const Color(0xfffa8080) : const Color(0xff979797) : const Color(0xff979797),
                                                      width: 1,
                                                    ),
                                                    shape: BoxShape.rectangle,
                                                    color: valList.contains(i[1]) ? widget.enabled ? const Color(0xfffa8080) : const Color(0xff979797) : Colors.white),
                                                child: const Padding(
                                                    padding: EdgeInsets.all(1.0),
                                                    child: Icon(
                                                      Icons.check,
                                                      size: 20.0,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(right: 0),
                                                width: widget.labelWidth,
                                                child: Text(
                                                  i[0] ?? "",
                                                  style: TextStyle(
                                                    color: widget.labelColor,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),),
                            Visibility(
                              visible: widget.infoIcon,
                              child: AlertButton(
                                display: true,
                                onPressed: (){
                                  if(widget.infoPressed!=null){
                                    widget.infoPressed!();
                                  }
                                },
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ],)
        ),
      );
    }else{
//      換行
      return Visibility(
        visible: widget.display,
        child: Container(
            margin: widget.margin,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Visibility(
                  visible: widget.header.isEmpty ? false : true,
                  child: Container(
                    padding: const EdgeInsets.only(left: 3, bottom: 5),
                    child: Text(
                      widget.header,
                      style: const TextStyle(
                        color: Color(0xff2d73a5),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                      ),
                    ),
                  ),),
                Stack(
                  children: <Widget>[
                    Container(
                      width: cWidth,
                        child: Wrap(
      //                    mainAxisAlignment: widget.checkBoxMainAxisAlignment,
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          spacing: 20,
                          children: <Widget>[
                            for (var i in boxList)
                              Container(
                                margin: widget.itemMargin,
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: this.widget.enabled ? (){
                                    if (widget.onTap != null) {
                                      widget.onTap!(i[1]);
                                    }
                                  } : null,
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 150,
                                    ),
                                    child: Wrap(
                                      children: <Widget>[
                                        Container(
                                          margin: widget.checkBoxMargin,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(2),
                                              border: Border.all(
                                                color:
                                                valList.contains(i[1]) ? widget.enabled ? const Color(0xfffa8080) : const Color(0xff979797) : const Color(0xff979797),
                                                width: 1,
                                              ),
                                              shape: BoxShape.rectangle,
                                              color: valList.contains(i[1]) ? widget.enabled ? const Color(0xfffa8080) : const Color(0xff979797) : Colors.white),
                                          child: const Padding(
                                              padding: EdgeInsets.all(1.0),
                                              child: Icon(
                                                Icons.check,
                                                size: 20.0,
                                                color: Colors.white,
                                              )),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(right: 10),
                                          width: widget.labelWidth,
                                          child: Text(
                                            i[0] ?? "",
                                            style: TextStyle(
                                              color: widget.labelColor,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          ],
                        )),
                  ],
                ),
              ],)
        ),
      );
    }
  }
}

//有錯誤訊息之多選勾選匡
class CheckGroup extends StatefulWidget {
  final Function? onTap; //勾選後動作
  final EdgeInsetsGeometry? margin; //欄位外間距
  final List? boxList; //勾選匡文字及val，例：[['本國籍','1'],['外國籍','2']]
  final String header; //標題文字
  final Color labelColor; //勾選匡文字顏色
  final bool enabled; //是否禁用
  final double? labelWidth; //label寬度
  @required final TextEditingController? controller; //controller
  final MainAxisAlignment checkBoxMainAxisAlignment;
  final EdgeInsetsGeometry checkBoxMargin;
  final bool isWrap ; // 是否換行 預設為false
  final String errMsg ; // 錯誤訊息
  final bool infoIcon; //是否有info按鈕
  final Function? infoPressed; //info按鈕按下後動作
  final EdgeInsetsGeometry itemMargin ; // 選項外間距

  const CheckGroup(
      {Key? key,
        this.onTap,
        this.margin,
        this.boxList,
        this.header = '',
        this.labelColor = const Color(0xff373a3c),
        this.enabled = true,
        this.labelWidth,
        this.controller,
        this.checkBoxMainAxisAlignment = MainAxisAlignment.start,
        this.checkBoxMargin = const EdgeInsets.only(right: 10, top: 3),
        this.isWrap = false, // 是否換行 預設為false
        this.errMsg = '',
        this.infoIcon = false,
        this.infoPressed,
        this.itemMargin = const EdgeInsets.only(right: 16),
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return CheckGroupState();
  }
}

class CheckGroupState extends State<CheckGroup> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InsCheckGroup(
          margin: widget.margin,
          labelColor: widget.labelColor,
          enabled: widget.enabled,
          labelWidth: widget.labelWidth,
          checkBoxMargin: widget.checkBoxMargin,
          isWrap: widget.isWrap,
          infoIcon: widget.infoIcon,
          infoPressed: widget.infoPressed,
          header: widget.header,
          boxList: widget.boxList,
          itemMargin: widget.itemMargin,
          controller: widget.controller,
          value: widget.controller!.text,
          onTap:(v){
            setState(() {
              var valList = widget.controller!.text.isNotEmpty ? widget.controller!.text.split(',') : [];
              if (valList.contains(v)) {
                valList.remove(v);
              } else {
                valList.add(v);
              }
              widget.controller!.text = valList.join(',');
              if(widget.onTap != null){
                widget.onTap!(widget.controller!.text);
              }
            });
          },
        ),
        Visibility(
          visible: widget.errMsg.isNotEmpty,
          child: Container(
            margin:const  EdgeInsets.only(top:8),
            color: const Color(0xFFD0021B),
            padding: const EdgeInsets.only(
                top: 4, bottom: 4, left: 10, right: 10),
            child: Text(widget.errMsg,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                )),
          ),
        ),
      ],
    );
  }
}

//多選勾選匡(選項直排)
class InsCheckGroupCol extends StatefulWidget {
  final bool display; //是否顯示欄位
  final Function? onTap; //勾選後動作
  final String value; //欄位儲存值
  final String errMsg; //錯誤訊息
  final EdgeInsetsGeometry? margin; //欄位外間距
  final List? boxList; //勾選匡文字及val，例：[['本國籍','1'],['外國籍','2']]
  final String header; //標題文字
  final Color labelColor; //勾選匡文字顏色
  final bool enabled; //是否禁用
  final double? labelWidth; //label寬度
  final TextEditingController? controller; //controller
  final MainAxisAlignment checkBoxMainAxisAlignment;
  final EdgeInsetsGeometry checkBoxMargin;
  final bool infoIcon; //是否有info按鈕
  final Function? infoPressed; //info按鈕按下後動作
  final bool isWrap ; // 是否換行 預設為false

  const InsCheckGroupCol(
      {Key? key,
        this.onTap,
        this.display = true,
        this.value = '',
        this.margin,
        this.errMsg = '',
        this.boxList,
        this.header = '',
        this.labelColor = const Color(0xff373a3c),
        this.enabled = true,
        this.infoIcon = false,
        this.infoPressed,
        this.labelWidth,
        this.controller,
        this.checkBoxMainAxisAlignment = MainAxisAlignment.start,
        this.checkBoxMargin = const EdgeInsets.only(right: 10, top: 3),
        this.isWrap = false, // 是否換行 預設為false
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return InsCheckGroupColState();
  }
}

class InsCheckGroupColState extends State<InsCheckGroupCol> {
  EdgeInsetsGeometry? checkBoxMargin;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cWidth = MediaQuery.of(context).size.width;
    final cHeight = MediaQuery.of(context).size.height;
    List boxList = widget.boxList!;
    var valList = widget.value.split(',');

// TODO: implement build
    return Visibility(
      visible: widget.display,
      child: Container(
          margin: widget.margin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: widget.header.isNotEmpty,
                child: Container(
                  padding: const EdgeInsets.only(left: 3, bottom: 5),
                  child: Text(
                    widget.header,
                    style: const TextStyle(
                      color: Color(0xff2d73a5),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                    ),
                  ),
                ),),
              Stack(
                children: <Widget>[
                  Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: widget.checkBoxMainAxisAlignment,
                        children: <Widget>[
                          for (var i in boxList)
                            Container(
                              margin: EdgeInsets.only(bottom: 16),
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: this.widget.enabled ? (){
                                  if (widget.onTap != null) {
                                    widget.onTap!(i[1]);
                                  }
                                } : null,
                                child: Wrap(
                                  alignment:WrapAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        child: Row(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: widget.checkBoxMargin,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(2),
                                                  border: Border.all(
                                                    color:
                                                    valList.contains(i[1]) ? widget.enabled ? const Color(0xfffa8080) : const Color(0xff979797) : const Color(0xff979797),
                                                    width: 1,
                                                  ),
                                                  shape: BoxShape.rectangle,
                                                  color: valList.contains(i[1]) ? widget.enabled ? const Color(0xfffa8080) : const Color(0xff979797) : Colors.white),
                                              child: const Padding(
                                                  padding: EdgeInsets.all(1.0),
                                                  child: Icon(
                                                    Icons.check,
                                                    size: 20.0,
                                                    color: Colors.white,
                                                  )),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(right: 5),
                                              width: widget.labelWidth,
                                              child: Text(
                                                i[0] ?? "",
                                                style: TextStyle(
                                                  color: widget.labelColor,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),),
                          Visibility(
                            visible: widget.errMsg.isNotEmpty,
                            child: Container(
                              color: const Color(0xFFD0021B),
                              padding: const EdgeInsets.only(
                                  top: 4, bottom: 4, left: 10, right: 10),
                              child: Text(widget.errMsg,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: 0,
                                  )),
                            ),
                          ),
                          Visibility(
                            visible: widget.infoIcon,
                            child: AlertButton(
                              display: true,
                              onPressed: (){
                                if(widget.infoPressed!=null){
                                  widget.infoPressed!();
                                }
                              },
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ],)
      ),
    );

  }
}


//無須帶值之勾選框(表格用)
class InsCheckNoVal extends StatefulWidget {
  final Function? onCheck; //勾選後動作
  final EdgeInsetsGeometry? margin; //欄位外間距
  final EdgeInsetsGeometry? checkBoxMargin;
  final bool? isChecked;
  const InsCheckNoVal(
      {Key? key,
        this.onCheck,
        this.margin,
        this.checkBoxMargin,
        this.isChecked
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return InsCheckNoValState();
  }
}

class InsCheckNoValState extends State<InsCheckNoVal> {
  bool? check;

  @override
  Widget build(BuildContext context) {
    check = widget.isChecked;
    final cWidth = MediaQuery.of(context).size.width;
    final cHeight = MediaQuery.of(context).size.height;
// TODO: implement build
    return Container(
      alignment: Alignment.center,
      margin: widget.margin,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: (){
          check = !check!;
          widget.onCheck!(check);
        },
        child: Container(
          margin: widget.checkBoxMargin,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: check! ? const Color(0xfffa8080) : const Color(0xff888888),
                width: 1,
              ),
              shape: BoxShape.rectangle,
              color: check! ? const Color(0xfffa8080) : Colors.white),
          child: const Padding(
              padding: EdgeInsets.all(1.0),
              child: Icon(
                Icons.check,
                size: 25.0,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}