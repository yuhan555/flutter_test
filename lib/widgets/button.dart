import 'dart:convert';

import 'package:my_test/util/AppColors.dart';
import 'package:flutter/material.dart';

//實心色按鈕-----------
class PrimaryButton extends StatefulWidget {
  final String? label; //按鈕文字
  final VoidCallback? onPressed; //按鈕動作
  final EdgeInsetsGeometry? margin; //按鈕外間距
  final Color? color; //按鈕顏色
  final EdgeInsetsGeometry padding; //按鈕內間距
  final bool enable; //是否禁用
  final bool hasIcon; //是否有Icon
  final Widget? icon; //圖示
  final double fontSize; //字體大小
  final double minWidth; //按鈕最小寬度

  const PrimaryButton(
      {Key? key,
        this.label,
        this.onPressed,
        this.margin,
        this.color,
        this.enable = true,
        this.padding = const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
        this.hasIcon = false,
        this.icon,
        this.fontSize = 20,
        this.minWidth = 160
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return PrimaryButtonState();
  }
}

class PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Container(
      margin: widget.margin,
      child: ButtonTheme(
        minWidth: widget.minWidth,
        child: ElevatedButton(
          onPressed: widget.enable ? widget.onPressed : null,
          style: TextButton.styleFrom(
            textStyle: const TextStyle(color: Color(0xffffffff)) ,
            padding: widget.padding,
            backgroundColor: widget.color,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
          child: widget.hasIcon ? UnconstrainedBox(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: widget.icon,
              ), Text(widget.label!,
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0,
                  )),
            ],),) : Text(widget.label!,
              style: TextStyle(
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                letterSpacing: 0,
              )),
        ),
      ),
    );
  }
}

//邊框按鈕-----------
class SecondaryButton extends StatefulWidget {
  final String? label; //按鈕文字
  final VoidCallback? onPressed; //按鈕動作
  final EdgeInsetsGeometry? margin; //按鈕外間距
  final EdgeInsetsGeometry padding; //按鈕內間距
  final bool enable; //是否禁用
  final Color? color; //按鈕顏色
  final double fontSize; //按鈕文字size
  final double minWidth; //按鈕最小寬度
  const SecondaryButton({
    Key? key,
    this.label,
    this.enable = true,
    this.onPressed,
    this.margin,
    this.padding =
        const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
    this.fontSize = 20,
    this.minWidth = 160,
    this.color,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return SecondaryButtonState();
  }
}

class SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Container(
      margin: widget.margin,
      child: ButtonTheme(
        minWidth: widget.minWidth,
        child: ElevatedButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(color:  Color(0xFF373A3C)) ,
            padding: widget.padding,
            backgroundColor: Color(0xFFFFFFFF),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                side: BorderSide(color: widget.color != null ? widget.color! :  Color(0xff26aca9),width: 1.2)),
          ),
          onPressed: widget.enable ? widget.onPressed : null,
//          disabledColor: Colors.red
          child: Text(widget.label!,
              style: TextStyle(
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                letterSpacing: 0,
              )),
        ),
      ),
    );
  }
}

//alert info按鈕------------------
class AlertButton extends StatefulWidget {
  final GestureTapCallback? onPressed;
  final bool display; //是否顯示此欄位
  const AlertButton({Key? key, this.onPressed, this.display = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return AlertButtonState();
  }
}

class AlertButtonState extends State<AlertButton> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.display,
      child: InkWell(
          onTap: widget.onPressed,
          child: Container(
            margin: const EdgeInsets.all(3),
            width: 24,
            height: 24,
            child: Image.asset('assets/img/InfoRed.png', fit: BoxFit.contain),
          )),
    );
  }
}


//假陰影按鈕-----------
class FakeShadowButton extends StatefulWidget {
  final String? label; //按鈕文字
  final VoidCallback? onPressed; //按鈕動作
  final EdgeInsetsGeometry? margin; //按鈕外間距
  final Color? color; //按鈕顏色
  final EdgeInsetsGeometry padding; //按鈕內間距
  final bool enable; //是否禁用
  final bool hasIcon; //是否有Icon
  final Widget? icon; //圖示

  const FakeShadowButton(
      {Key? key,
        this.label,
        this.onPressed,
        this.margin,
        this.color,
        this.enable = true,
        this.padding = const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
        this.hasIcon = false,
        this.icon,
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return FakeShadowButtonState();
  }
}

class FakeShadowButtonState extends State<FakeShadowButton> {
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(
            color: AppColors.brownGreyTwo.withOpacity(0.2),
            offset: const Offset(0,1),
            blurRadius: 4,
            spreadRadius: 0
        )],
      ),
      child: ButtonTheme(
        minWidth: 160,
        child: ElevatedButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(color:Color(0xffffffff)) ,
            padding: widget.padding,
            backgroundColor: widget.color,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
          onPressed: widget.enable ? widget.onPressed : null,
          child: widget.hasIcon ? UnconstrainedBox(
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: widget.icon,
              ),
              Text(widget.label!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0,
                  )),
            ],),) : Text(widget.label!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                letterSpacing: 0,
              )),
        ),
      ),
    );
  }
}