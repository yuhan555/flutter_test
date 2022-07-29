
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextArea extends StatefulWidget {
  final double? width; //欄位寬，可給可不給
  final double? areaHeight; //輸入框高度
  final EdgeInsetsGeometry? margin; //欄位邊距
  final TextEditingController? controller; //輸入欄位controller
  final String value;
  final ValueChanged<String>? onChanged; //輸入欄位值變更時動作
  final String? hint; //輸入欄位提示文字
  final String errMsg; //錯誤訊息
  final bool hasErr; //是否有錯誤
  final bool enable; //是否禁用
  final bool whiteBg; //禁用時是否白底
  final Function? onFocusOut; //離開焦點時動作
  final Function? onFocus; //離開焦點時動作
  final bool display; //是否顯示此欄位
  final List<TextInputFormatter>? inputFormatters; //設定輸入類型
  final int? lengthLimiting; //設定輸入字數
  final bool textUpper; // 英文字母強制轉大寫
  final FocusNode? focusNode;
  final bool readOnly;//是否唯讀
  final Function? onTap; //點擊時動作

  const TextArea(
      {Key? key,
        this.width,
        this.areaHeight,
        this.margin,
        this.controller,
        this.onChanged,
        this.hint,
        this.errMsg = '',
        this.hasErr = false,
        this.enable = true,
        this.whiteBg = false,
        this.value = '',
        this.onFocusOut,
        this.onFocus,
        this.display = true,
        this.inputFormatters,
        this.lengthLimiting,
        this.textUpper = false,
        this.focusNode,
        this.readOnly = false,
        this.onTap,
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return TextAreaState();
  }
}

class TextAreaState extends State<TextArea> {
  final FocusNode _focusNode = FocusNode();
  TextEditingController? _controller;
  bool isOutSide = true;
  bool focus = false;
  List<TextInputFormatter>? _inputFormatter;

  FocusNode get focusNode => widget.focusNode ?? _focusNode;

  TextEditingController get getController {
    if (widget.controller == null) {
      isOutSide = false;
      return TextEditingController.fromValue(TextEditingValue(
          text: widget.value,
          selection:  TextSelection.fromPosition(TextPosition(
              affinity: TextAffinity.downstream,
              offset: widget.value.length))));
    }
    return widget.controller!;
  }

  List<TextInputFormatter> get getInputFormatters {
    _inputFormatter = widget.inputFormatters ?? [];
    if (widget.lengthLimiting != null) {
      int count = _inputFormatter!
          .whereType<LengthLimitingTextInputFormatter>()
          .toList()
          .length;
      if (count == 0) {
        _inputFormatter!
            .add(LengthLimitingTextInputFormatter(widget.lengthLimiting));
      }
    }
    return _inputFormatter!;
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
        widget.onFocusOut!(_controller!.text);
      }
    }else if(!focusNode.hasFocus){
      focus = false;
    } else {
      focus = true;
      if (widget.onFocus != null) {
        widget.onFocus!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _controller = getController;
// TODO: implement build
    return Visibility(
      visible: widget.display,
      child: Container(
        margin: widget.margin,
        width: widget.width,
        child: Stack(
          children: <Widget>[
            Container(
                height: widget.areaHeight,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff979797),
                  ),
                  color: widget.enable
                      ? Colors.transparent
                      : widget.whiteBg
                      ? Colors.transparent
                      : const Color(0xffd8d8d8),
                ),
                child: ListView(
                  //padding: EdgeInsets.only(top:0,left:10,right: 10),
                  children: <Widget>[
                    TextField(
                      controller: _controller,
                      focusNode: focusNode,
                      readOnly: widget.enable&&!widget.readOnly ? false : true,
                      enabled: widget.enable,
                      onTap: widget.onTap!(),
                      onChanged: (v) {
                        if (widget.textUpper) {
                          _controller!.value = _controller!.value.copyWith(
                            text: v.toUpperCase(),
                            selection: TextSelection.fromPosition(
                              TextPosition(offset: v.toUpperCase().length),
                            ),
                          );
                        }
                        if (widget.onChanged != null) {
                          widget.onChanged!(v.toUpperCase());
                        }
                      },
                      inputFormatters: getInputFormatters,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.enable ? widget.hint : '',
                          fillColor: widget.enable
                              ? Colors.transparent
                              : widget.whiteBg
                              ? Colors.transparent
                              : const Color(0xffd8d8d8),
                          filled: true,
                      ),
                    ),
                  ],
                )
            ),
            Positioned(
              right: 0,
              bottom: 6,
              child: Visibility(
                visible: widget.hasErr,
                child: Container(
                  color: const Color(0xFFD0021B),
                  padding: const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
                  child: Text(widget.errMsg,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14 ,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                      )),
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  @override
  void dispose() {
    if (!isOutSide) {
      _controller!.dispose();
    }
    focusNode.removeListener(_focusNodeListener);
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
