import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_test/colorMatchGame/color_match_game.dart';
import 'package:my_test/sharePage/sharePage.dart';

import 'CardPage/CardPage.dart';
import 'SlidePage/SlidePage.dart';
import 'testPage/HomePage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //設置螢幕固定橫向
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ColorMatchGame(),
    );
  }
}
