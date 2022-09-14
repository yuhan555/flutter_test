import 'package:my_test/util/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:my_test/widgets/InfoCard.dart';
import 'package:my_test/widgets/widgets.dart';
import 'package:pager/pager.dart';

typedef WidgetBuilder = Widget Function(dynamic data);

class PagerCard extends StatefulWidget {
  final List<dynamic> data;
  final bool usePager;
  final PagerModel? pagerModel;
  // final WidgetBuilder widgetBuilder;

  const PagerCard({
    Key? key,
    required this.data,
    this.usePager = true,
    this.pagerModel,
    // required this.widgetBuilder,
  }): super(key: key);

  @override
  State<PagerCard> createState() => _PagerCardState();
}

class _PagerCardState extends State<PagerCard> {
  late PagerModel model;

  @override
  void initState() {
    model = widget.pagerModel ?? PagerModel();
    model.data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.usePager ? Column(
      children: [
        widget.data.isNotEmpty ?
        Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              children:[
                for(var i in model.pageItems)
                  Listener(
                    onPointerDown: (event)=> model.currentItem = i,
                    child: InfoCard(data:i),
                  )
              ]
            )
        ) : Container(width: double.infinity,height:500,child: Center(child: Text('查無資料'),)),
        const SizedBox(height: 32),
        Pager(
          currentPage: model.currentPage,
          totalPages: model.totalPages,
          itemsPerPageText: "每頁筆數",
          totalItems: model.totalElements,
          onPageChanged: (page) {
            setState(() {
              model.currentPage = page;
              model.setPage();
            });
          },
          showItemsPerPage: true,
          onItemsPerPageChanged: (perPage) {
            setState(() {
              model.itemsPerPage = perPage;
              if(widget.data.isNotEmpty){
                model.totalPages = (model.totalElements / model.itemsPerPage).ceil();
                if(model.currentPage > model.totalPages){
                  model.currentPage = 1;
                }
                model.setPage();
              }
            });
          },
          itemsPerPageList: model.pages,
        ),
      ],
    ) : Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
            children:[
              for(var i in widget.data)
                Listener(
                  onPointerDown: (event)=> model.currentItem = i,
                  child: InfoCard(data:i),
                )
            ]
        )
    );
  }

}

class PagerModel{
  late List<dynamic> data;

  List<int> pages = [5, 10, 15, 20, 25];

  int currentPage = 1;

  late int itemsPerPage = pages.first;

  late List pageItems = data.sublist(pastItems,pastItems + itemsPerPage);

  late int pastItems = itemsPerPage * (currentPage-1);

  late final int totalElements = data.length;

  late int totalPages = data.isNotEmpty ? (totalElements / itemsPerPage).ceil() : 1;


  late Map<dynamic,dynamic> currentItem = {};


  void setPage(){
    pastItems = itemsPerPage * (currentPage-1);
    if(totalElements % itemsPerPage > 0 && currentPage == totalPages){
      pageItems = data.sublist(pastItems);
    }else{
      pageItems = data.sublist(pastItems,pastItems+itemsPerPage);
    }
  }

}


