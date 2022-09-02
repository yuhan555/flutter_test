import 'package:my_test/util/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:my_test/widgets/widgets.dart';
import 'package:pager/pager.dart';

class PagerCard extends StatefulWidget {
  late final List<dynamic> data;
  PagerCard({
    Key? key,

    // this.data = const [{"id": "fe1a39d0fa79427bba1af502ebfe14a0", "caseStatus": "待送件", "shortId": "fe1a39d0fa79427b", "aName": "dswqqq", "iName": "dswqqq", "mainIns": "FI5-06 遠雄人壽傳富新終身壽險(110)", "updateDate": "2022/08/29 15:40:04", "unit": "88萬元"}];
  }) : super(key: key){
    data =  List.generate(67, (index) => index+1);
  }

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
    return Container(
      child: ListView(
        children: [
          Column(
            children: [
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      for(var i in pageItems)
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                            children: [
                              Container(
                                width: 300,
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  boxShadow: [BoxShadow(
                                      color: AppColors.brownGreyTwo.withOpacity(0.2),
                                      offset: const Offset(0,1),
                                      blurRadius: 4,
                                      spreadRadius: 0
                                  )],
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: CustomPaint(
                                    painter: TrianglePainter(
                                      strokeColor: Colors.yellow,
                                      strokeWidth: 10,
                                      paintingStyle: PaintingStyle.fill,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.only(top:10,left: 70,right:10,bottom: 40),
                                      alignment: Alignment.topRight,
                                      child: Text(i),
                                    ),
                                  )
                              )
                            ],
                          )
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
        ],
      ),
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






class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
        this.strokeWidth = 3,
        this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(x, y)
      ..lineTo(x, 0);

  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

