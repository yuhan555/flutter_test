import 'package:my_test/util/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:my_test/widgets/InfoCard.dart';
import 'package:my_test/widgets/widgets.dart';
import 'package:pager/pager.dart';

typedef WidgetBuilder = Widget Function(dynamic data);

class PagerCard extends StatefulWidget {
  final List<dynamic> data;
  final WidgetBuilder widgetBuilder;

  const PagerCard({
    Key? key,
    required this.data,
    required this.widgetBuilder,
  }): super(key: key);

  @override
  State<PagerCard> createState() => _PagerCardState();
}

class _PagerCardState extends State<PagerCard> {
  late PagerModel model;
  // late int currentPage;
  // late int itemsPerPage;
  // List<int> pages = [5, 10, 15, 20, 25];
  // late int totalPages;
  // late int totalElements = widget.data.length;
  // late List pageItems;
  // late int pastItems;
  @override
  void initState() {
    model = PagerModel(widget.data);
    super.initState();
    // currentPage = 1;
    // itemsPerPage = pages.first;
    // pastItems = itemsPerPage * (currentPage-1);
    // pageItems = widget.data.sublist(pastItems,pastItems+itemsPerPage);
    // totalPages = (totalElements / itemsPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              children:[
                for(var i in model.pageItems)
                  Listener(
                    onPointerDown: (event)=> PagerModel.currentItem = i,
                    child: widget.widgetBuilder(i),
                  )
              ]
            )
        ),
        const SizedBox(height: 32),
        Pager(
          currentPage: model.currentPage!,
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
              model.totalPages = (model.totalElements / model.itemsPerPage).ceil();
              if(model.currentPage! > model.totalPages){
                model.currentPage = 1;
              }
              model.setPage();
            });
          },
          itemsPerPageList: model.pages,
        ),
      ],
    );
  }



  // void setPage(){
  //   pastItems = itemsPerPage * (currentPage-1);
  //   if(totalElements % itemsPerPage > 0 && currentPage == totalPages){
  //     pageItems = widget.data.sublist(pastItems);
  //   }else{
  //     pageItems = widget.data.sublist(pastItems,pastItems+itemsPerPage);
  //   }
  // }

}

class PagerModel{
  int? currentPage;
  List<int>? pages;
  List<dynamic> data;

  PagerModel(this.data,{this.pages = const [5, 10, 15, 20, 25], this.currentPage = 1});


  late int itemsPerPage = pages!.first;

  late List pageItems = data.sublist(pastItems,pastItems + itemsPerPage);

  late int pastItems = itemsPerPage * (currentPage!-1);

  late final int totalElements = data.length;

  late int totalPages = (totalElements / itemsPerPage).ceil();


  static late dynamic currentItem;


  void setPage(){
    pastItems = itemsPerPage * (currentPage!-1);
    if(totalElements % itemsPerPage > 0 && currentPage == totalPages){
      pageItems = data.sublist(pastItems);
    }else{
      pageItems = data.sublist(pastItems,pastItems+itemsPerPage);
    }
  }

}

