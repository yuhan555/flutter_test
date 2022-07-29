import 'package:flutter/material.dart';
import 'package:my_test/extension/WidgetExtension.dart';
import 'package:my_test/widgets/widgets.dart';

import 'util/AppLog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap:  () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: Container(
              padding: const EdgeInsets.all(50),
              child: Column(
                children: [
                  Expanded(
                      child: ListView(
                        children: [
                          SubCard(
                            title: 'My Test',
                            child: Column(
                              children: [
                                const InsTextField(
                                  label: "姓名",
                                ).addBottomMargin(bottom: 20),
                                PrimaryButton(
                                  label: "送出",
                                  color: Colors.redAccent,
                                  onPressed: (){
                                    AppLog('送出按鈕');
                                  },
                                ).addBottomMargin(bottom: 20),
                              ],
                            ),
                          )
                        ],
                      )
                  )
                ],
              )
          ),
        ),
      )

    );
  }
}
