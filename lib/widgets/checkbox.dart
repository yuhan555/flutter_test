import 'package:flutter/material.dart';

class InsCheckBox extends StatefulWidget {
  final GestureTapCallback? onTap; //勾選後動作
  final String value; //是否勾選，預設'N'
  final EdgeInsetsGeometry? margin; //欄位外間距
  final String? label; //勾選匡文字
  final String errMsg; //錯誤訊息
  final bool hasErr; //是否有錯誤
  final bool enabled; //是否禁用
  final double? labelWidth; //label寬度
  final TextEditingController? controller; //controller
  final MainAxisAlignment checkBoxMainAxisAlignment;
  final EdgeInsetsGeometry? checkBoxMargin;
  final Color bgColorCheck;

  const InsCheckBox(
      {Key? key,
      this.onTap,
      this.value = 'N',
      this.margin,
      this.label,
      this.hasErr = false,
      this.errMsg = '',
      this.enabled = true,
      this.labelWidth,
      this.controller,
        this.checkBoxMainAxisAlignment = MainAxisAlignment.start,
        this.checkBoxMargin,
        this.bgColorCheck = const Color(0xfffa8080)
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return InsCheckBoxState();
  }
}

class InsCheckBoxState extends State<InsCheckBox> {
  bool isCheck = false;
  late EdgeInsetsGeometry checkBoxMargin;
  @override
  void initState() {
    super.initState();
    checkBoxMargin = widget.checkBoxMargin ?? EdgeInsets.only(right: 10, top: 3);
    isCheck = widget.value == 'Y';
//    print(isCheck);
    if (widget.controller != null) {
      widget.controller!.text = isCheck ? 'Y' : 'N';
    }
  }

  void _changed(value) {
    isCheck = value;
    if (widget.controller != null) {
      setState(() {
        widget.controller!.text = isCheck ? 'Y' : 'N';
      });
    }

    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Stack(
        children: <Widget>[
          Container(
              child: Row(
            mainAxisAlignment: widget.checkBoxMainAxisAlignment,
            children: <Widget>[
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: widget.enabled
                    ? () {
                        _changed(!isCheck);
                      }
                    : null,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: widget.checkBoxMargin,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color:
                                isCheck ? widget.bgColorCheck : Color(0xff979797),
                            width: 1,
                          ),
                          shape: BoxShape.rectangle,
                          color: isCheck ? widget.bgColorCheck : Colors.white),
                      child: const Padding(
                          padding:  EdgeInsets.all(1.0),
                          child:  Icon(
                            Icons.check,
                            size: 20.0,
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      width: widget.labelWidth,
                      child: Text(widget.label ?? "",
                        style: const TextStyle(
                          color: Color(0xff373a3c),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
          Positioned(
            right: 0,
            child: Visibility(
              visible: widget.hasErr,
              child: Container(
                color: const Color(0xFFD0021B),
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                child: Text(
                  widget.errMsg,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
