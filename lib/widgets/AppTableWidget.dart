
import 'package:my_test/widgets/widgets.dart';
import 'package:my_test/base/BaseState.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppTableWidget extends StatefulWidget {
    // TableWidget() : super();
    List<TableWidgetModel>? headerList;
    List<List<TableWidgetModel>>? contentList;
    List<TableWidgetModel>?footerList;

    Color headerBgColor;
    Color contentOddBgColor; ///奇數
    Color contentEvenBgColor; /// 偶數
    bool canScroll; ///可否左右滑動(若為true，則所有TableWidgetModel皆須給寬)
    double? contentHeight; ///若有高度表頭固定，內容可滑動

    AppTableWidget(
        {
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
    State createState() => _AppTableWidgetState();
}

class _AppTableWidgetState extends BaseState<AppTableWidget> with AppTableWidgetCommon {

    @override
    Widget buildViews(BuildContext context) {
        Widget tableWidget = Column(children: [
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
                            child:
                            getCell(
                                model,
                                bgColor
                            )),
                ]
            )
        );
    }

    @override
    void initViewState() {
        // TODO: implement initViewState
    }
}

class TableWidgetModel {
    String title;
    double? cellWidth;
    double cellHeight;
    double fontSize;
    bool isBold;
    Color textColor;
    Alignment alignment;
    EdgeInsets padding;
    Function(SortType?)? onSortTap;
    void Function()? onTap;
    TableWidgetType widgetType;
    int flex;
    Color buttonBgColor;
    TextDecoration textDecoration;
    SortType sortType;
    bool hasChecked;
    Function? onCheck;
    int? uId;
    String? radioOpt;
    String? radioVal;
    Function? radioOnChange;
    bool isCheck;
    bool textFittedBox; //textType時 可以自適應寬度

    TableWidgetModel({
        this.title = "",
        this.cellWidth,
        this.cellHeight = 60,
        this.fontSize = 20,
        this.isBold = false,
        this.textColor = AppColors.charcoalGrey,
        this.alignment = Alignment.center,
        this.padding =  EdgeInsets.zero,
        this.widgetType = TableWidgetType.textType,
        this.flex = 1,
        this.buttonBgColor = AppColors.tealish,
        this.textDecoration = TextDecoration.none,
        this.sortType = SortType.none,
        this.onCheck,
        this.hasChecked = false,
        this.onTap,
        this.uId,
        this.radioVal,
        this.radioOpt,
        this.radioOnChange,
        this.isCheck = true,
        this.textFittedBox = false,
    });
}

class AppTableWidgetCommon {
    Widget getCell(TableWidgetModel model,Color bgColor)
    {
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

    Widget checkWidgetType(TableWidgetModel model)
    {
        switch(model.widgetType)
        {
            case TableWidgetType.textType:
                return getText(model);
            case TableWidgetType.buttonType:
                return getButton(model);
            case TableWidgetType.richTextType:
                return getRichText(model);
            case TableWidgetType.textIcon:
                return getTextIcon(model);
            case TableWidgetType.checkBox:
                return getCheckBox(model);
            case TableWidgetType.radioBox:
                return getRadioBox(model);
                case TableWidgetType.checkIcon:
                return getCheckIcon(model);
            default:
                return Container();
        }
    }

    Widget getText(TableWidgetModel model)
    {
        Widget textWidget = Text(
            model.title,
            style: AppTextStyle(
            decoration: model.textDecoration,
            fontWeight:model.isBold ? FontWeight.bold:FontWeight.normal ,
            fontSize: model.fontSize,
            color: model.textColor),);

        if(model.textFittedBox) {
            textWidget = FittedBox(fit: BoxFit.fitWidth,child: textWidget);
        }

        return Container(
            height: model.cellHeight,
            alignment: model.alignment,
            child: GestureDetector(
                onTap: model.onTap!,
                child: textWidget,
            ));
    }

    Widget getButton(TableWidgetModel model)
    {
        return Container(
            height: model.cellHeight,
            alignment: model.alignment,
            margin: EdgeInsets.only(left: 8,right: 8),
            child: PrimaryButton(
                padding : EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                label: model.title,
                color: model.buttonBgColor,
                onPressed: model.onTap!,
                fontSize: model.fontSize,
            ),
        );
    }

    Widget getRichText(TableWidgetModel model)
    {
        List textList = model.title.indexOf(',') >-1 ? model.title.split(',') : [];
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

    Widget getTextIcon(TableWidgetModel model)
    {
        return Container(
            height: model.cellHeight,
            alignment: model.alignment,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Expanded(
                        child: Text(
                            model.title,
                            textAlign: TextAlign.center,
                            style: AppTextStyle(
                                decoration: model.textDecoration,
                                fontWeight:model.isBold ? FontWeight.bold:FontWeight.normal ,
                                fontSize: model.fontSize,
                                color: model.textColor),),
                    ),
                    Visibility(
                        visible: model.widgetType == TableWidgetType.textIcon,
                        child: GestureDetector(
                            onTap: (){
                                if(model.onSortTap != null){
                                    model.onSortTap!((model.sortType == SortType.none || model.sortType == SortType.desc) ? SortType.asc : SortType.desc);
                                }
                            },
                          child: Container(
                              alignment: Alignment.centerRight,
                              child: Icon(model.sortType.iCon, color: AppColors.white)
                          ),
                        ),
                    )
                ],
            ));
    }

    Widget getCheckBox(TableWidgetModel model)
    {
        return Container(
            height: model.cellHeight,
            alignment: model.alignment,
            child: InsCheckNoVal(
                isChecked: model.hasChecked,
                onCheck: model.onCheck!,
            ),
        );
    }

    Widget getCheckIcon(TableWidgetModel model)
    {
        return Container(
            height: model.cellHeight,
            alignment: model.alignment,
            child: Visibility(
                visible: model.isCheck,
                child: Icon(
                    Icons.check_circle,
                    color: Color(0xFF26ACA9),
                    size: 34,
                ),
            ),
        );
    }

    Widget getRadioBox(TableWidgetModel model)
    {
        return Container(
            height: model.cellHeight,
            alignment: model.alignment,
            child: RadiusNoWordBox(
                onChange: model.radioOnChange!,
                val: model.radioVal!,
                opt: model.radioOpt!,
            ),
        );
    }


}
enum TableWidgetType
{
    textType,
    buttonType,
    richTextType,
    textIcon,
    checkBox,
    radioBox,
    checkIcon,
}
enum SortType {
    none, //沒有
    asc, //正序
    desc //倒序
}

extension SortTypeExtension on SortType {
    IconData get iCon {
        switch (this) {
            case SortType.none:
                return Icons.unfold_more;
            case SortType.asc:
                return Icons.expand_more;
            case SortType.desc:
                return Icons.expand_less;
            default:
                return Icons.unfold_more;
        }
    }
}