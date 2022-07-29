
import 'package:flutter/material.dart';
import 'package:my_test/widgets/widgets.dart';
import 'package:flutter/services.dart';

class TimeField extends StatefulWidget {
  final String errMsg; //錯誤訊息
  final bool enable; //是否禁用
  final ValueChanged<dynamic>? onChanged; //change時觸發
  final EdgeInsetsGeometry margin; //欄位邊距
  final List<TextEditingController>? controllerList; //依序放入controller [總時分,時,分]
  final bool whiteBg; //禁用時是否白底
  final String labelHr; //時標題文字
  final String labelMin; //分標題文字

  const TimeField({
    Key? key,
    this.errMsg = '測試',
    this.enable = true,
    this.whiteBg = false,
    this.onChanged,
    this.margin = const EdgeInsets.only(bottom: 15),
    this.controllerList,
    this.labelHr = '出發時',
    this.labelMin = '出發分'
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return TimeFieldState();
  }
}

class TimeFieldState extends State<TimeField> {
  String getTime(){
    return '${widget.controllerList![1].text}:${widget.controllerList![2].text}';
  }
  List getSelectData(int count){
    return List.generate(count, (index) => [index.toString().padLeft(2,'0')]);
  }
  @override
  Widget build(BuildContext context) {
    final cWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: SelectField(
                  label: widget.labelHr,
                  hint: widget.labelHr,
                  margin: const EdgeInsets.only(right:14),
                  onChanged: (v){
                    if(widget.controllerList!.isEmpty){
                      return widget.onChanged!(v);
                    }
                    widget.controllerList![0].text = getTime();
                    widget.onChanged!(getTime());
                  },
                  enable:widget.enable,
                  whiteBg:widget.whiteBg,
                  controller: widget.controllerList![1],
                  items: getSelectData(24),
                ),
              ),
              SizedBox(width:cWidth*0.01),
              Expanded(
                child: SelectField(
                  label: widget.labelMin,
                  hint: widget.labelMin,
                  margin: const EdgeInsets.only(right:14),
                  onChanged: (v){
                    if(widget.controllerList!.isEmpty){
                      return widget.onChanged!(v);
                    }
                    widget.controllerList![0].text = getTime();
                    widget.onChanged!(getTime());
                  },
                  enable:widget.enable,
                  whiteBg:widget.whiteBg,
                  controller: widget.controllerList![2],
                  items: getSelectData(60),
                ),
              ),
            ],
          ),
          Visibility(
            visible: widget.errMsg.trim().isNotEmpty,
            child: Container(
              margin: const EdgeInsets.only(top: 8),
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
          )
        ],
      ),
    );
  }
}
