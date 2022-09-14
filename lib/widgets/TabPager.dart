import 'package:my_test/util/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:my_test/widgets/InfoCard.dart';
import 'package:my_test/widgets/PagerCard.dart';
import 'package:my_test/widgets/widgets.dart';
import 'package:pager/pager.dart';

class TabPager extends StatefulWidget {
  final List data;
  const TabPager({
    Key? key,
    this.data = const []
  }) : super(key: key);

  @override
  State<TabPager> createState() => _TabPagerState();
}

class _TabPagerState extends State<TabPager>  with SingleTickerProviderStateMixin{
  List tabs = InsureType.values.map((e) => e.getTypeName).toList();
  late TabController _tabController;
  int selectedIndex = 0;
  void initState() {
    _tabController = TabController(
      initialIndex: selectedIndex,
      length: tabs.length,
      vsync: this,
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: ListView(
        children: [
          TabBar(
            tabs: tabs.map((e) => Tab(child: Text(e,style: TextStyle(color: Colors.black87,fontSize: 20),))).toList(),
            onTap: (int index) {
              setState(() {
                selectedIndex = index;
                _tabController.animateTo(index);
              });
            },
          ),
          IndexedStack(
            index: selectedIndex,
            children: [
              ...tabs.map((e) => getTabChildren(e)).toList(),
            ],
          ),
        ],
      )
    );
  }


  Widget getTabChildren(type){
    List tabData = widget.data.where((ele) => ele['caseStatus'] == type).toList();
    return PagerCard(data: tabData);
  }
}




enum InsureType{
  A,
  B,
  C
}

extension InsureTypeExtension on InsureType{
  String get getTypeName{
    switch(this){
      case InsureType.A:
        return "待送件";
      case InsureType.B:
        return "編輯中";
      case InsureType.C:
        return "簽名中";
      default:
        return "";
    }
  }
}