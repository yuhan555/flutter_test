import 'package:my_test/util/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:my_test/widgets/widgets.dart';

class InfoCard extends StatefulWidget {
  const InfoCard({Key? key}) : super(key: key);

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                boxShadow: [BoxShadow(
                    color: AppColors.brownGreyTwo.withOpacity(0.2),
                    offset: const Offset(0,1),
                    blurRadius: 4,
                    spreadRadius: 0
                )],
              ),
              child: Column(
                children: [
                  Container(
                    height: 240,
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child:Container(
                            decoration: const BoxDecoration(
                                border: Border(right: BorderSide(color: Colors.grey))
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(right: BorderSide(color: Colors.grey))
                          ),
                        ),
                        Expanded(
                          child:Container(
                            decoration: const BoxDecoration(
                                border: Border(right: BorderSide(color: Colors.grey))
                            ),
                          ),
                        ),
                        Expanded(
                          child:Container(

                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: GestureDetector(
                          onTap: (){
                            print('tap');
                          },
                          child: PrimaryButton(label: '按鈕'),
                        ),
                    )
                  ),
                ],
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
                    width: 130,
                    height: 140,
                    alignment: Alignment.topRight,
                    child: Text('編輯中'),
                  ),
                )
            )
          ],
        )
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
