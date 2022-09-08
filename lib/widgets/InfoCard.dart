import 'package:my_test/util/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:my_test/widgets/widgets.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

class InfoCard extends StatefulWidget {
  final dynamic data;

  const InfoCard({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    final realData = InsInfo.fromJson(widget.data);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 4, //陰影模糊程度
              spreadRadius: 0.3//陰影擴散程度
          )
        ],
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]!),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text('案件模式：一般',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 18),),
                              ),
                              Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child:Container(
                                            decoration: BoxDecoration(
                                              border: RDottedLineBorder(
                                                  right: const BorderSide(
                                                    color: Colors.grey,
                                                  )),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10),
                                                  alignment:Alignment.centerLeft,
                                                  child: Text('要保人',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 20)),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                      alignment:Alignment.topRight,
                                                      padding: EdgeInsets.symmetric(horizontal: 14),
                                                      child: Text(realData.aName!,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 20)),
                                                    )
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child:Container(
                                            decoration: BoxDecoration(
                                              border: RDottedLineBorder(
                                                  right: const BorderSide(
                                                    color: Colors.grey,
                                                  )),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(left:14,bottom: 10),
                                                  alignment:Alignment.centerLeft,
                                                  child: Text('被保險人',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 20)),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                      padding:  EdgeInsets.symmetric(horizontal: 14),
                                                      alignment:Alignment.topRight,
                                                      child: Text(realData.iName!,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 20)),
                                                    )
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 260,
                                          decoration: BoxDecoration(
                                            border: RDottedLineBorder(
                                                right: const BorderSide(
                                                  color: Colors.grey,
                                                )),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left:14,bottom: 10),
                                                alignment:Alignment.centerLeft,
                                                child: Text('主約',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 20)),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                    padding:  EdgeInsets.symmetric(horizontal: 14),
                                                    alignment:Alignment.topRight,
                                                    child: Text(realData.mainIns!,textAlign:TextAlign.right,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 20)),
                                                  )
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child:Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(left:14,bottom: 10),
                                                  alignment:Alignment.centerLeft,
                                                  child: Text('保額',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 20)),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                      padding:  EdgeInsets.symmetric(horizontal: 14),
                                                      alignment:Alignment.topRight,
                                                      child: Text(realData.unit!,textAlign:TextAlign.right,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 20)),
                                                    )
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          ),
                        )
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('異動時間：${realData.updateDate!}',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 22),),
                              Text('案件編號：${realData.shortId!}',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 20),)
                            ],
                          ),
                          Row(
                            children: [
                              PrimaryButton(
                                  label: '編輯',color: Colors.red,minWidth: 70,margin:EdgeInsets.only(right: 6),onPressed: (){},
                              ),
                              PrimaryButton(label: '檢視',color: Colors.grey,minWidth: 60,margin:EdgeInsets.only(right: 6)),
                              PrimaryButton(label: '複製',color: Colors.grey,minWidth: 60,margin:EdgeInsets.only(right: 6)),
                              PrimaryButton(label: '刪除',color: Colors.grey,minWidth: 60,),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: CustomPaint(
                    painter: TrianglePainter(
                      strokeColor: Colors.red,
                      strokeWidth: 10,
                      paintingStyle: PaintingStyle.fill,
                    ),
                    child: Container(
                      width: 130,
                      height: 110,
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(top:16,right: 10),
                      child: Text(realData.caseStatus!,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20,letterSpacing:1.1),),
                    ),
                  )
              )
            ],
          )
      ),
    );
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


class InsInfo {
  String? aName;
  String? iName;
  String? mainIns;
  String? updateDate;
  String? unit;
  String? caseStatus;
  String? shortId;

  InsInfo(
      {this.aName,
        this.iName,
        this.mainIns,
        this.updateDate,
        this.unit,
        this.caseStatus,
        this.shortId});

  InsInfo.fromJson(Map<String, dynamic> json) {
    aName = json['aName'] ?? '';
    iName = json['iName'] ?? '';
    mainIns = json['mainIns'] ?? '';
    updateDate = json['updateDate'] ?? '';
    unit = json['unit'] ?? '';
    caseStatus = json['caseStatus'] ?? '';
    shortId = json['shortId'] ?? '';
  }
}

