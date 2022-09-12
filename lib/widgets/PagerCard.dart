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
  late int currentPage;
  late int itemsPerPage;
  List<int> pages = [5, 10, 15, 20, 25];
  late int totalPages;
  late int totalElements = widget.data.length;
  late List pageItems;
  late int pastItems;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = pages.first;
    pastItems = itemsPerPage * (currentPage-1);
    pageItems = widget.data.sublist(pastItems,pastItems+itemsPerPage);
    totalPages = (totalElements / itemsPerPage).ceil();
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
                for(var i in pageItems)
                  widget.widgetBuilder(i)
              ]
            )
        ),
        const SizedBox(height: 32),
        Pager(
          currentPage: currentPage,
          totalPages: totalPages,
          itemsPerPageText: "每頁筆數",
          onPageChanged: (page) {
            setState(() {
              currentPage = page;
              setPage();
            });
          },
          showItemsPerPage: true,
          onItemsPerPageChanged: (perPage) {
            setState(() {
              itemsPerPage = perPage;
              totalPages = (totalElements / itemsPerPage).ceil();
              if(currentPage>totalPages){
                currentPage = 1;
              }
              setPage();
            });
          },
          itemsPerPageList: pages,
        ),
      ],
    );
  }



  void setPage(){
    pastItems = itemsPerPage * (currentPage-1);
    if(totalElements % itemsPerPage > 0 && currentPage == totalPages){
      pageItems = widget.data.sublist(pastItems);
    }else{
      pageItems = widget.data.sublist(pastItems,pastItems+itemsPerPage);
    }
  }

}

