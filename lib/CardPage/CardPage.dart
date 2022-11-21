import 'package:flutter/material.dart';
import 'package:my_test/widgets/InfoCard.dart';
import 'package:my_test/widgets/PagerCard.dart';
import 'package:my_test/widgets/TabPager.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  late List data = [];

  @override
  void initState() {
    data = [{"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "dswqqq", "iName": "dswqqq", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/08/29 15:40:04", "unit": "84,444,448萬元"},
      {"id": "9982aa4d0fa79427bba1af502ebfe14a0", "caseStatus": "編輯中", "shortId": "fe1a39d0fa79427b", "aName": "王大明王大明王大明王王大明王大明王大明王王大明王大明王大明王王大明王大明王大明王王大明王大明王大明王王大明王大明王大明王", "iName": "張美美", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/03/22 15:40:04", "unit": "50萬元"},
      {"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "9982aafa79427b", "aName": "王忠明", "iName": "林花花", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/01/19 10:40:04", "unit": "90萬元"},
      {"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "dswqqq", "iName": "dswqqq", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/08/29 15:40:04", "unit": "88萬元"},
      {"id": "9982aa4d0fa79427bba1af502ebfe14a0", "caseStatus": "編輯中", "shortId": "9982aaj39232993", "aName": "王大明", "iName": "張美美", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/03/22 15:40:04", "unit": "50萬元"},
      {"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "9982aad0fa79427b", "aName": "王忠明", "iName": "林花花", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/01/19 10:40:04", "unit": "90萬元"},{"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "dswqqq", "iName": "dswqqq", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/08/29 15:40:04", "unit": "88萬元"},
      {"id": "9982aa4d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "王大明", "iName": "張美美", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/03/22 15:40:04", "unit": "50萬元"},
      {"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "編輯中", "shortId": "9982aad0fa79427b", "aName": "王忠明", "iName": "林花花", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/01/19 10:40:04", "unit": "90萬元"},{"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "dswqqq", "iName": "dswqqq", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/08/29 15:40:04", "unit": "88萬元"},
      {"id": "9982aa4d0fa79427bba1af502ebfe14a0", "caseStatus": "編輯中", "shortId": "fe1a39d0fa79427b", "aName": "王大明", "iName": "張美美", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/03/22 15:40:04", "unit": "50萬元"},
      {"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "編輯中", "shortId": "f9982aad0fa79427b", "aName": "王忠明", "iName": "林花花", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/01/19 10:40:04", "unit": "90萬元"},{"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "dswqqq", "iName": "dswqqq", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/08/29 15:40:04", "unit": "88萬元"},
      {"id": "9982aa4d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "王大明", "iName": "張美美", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/03/22 15:40:04", "unit": "50萬元"},
      {"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "編輯中", "shortId": "fe1a39d0fa79427b", "aName": "王忠明", "iName": "林花花", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/01/19 10:40:04", "unit": "90萬元"},{"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "dswqqq", "iName": "dswqqq", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/08/29 15:40:04", "unit": "88萬元"},
      {"id": "9982aa4d0fa79427bba1af502ebfe14a0", "caseStatus": "編輯中", "shortId": "f9982aa9d079427b", "aName": "王大明", "iName": "張美美", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/03/22 15:40:04", "unit": "50萬元"},
      {"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "編輯中", "shortId": "fe1a39d0fa79427b", "aName": "王忠明", "iName": "林花花", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/01/19 10:40:04", "unit": "90萬元"},{"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "dswqqq", "iName": "dswqqq", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/08/29 15:40:04", "unit": "88萬元"},
      {"id": "9982aa4d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "王大明", "iName": "張美美", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/03/22 15:40:04", "unit": "50萬元"},
      {"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe9982aaa79427b", "aName": "王忠明", "iName": "林花花", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/01/19 10:40:04", "unit": "90萬元"},{"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "dswqqq", "iName": "dswqqq", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/08/29 15:40:04", "unit": "88萬元"},
      {"id": "9982aa4d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "王大明", "iName": "張美美", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/03/22 15:40:04", "unit": "50萬元"},
      {"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "編輯中", "shortId": "f9982aa0fa79427b", "aName": "王忠明", "iName": "林花花", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/01/19 10:40:04", "unit": "90萬元"},{"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "dswqqq", "iName": "dswqqq", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/08/29 15:40:04", "unit": "88萬元"},
      {"id": "9982aa4d0fa79427bba1af502ebfe14a0", "caseStatus": "編輯中", "shortId": "fe1a39d0fa79427b", "aName": "王大明", "iName": "張美美", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/03/22 15:40:04", "unit": "50萬元"},
      {"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "編輯中", "shortId": "fe9982aa79427b", "aName": "王忠明", "iName": "林花花", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/01/19 10:40:04", "unit": "90萬元"},{"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "dswqqq", "iName": "dswqqq", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/08/29 15:40:04", "unit": "88萬元"},
      {"id": "9982aa4d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "王大明", "iName": "張美美", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/03/22 15:40:04", "unit": "50萬元"},
      {"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "編輯中", "shortId": "9982aa0fa79427b", "aName": "王忠明", "iName": "林花花", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/01/19 10:40:04", "unit": "90萬元"},{"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "dswqqq", "iName": "dswqqq", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/08/29 15:40:04", "unit": "88萬元"},
      {"id": "9982aa4d0fa79427bba1af502ebfe14a0", "caseStatus": "編輯中", "shortId": "fe1a39d0fa79427b", "aName": "王大明", "iName": "張美美", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/03/22 15:40:04", "unit": "50萬元"},
      {"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "9982aad0fa79427b", "aName": "王忠明", "iName": "林花花", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/01/19 10:40:04", "unit": "90萬元"},{"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "dswqqq", "iName": "dswqqq", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/08/29 15:40:04", "unit": "88萬元"},
      {"id": "9982aa4d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "王大明", "iName": "張美美", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/03/22 15:40:04", "unit": "50萬元"},
      {"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "編輯中", "shortId": "9982aad0fa79427b", "aName": "王忠明", "iName": "林花花", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/01/19 10:40:04", "unit": "90萬元"}];

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.all(50),
            width: 800,
            child: TabPager(data: data),
          ),
        )
    );
  }



}



