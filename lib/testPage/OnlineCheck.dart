

import 'package:flutter/material.dart';
import 'package:my_test/widgets/widgets.dart';
import 'package:pager/pager.dart';

class OnlineCheck extends StatefulWidget {
  const OnlineCheck({Key? key}) : super(key: key);

  @override
  State<OnlineCheck> createState() => _OnlineCheckState();
}

class _OnlineCheckState extends State<OnlineCheck> {
  late int currentPage;
  late int itemsPerPage;
  List<int> pages = [5, 10, 15, 50, 100];
  late int totalPages;
  List data = List.generate(67, (index) => index+1);
  late int totalElements = data.length;
  late List pageItems;
  late int pastItems;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = pages.first;
    pastItems = itemsPerPage * (currentPage-1);
    pageItems = data.sublist(pastItems,pastItems+itemsPerPage);
    totalPages = (totalElements / itemsPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SubCard(
            title: 'Pager',
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      for(var i in pageItems)
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: Text(i.toString(),style: const TextStyle(color: Colors.white, fontSize: 18),),
                      )
                    ],
                  )
                ),
                const SizedBox(height: 32),
                Pager(
                  currentPage: currentPage,
                  totalPages: totalPages,
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
            ),
          )
        ],
      )
    );
  }

  void setPage(){
      pastItems = itemsPerPage * (currentPage-1);
      if(totalElements % itemsPerPage > 0 && currentPage == totalPages){
        pageItems = data.sublist(pastItems);
      }else{
        pageItems = data.sublist(pastItems,pastItems+itemsPerPage);
      }
  }
}
