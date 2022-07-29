
import 'package:flutter/material.dart';
import 'package:my_test/widgets/datePick.dart' as taiwanDate;
import 'package:flutter/services.dart';

import 'insTextField.dart';

class DateField extends StatefulWidget {
  final double? width; //元件總寬度，可給可不給
  final EdgeInsetsGeometry? margin; //欄位邊距
  final TextEditingController? controller; //輸入欄位controller
  final String value;
  final ValueChanged<String>? onChanged; //輸入欄位值變更時動作
  final String label; //輸入欄位label
  final String hint; //輸入欄位提示文字
  final String errMsg; //錯誤訊息
  final bool hasErr; //是否有錯誤
  final bool enable; //是否禁用
  final bool display; //是否顯示
  final bool whiteBg; //禁用時是否白底
  final bool birthType; //是否為生日用日曆，預設是
  final Function? onSelect; //點選日期後要做的動作，已帶所選日期參數
  final FocusNode? focusNode;
  final Function? onFocus; //焦點時動作
  final Function? onFocusOut; //離開焦點時動作
  final double errBottomdis; //錯誤訊息垂直變異量
  final double errRightdis; //錯誤訊息垂直變異量
  final int addLastYear;//可選年度最大顯示年度
  final Function? onSubmit; //鍵盤按下done時
  final bool dateFormat; // 是否須轉日期格式

  final double textContentLeftPadding;//文字padding
  const DateField({
    Key? key,
    this.width,
    @required this.controller,
    this.onChanged,
    this.label = '',
    this.hint = '',
    this.errMsg = '',
    this.margin,
    this.hasErr = false,
    this.enable = true,
    this.display = true,
    this.whiteBg = false,
    this.birthType = true,
    this.addLastYear = 1,
    this.onSelect,
    this.focusNode,
    this.onFocus,
    this.onFocusOut,
    this.textContentLeftPadding = 0,
    this.value = '',
    this.errBottomdis = 0,
    this.errRightdis = 0,
    this.onSubmit,
    this.dateFormat = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return DateFieldState();
  }
}

class DateFieldState extends State<DateField> {
  final FocusNode _focusNode = FocusNode();
  bool isOutSide = true;
  bool focus = false;
  late TextEditingController _controller;
  FocusNode get focusNode => widget.focusNode ?? _focusNode;
  TextEditingController get getController {
    if (widget.controller == null) {
      isOutSide = false;
      return TextEditingController.fromValue(TextEditingValue(
          text: widget.value,
          selection: TextSelection.fromPosition(TextPosition(
              affinity: TextAffinity.downstream,
              offset: widget.value.length))));
    }
    var text = widget.controller!.text;
    widget.controller!.selection = TextSelection.fromPosition(
      TextPosition(offset: text.length),
    );
    return widget.controller!;
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_focusNodeListener);
  }

  _focusNodeListener() {
    if (!focusNode.hasFocus && focus) {
      focus = false;
//      print("lose focus: ${_controller.text}");
      if (widget.onFocusOut != null) {
        widget.onFocusOut!(_controller.text);
      }
    }else if(!focusNode.hasFocus){
      focus = false;
    }else{
      if (widget.onFocus != null) {
        widget.onFocus!();
      }
      focus = true;
    }
  }

  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    _controller = getController;
// TODO: implement build
    var inputFormatters = [LengthLimitingTextInputFormatter(9),FilteringTextInputFormatter.allow(RegExp("[/,0-9]"))];
    if(widget.dateFormat)
    {
      inputFormatters.add(DateTWNFormatter());
    }
    return Visibility(
      visible: widget.display,
        child: Container(
      margin: widget.margin,
      width: widget.width,
      child: Stack(
        children: <Widget>[
          TextFormField(
            onFieldSubmitted: (v){
//                        print(v);
              if(widget.onSubmit != null){
                widget.onSubmit!(v);
              }
            },
            controller: _controller,
            focusNode: focusNode,
            readOnly: widget.enable ? false : true,
            enabled: widget.enable,
            onChanged: widget.onChanged,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left:widget.textContentLeftPadding,bottom: 0),
                disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                fillColor: widget.enable
                    ? Colors.transparent
                    : widget.whiteBg
                    ? Colors.transparent
                    : const Color(0xFFF1F1F1),
                filled: true,
                labelText: widget.label,
                hintText: widget.hint,
                labelStyle: const TextStyle(
                  color: Color(0xff2d73a5),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                )),
          ),
          Align(
//            right: 10,
//            bottom: 6,
            alignment: Alignment.centerRight,
            child: Visibility(
              visible: widget.enable ? true : false,
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: widget.enable
                    ? () {
                  //print(DateTime.now().year);
                  taiwanDate
                      .showDatePicker(
                      context: context,
                      initialDate: _dateTime ?? DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 100),
                      lastDate: DateTime(widget.birthType
                          ? DateTime.now().year+1
                          : (DateTime.now().year+1+this.widget.addLastYear)),
                      builder: (context, child) {
                        return Container(
                          width: 100,
                          height: 100,
                          child: child,
                        );
                      })
                      .then((date) {
                    if(date==null) return;
                    setState(() {
                      //It will clear all focus of the textField
                      FocusScope.of(context)
                          .requestFocus(FocusNode());
                      _dateTime = date;
                      widget.controller!.text =
                      '${(date.year - 1911).toString().padLeft(3,'0')}/${date.month.toString().padLeft(2,'0')}/${date.day.toString().padLeft(2,'0')}';
                    });
                    widget.onSelect!(
                        '${(date.year - 1911).toString().padLeft(3,'0')}/${date.month.toString().padLeft(2,'0')}/${date.day.toString().padLeft(2,'0')}');
                  });
                }
                    : null,
                child: const Image(
                  image: AssetImage("assets/img/calendar-time.png"),
                  width: 30.0,
                  height: 30.0,
                ),
              ),
            ),
          ),
          Positioned(
            right: 60 + widget.errRightdis,
            bottom: 6 + widget.errBottomdis,
            child: Visibility(
              visible: widget.hasErr,
              child: Container(
                color: const Color(0xFFD0021B),
                padding: const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
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
    ));
  }

  @override
  void dispose() {
    focusNode.removeListener(_focusNodeListener);
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
