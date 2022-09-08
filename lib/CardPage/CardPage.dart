

import 'package:flutter/material.dart';
import 'package:my_test/widgets/InfoCard.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.all(50),
            width: 900,
            child: ListView(
              children: const [
                InfoCard()

              ],
            ),
          ),
        )
    );
  }
}
