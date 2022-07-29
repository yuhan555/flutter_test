
import 'package:flutter/material.dart';

class InsText extends StatefulWidget {
  final EdgeInsetsGeometry? margin; //欄位邊距
  final String? text; //文字
  final bool display; //是否顯示此欄位
  final TextStyle? style;

  const InsText(
      {Key? key,
        this.margin,
        this.text,
        this.display = true,
        this.style,
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return InsTextState();
  }
}

class InsTextState extends State<InsText> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Visibility(
      visible: widget.display,
      child: Container(
        margin: widget.margin,
        child: Text(widget.text!,style: widget.style)
      ),
    );
  }
}
