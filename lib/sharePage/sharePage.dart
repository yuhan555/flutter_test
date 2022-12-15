
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_test/util/AppFileManager.dart';
import 'package:my_test/widgets/widgets.dart';
import 'package:share_plus/share_plus.dart';

class SharePage extends StatefulWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  late List imgList;
  int? selected;

  @override
  void initState() {
    imgList = ['ethnicGroup_1.png','ethnicGroup_2.png','ethnicGroup_3.png'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(imgList.length, (index) => GestureDetector(
                  onTap: (){
                    selected = index;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(border: Border.all(width: 2,color: selected == index ? Colors.green : Colors.transparent)),
                    child: Image.asset('assets/img/${imgList[index]}',width: 80,height: 80,fit: BoxFit.contain,),
                  ),
                ),)
            ),
            Builder(
              builder: (BuildContext context) {
                return PrimaryButton(
                  label:'分享',
                  onPressed: (){
                    if(selected!=null){
                      sharePic(context);
                    }else{
                      showDialog(
                        context: context,
                        barrierDismissible: false, //点击遮罩不关闭对话框
                        builder: (context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Text('請選擇圖片'),
                                ),
                                PrimaryButton(
                                  label: 'OK',
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                    // sharePic(context);
                  },
                );
              },
            ),

          ],
        ),
      ),
    );
  }

  void sharePic(BuildContext context) async{
    final box = context.findRenderObject() as RenderBox?;
    ByteData bytes = await rootBundle.load( 'assets/img/${imgList[selected!]}');
    var buffer = bytes.buffer;
    String imgBase64 = base64.encode(Uint8List.view(buffer));
    var dir =  await AppFileManager.getTempPath();
    File file = File("$dir/thePic.jpg");
    await file.writeAsBytes(base64Decode(imgBase64));
    var filePath = file.path;
    Share.shareXFiles([XFile(filePath)],subject:'Great picture!',text: 'Great picture!',sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}


