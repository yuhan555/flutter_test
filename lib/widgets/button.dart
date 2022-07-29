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
        minWidth: 160,
        child: RaisedButton(
          onPressed: widget.enable ? widget.onPressed : null,
          textColor: const Color(0xffffffff),
          padding: widget.padding,
          color: widget.color,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
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
        child: RaisedButton(
          padding: widget.padding,
          onPressed: widget.enable ? widget.onPressed : null,
          textColor: const Color(0xFF373A3C),
          color: const Color(0xFFFFFFFF),
//          disabledColor: Colors.red,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              side: BorderSide(
                  color: widget.color != null
                      ? widget.color!
                      : const Color(0xff26aca9),
                  width: 1.2)),
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

//簽名按鈕-----------
class SignatureButton extends StatefulWidget {
  final String label; //按鈕文字
  final VoidCallback? onPressed; //按鈕動作
//  final EdgeInsetsGeometry margin; //按鈕外間距
//  final EdgeInsetsGeometry padding; //按鈕內間距
  final String base64Img;
  final Alignment textAlignment;
  final EdgeInsetsGeometry? textMargin;
  final double? height;
  final double textFontSize;
  final bool enable; //是否禁用
  final Color? textColor;
  final Color bgColor;
  const SignatureButton({
    Key? key,
    this.label = "請點選",
    this.onPressed,
    this.height,
    this.textFontSize = 20,
    this.base64Img = '',
    this.enable = true,
    this.textAlignment = Alignment.centerLeft,
    this.textMargin,
    this.bgColor = const Color(0xFFFFFFFF),
    this.textColor,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SignatureButtonState();
  }
}

class SignatureButtonState extends State<SignatureButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: RaisedButton(
        padding: EdgeInsets.zero,
        onPressed: widget.enable ? widget.onPressed : null,
        textColor: const Color(0xFF373A3C),
        color: widget.bgColor,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        elevation: 0,
        shape: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[700]!, width: 0),
        ),
        disabledColor: const Color(0xFFF1F1F1),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: widget.textAlignment,
              child: Container(
                margin: widget.textMargin,
                child: widget.base64Img.isEmpty
                    ? Text(widget.label,
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: widget.textFontSize,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                    ))
                    : Image.memory(
                  base64Decode(widget.base64Img),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Image(image: AssetImage("assets/img/pencil_sign.png")),
            ),
          ],
        ),
      ),
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
        child: FlatButton(
          onPressed: widget.enable ? widget.onPressed : null,
          textColor: const Color(0xffffffff),
          padding: widget.padding,
          color: widget.color,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
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