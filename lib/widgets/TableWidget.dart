
import 'package:my_test/widgets/widgets.dart';
import 'package:my_test/base/BaseState.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TableWidget extends StatefulWidget {
  // TableWidget() : super();
  List<TableModel>? headerList;
  List<List<TableModel>>? contentList;
  List<TableModel>?footerList;

  Color headerBgColor;
  Color contentOddBgColor; ///奇數
  Color contentEvenBgColor; /// 偶數
  bool canScroll; ///可否左右滑動(若為true，則所有TableWidgetModel皆須給寬)
  double? contentHeight; ///若有高度表頭固定，內容可滑動

  TableWidget({
    this.headerList,
    this.contentList,
    this.footerList,
    this.headerBgColor = AppColors.fadedBlue,
    this.contentOddBgColor = AppColors.white,
    this.contentEvenBgColor = AppColors.offWhiteTwo,
    this.canScroll = false,
    this.contentHeight,
  }) : super();

  @override
  State createState() => _TableWidgetState();
}

class _TableWidgetState extends BaseState<TableWidget> with AppTableWidgetCommon {

  @override
  Widget buildViews(BuildContext context) {

    Widget tableWidget = Column(
      children: [
        getRowWidget(widget.headerList!,widget.headerBgColor),
        Container(
        height: widget.contentHeight,
        child: SingleChildScrollView(
            child:Column(
              children: [
                for (int i = 0; i < (widget.contentList ?? []).length; i++)
                  getRowWidget(
                      widget.contentList![i],
                      i % 2 == 0 ?widget.contentOddBgColor:widget.contentEvenBgColor
                  ),
                getRowWidget(widget.footerList!,widget.headerBgColor)
              ],
            )
        ),
      )
    ],);

    return widget.canScroll ?
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: tableWidget,
    ) : tableWidget;
  }

  Widget getRowWidget(List list,Color bgColor)
  {
    var tempList = list ?? [];
    return  IntrinsicHeight(
        child: Row(
            children: [
              for (var model in tempList)
                Expanded(
                    flex: model.cellWidth == null ? model.flex : 0,
                    child: getCell(model, bgColor)),
            ]
        )
    );
  }

  @override
  void initViewState() {
    // TODO: implement initViewState
  }
}

class TableModel {
  String title;
  double? cellWidth;
  double cellHeight;
  double fontSize;
  bool isBold;
  Color textColor;
  Alignment alignment;
  EdgeInsets padding;
  TableWidgetType widgetType;
  int flex;
  TextDecoration textDecoration;
  bool textFittedBox; //textType時 可以自適應寬度

  TableModel({
    this.title = "",
    this.cellWidth,
    this.cellHeight = 60,
    this.fontSize = 20,
    this.isBold = false,
    this.textColor = AppColors.charcoalGrey,
    this.alignment = Alignment.center,
    this.padding = EdgeInsets.zero,
    this.widgetType = TableWidgetType.textType,
    this.flex = 1,
    this.textDecoration = TextDecoration.none,
    this.textFittedBox = false,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      title:json['title'],
      cellWidth:json['cellWidth'],
      cellHeight:json['cellHeight'],
      fontSize:json['fontSize'],
      isBold:json['isBold'],
      textColor:json['textColor'],
      alignment:json['alignment'],
      padding:json['padding'],
      widgetType:json['padding'] ,
      flex:json['flex'],
      textDecoration:json['textDecoration'] ,
      textFittedBox:json['textFittedBox'],
    );
  }
}

class AppTableWidgetCommon {
  Widget getCell(TableModel model,Color bgColor) {
    return Container(
        width: model.cellWidth,
        padding: model.widgetType==TableWidgetType.richTextType ? EdgeInsets.zero : model.padding,
        alignment: model.alignment,
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: AppColors.veryLightPinkTwo),
        ),
        child: checkWidgetType(model)
    );
  }

  Widget checkWidgetType(TableModel model) {
    switch(model.widgetType) {
      case TableWidgetType.textType:
        return getText(model);
      case TableWidgetType.richTextType:
        return getRichText(model);
      default:
        return Container();
    }
  }

  Widget getText(TableModel model) {
    Widget textWidget = Text(
      model.title,
      style: AppTextStyle(
          decoration: model.textDecoration,
          fontWeight:model.isBold ? FontWeight.bold:FontWeight.normal ,
          fontSize: model.fontSize,
          color: model.textColor),
    );

    if(model.textFittedBox) {
      textWidget = FittedBox(fit: BoxFit.fitWidth,child: textWidget);
    }

    return Container(
        height: model.cellHeight,
        alignment: model.alignment,
        child: textWidget);
  }


  Widget getRichText(TableModel model) {
    List textList = model.title.indexOf(',') > -1 ? model.title.split(',') : [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for(var t in textList)
          Container(
            padding: model.padding,
            alignment: model.alignment,
            height: model.cellHeight,
            decoration: BoxDecoration(
                border: textList.indexOf(t) == textList.lastIndexOf ? Border() : Border(bottom: BorderSide(width:1,color: AppColors.veryLightPinkTwo))
            ),
            child: Text(t,style: AppTextStyle(
                decoration: model.textDecoration,
                fontWeight:model.isBold ? FontWeight.bold:FontWeight.normal ,
                fontSize: model.fontSize,
                color: model.textColor),),
          )
      ],
    );
  }


}
enum TableWidgetType {
  textType,
  richTextType,
}
