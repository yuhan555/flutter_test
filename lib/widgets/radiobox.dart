import 'package:my_test/util/AppColors.dart';
import 'package:flutter/material.dart';

//文字框版
class RadioBox extends StatefulWidget {
  final String? radioLabel; //欄位標題文字
  final bool hasLabel; //是否有標題文字，預設有
  final List opt;// 選項顯示文字及值，選項由左至右，ex：[['男','M'],['女','F']]
  final String? val; //欄位值
  final String errMsg; //錯誤訊息
  final Function? optPressed; //選項按下後的動作
  final bool enabled; //是否禁用
  final EdgeInsetsGeometry? margin; //欄位邊距
  final double radioWidth;//按鈕寬度

  const RadioBox(
      {Key? key,
      this.radioLabel,
      this.hasLabel = true,
      this.opt = const [],
      this.val,
      this.errMsg = '',
      this.margin,
      this.optPressed,
      this.enabled=true,
        this.radioWidth=160})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return RadioBoxState();
  }
}

class RadioBoxState extends State<RadioBox> {
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Container(
      margin: widget.margin,
      child: Stack(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Visibility(
                visible: widget.hasLabel,
                child: Container(
                  padding: const EdgeInsets.only(left: 5, bottom: 5),
                  child: Text(
                    widget.radioLabel!,
                    style: const TextStyle(
                      color: Color(0xff2d73a5),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                    ),
                  ),
                ),),
                Container(
                  child: Row(
                    children: <Widget>[
                      for(var i in widget.opt)
                      SizedBox(
                          width: widget.radioWidth,
                          height: 36,
                          child: Container(
                              child: ElevatedButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(color:Color(0xffffffff)) ,
                                    disabledBackgroundColor: i[1] == widget.val
                                        ? widget.enabled ? const Color(0xFF4D97CF) : const Color(0xFF888888)
                                        : Colors.white,
                                  backgroundColor: i[1] == widget.val
                                      ? widget.enabled ? const Color(0xFF4D97CF) : const Color(0xFF888888)
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: i == widget.opt.first ? const Radius.circular(6) : const Radius.circular(0),
                                        bottomLeft: i == widget.opt.first ? const Radius.circular(6) : const Radius.circular(0),
                                        topRight: i == widget.opt.last ? const Radius.circular(6) : const Radius.circular(0),
                                        bottomRight: i == widget.opt.last ? const Radius.circular(6) : const Radius.circular(0),
                                      ),
                                      side: BorderSide(
                                        color: i[1] == widget.val
                                            ? widget.enabled ? const Color(0xFF4D97CF) : const Color(0xFF888888)
                                            : const Color(0xFF888888),
                                      )),
                                ),
                                onPressed: widget.enabled ? (){
                                  widget.optPressed!(i[1]);
                                } : null,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    i[0],
                                    style: TextStyle(
                                      color: i[1] == widget.val
                                          ? Colors.white
                                          : widget.enabled ? const Color(0xff373a3c) : const Color(0xFF888888),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 0,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                          ))),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 4,
            child: Visibility(
              visible: widget.errMsg.isNotEmpty,
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
    );
  }
}


//圓形框版
class RadiusBox extends StatefulWidget {
  final String radioLabel; //欄位標題文字
  final List opt;// 選項顯示文字及值，選項由左至右，ex：[['同意','Y'],['不同意','N']]
  final Function? onChange;
  final String? val; //欄位值
  final bool enabled; //是否禁用
  final EdgeInsetsGeometry? margin; //欄位邊距
  final String errMsg; //錯誤訊息
  final bool hasErr; //是否有錯誤
  final bool display; //是否顯示
  final CrossAxisAlignment radioLabelAlignment; //title alignment
  final TextStyle? radioLabelStyle; //title alignment
  final double? rightMargin; //右方邊距
  final double? optFontSize; //選項字體大小

  const RadiusBox(
      {Key? key,
        this.radioLabel = '',
        this.opt = const [],
        this.val,
        this.margin,
        this.display = true,
        this.onChange,
        this.errMsg = '',
        this.hasErr = false,
        this.enabled = true,
        this.rightMargin,
        this.optFontSize,
        this.radioLabelAlignment = CrossAxisAlignment.center,
        this.radioLabelStyle
        })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return RadiusBoxState();
  }
}

class RadiusBoxState extends State<RadiusBox> {
  @override
  Widget build(BuildContext context) {
    List radiusList = widget.opt;
// TODO: implement build
    return Visibility(
      visible: widget.display,
      child:Container(
        margin: widget.margin,
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: widget.radioLabelAlignment,
              children: <Widget>[
                Visibility(
                  visible: widget.radioLabel.isNotEmpty ? true : false,
                  child:Text(widget.radioLabel,style: widget.radioLabelStyle,),
                ),
                Row(
                  children: <Widget>[
                    for(var i in radiusList)
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Transform.scale(
                              scale: 1.3,
                              child: Radio<dynamic>(
                                value: i[1],
                                activeColor: const Color(0xFF26ACA9),
                                groupValue: widget.val,
                                onChanged: widget.enabled ? (value) {
                                  widget.onChange!(value);
                                } : null,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: widget.rightMargin ?? 24),
                              child: Text(
                                i[0],
                                style: TextStyle(
                                  color: const Color(0xff373a3c),
                                  fontSize: widget.optFontSize ?? 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0,
              bottom: 14,
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
}



//button版（查詢功能）
class RadioButton extends StatefulWidget {
  final List opt;// 選項按鈕顯示文字及值，ex：[['男','M'],['女','F']]
  final String? val; //欄位值
  final Function? onTap; //選項按下後的動作
  final EdgeInsetsGeometry? margin; //欄位邊距
  final String errMsg;

  const RadioButton(
      {Key? key,
        this.opt = const [],
        this.val,
        this.margin,
        this.onTap,
        this.errMsg = '',
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return RadioButtonState();
  }
}

class RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    String val = widget.val!;
    return Container(
        margin: widget.margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for(var i in widget.opt)
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 22),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(22.5)),
                        border: Border.all(width: 1,color: AppColors.darkSkyBlue),
                        color: val == i[1] ? AppColors.darkSkyBlue : AppColors.white,
                      ),
                      child: Wrap(
                        direction: Axis.horizontal,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: Image.asset('assets/img/Circle.png'),
                          ),
                          Text(i[0],style: TextStyle(fontSize: 20,color: val == i[1] ? AppColors.white : AppColors.black),),
                        ],
                      ),
                    ),
                    onTap: (){
                      val = i[1];
                      if(widget.onTap != null){
                        widget.onTap!(val);
                      }
                    },
                  ),
              ],
            ),
            Visibility(
              visible: widget.errMsg.isNotEmpty,
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
            ),
          ],
        )
    );
  }
}


//圓形框無選項版（表格用）
class RadiusNoWordBox extends StatefulWidget {
  final String? opt;// 選項值
  final Function? onChange;
  final String? val; //欄位值
  final EdgeInsetsGeometry? margin; //欄位邊距

  const RadiusNoWordBox(
      {Key? key,
        this.opt,
        this.val,
        this.margin,
        this.onChange,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return RadiusNoWordBoxState();
  }
}

class RadiusNoWordBoxState extends State<RadiusNoWordBox> {
  String? fieldVal;
  @override
  Widget build(BuildContext context) {
    fieldVal = widget.val;
    return Container(
      margin: widget.margin,
      child: Transform.scale(
          scale: 1.3,
          child: Center(
            child: Radio<dynamic>(
              value: widget.opt,
              activeColor: const Color(0xFF26ACA9),
              onChanged: (val) {
                setState(() {
                  fieldVal = val;
                });
                if(widget.onChange != null){
                  widget.onChange!(val);
                }
              },
              groupValue: fieldVal,
            ),
          )
      ),
    );
  }
}




