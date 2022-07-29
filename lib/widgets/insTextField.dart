
import 'package:my_test/util/Util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_test/extension/CommonExtension.dart';

class InsTextField extends StatefulWidget {
  final double? width; //欄位寬，可給可不給
  final EdgeInsetsGeometry? margin; //欄位邊距
  final TextEditingController? controller; //輸入欄位controller
  final String value;
  final String wording; //註解文字
  final ValueChanged<String>? onChanged; //輸入欄位值變更時動作
  final String? label; //輸入欄位label
  final String? hint; //輸入欄位提示文字
  final String errMsg; //錯誤訊息
  final bool hasErr; //是否有錯誤
  final bool enable; //是否禁用
  final bool whiteBg; //禁用時是否白底
  final Function? onFocusOut; //離開焦點時動作
  final Function? onFocus; //離開焦點時動作
  final bool hasUnderline; //enable時，是否有下底線
  final bool display; //是否顯示此欄位
  final List<TextInputFormatter>? inputFormatters; //設定輸入類型
  final int? lengthLimiting; //設定輸入字數
  final bool textUpper; // 英文字母強制轉大寫
  final FocusNode? focusNode;
  final bool readOnly;//是否唯讀
  final Function? onTap; //點擊時動作
  final bool enableUnderLine ; // enable 時是否有底線 預設為沒有 - false
  final Function? onSubmit; //鍵盤按下done時
  final bool setUpCursor ; // 游標設為false，當focus時改為true
  final TextStyle? textStyle; //輸入文字style
  final bool dateFormat; // 是否須轉日期格式
  const InsTextField(
      {Key? key,
      this.width,
      this.margin,
      this.controller,
      this.onChanged,
      this.label,
      this.hint,
      this.errMsg = '',
      this.hasErr = false,
      this.enable = true,
      this.whiteBg = false,
      this.value = '',
      this.wording = '',
      this.onFocusOut,
      this.onFocus,
      this.hasUnderline = true,
      this.display = true,
      this.inputFormatters,
      this.lengthLimiting,
      this.textUpper = false,
      this.focusNode,
      this.readOnly = false,
      this.onTap,
      this.enableUnderLine = false,
      this.onSubmit,
      this.setUpCursor = false,
        this.textStyle,
        this.dateFormat = false,
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return InsTextFieldState();
  }
}

class InsTextFieldState extends State<InsTextField> {
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

  List<TextInputFormatter> get getInputFormatters {
    _inputFormatter = widget.inputFormatters ?? [];
    _inputFormatter!.add(FilteringTextInputFormatter.deny(RegExp("[\n]"))); //不可輸入換行符號
    if(widget.textUpper){
      int count = _inputFormatter!
          .whereType<UpperCaseTextFormatter>()
          .toList()
          .length;
      if (count == 0) {
        _inputFormatter!.add(UpperCaseTextFormatter());
      }
    }
    if(widget.dateFormat){
      int count = _inputFormatter!
          .whereType<DateTWNFormatter>()
          .toList()
          .length;
      if (count == 0) {
        _inputFormatter!.add(DateTWNFormatter());
      }
    }
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
      if(widget.setUpCursor){
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _controller = getController;
    // AppUtils.log(123452134);
    // AppUtils.log(widget.label);

    return Visibility(
      visible: widget.display,
      child: Container(
        margin: widget.margin,
        width: widget.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      showCursor: widget.setUpCursor ? focusNode.hasFocus : null,
//                      enableInteractiveSelection: false,
                      style: widget.textStyle,
                      controller: _controller,
                      focusNode: focusNode,
                      readOnly: widget.enable && !widget.readOnly ? false : true,
                      enabled: widget.enable,
                      onFieldSubmitted: (v){
//                        print(v);
                        if(widget.onSubmit != null){
                          widget.onSubmit!(v);
                        }
                      },
                      onChanged: (v) {
//                        if (widget.textUpper) {
//                          _controller.value = _controller.value.copyWith(
//                            text: v.toUpperCase(),
//                            selection: TextSelection.fromPosition(
//                              TextPosition(offset: v.toUpperCase().length),
//                            ),
//                          );
//                        }
                        if (widget.onChanged != null) {
                          widget.onChanged!(v);
                        }
                      },
                      inputFormatters: getInputFormatters,
                      decoration: InputDecoration(
                          enabledBorder: !widget.hasUnderline
                              ? const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 0),
                                )
                              : null,
                          disabledBorder: UnderlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(color: widget.enableUnderLine ? const Color.fromRGBO(151, 151, 151, 1) : Colors.transparent),
                          ),
                          fillColor: widget.enable ? Colors.transparent : widget.whiteBg ? Colors.transparent : const Color(0xFFF1F1F1),
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
                  ],
                ),
                Positioned(
                  right: 0,
                  bottom: 6,
                  child: Visibility(
                    visible: widget.hasErr,
                    child: Container(
                      color: const Color(0xFFD0021B),
                      padding: const EdgeInsets.only(
                          top: 4, bottom: 4, left: 10, right: 10),
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
            ),
            Visibility(
                visible: widget.wording.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    widget.wording,
                    style: const TextStyle(
                      color: Color(0xFFD0021B),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                    ),
                  ),
                )),
          ],
        ),
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

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;
    if(RegExp("[a-z]").hasMatch(text)) {
      text = text.toUpperCase();
      return TextEditingValue(
        text: text,
        selection: newValue.selection,
      );
    }
    return newValue;
  }
}

class DateTWNFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;
    if(text.replaceAll('/', '').length < 7) return newValue;
    if(RuleUtil.checkDateFormat(text)){
      DateTime date = RuleUtil.transDateStrToDateObj(text);
      var dateStr = date.toTWY(fStr: '/');
      return TextEditingValue(
        text: dateStr,
        selection: TextSelection.fromPosition(
          TextPosition(offset: dateStr.length),
        ),
      );
    }
    return newValue;
  }
}