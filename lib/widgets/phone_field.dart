
import 'package:flutter/material.dart';
import 'package:my_test/widgets/insTextField.dart';
import 'package:flutter/services.dart';

class PhoneWidget extends StatefulWidget {
  final String? label; //輸入欄位label
  final String errMsg; //錯誤訊息
  final bool enable; //是否禁用
  final bool display; //是否顯示此欄位
  final List value;
  final ValueChanged<dynamic>? onFocusOut; //失去焦點時觸發
  final EdgeInsetsGeometry margin; //欄位邊距
  final List<TextEditingController>? controllerList; //依序放入controller [區碼,電話,分機]
  final bool whiteBg; //禁用時是否白底

  const PhoneWidget({
    Key? key,
    this.label,
    this.errMsg = '',
    this.enable = true,
    this.display = true,
    this.whiteBg = false,
    this.value = const ['', '', ''],
    this.onFocusOut,
    this.margin = const EdgeInsets.only(bottom: 15),
    this.controllerList,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return PhoneWidgetState();
  }
}

class PhoneWidgetState extends State<PhoneWidget> {
  getTotalVal(){
    var dash = widget.controllerList![0].text.isNotEmpty && widget.controllerList![1].text.isNotEmpty ? '-'  : '';
    var sign = widget.controllerList![2].text.isNotEmpty ? '#'  : '';
    return '${widget.controllerList![0].text}$dash${widget.controllerList![1].text}$sign${widget.controllerList![2].text}';
  }
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Visibility(
      visible: widget.display,
      child: Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              InsTextField(
                width: 200,
                margin: EdgeInsets.only(right:14),
                label: widget.label,
                onFocusOut: (v){
                  if(widget.controllerList!.isEmpty){
                    return widget.onFocusOut!(v);
                  }
                  widget.onFocusOut!(getTotalVal());
                },
                enable:widget.enable,
                whiteBg:widget.whiteBg,
                lengthLimiting:4,
                controller: widget.controllerList![0],
                value:widget.value[0],
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),//限制只允许输入数字
                ],
              ),
              InsTextField(
                width: 200,
                margin: const EdgeInsets.only(right:14),
                label: '電話',
                onFocusOut: (v){
                  if(widget.controllerList!.isEmpty){
                    return widget.onFocusOut!(v);
                  }
                  widget.onFocusOut!(getTotalVal());
                },
                enable:widget.enable,
                whiteBg:widget.whiteBg,
                lengthLimiting:10,
                controller: widget.controllerList![1],
                value:widget.value[1],
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),//限制只允许输入数字
                ],
              ),
              Expanded(
                child: InsTextField(
                  margin: const EdgeInsets.all(0),
                  label: '分機',
                  onFocusOut: (v){
                    if(widget.controllerList!.isEmpty){
                      return widget.onFocusOut!(v);
                    }
                    widget.onFocusOut!(getTotalVal());
                  },
                  enable:widget.enable,
                  whiteBg:widget.whiteBg,
                  errMsg: widget.errMsg,
                  lengthLimiting:10,
                  hasErr: widget.errMsg == '' ? false : true,
                  controller: widget.controllerList![2],
                  value:widget.value[2],
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),//限制只允许输入数字
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    )
    );
  }
}
