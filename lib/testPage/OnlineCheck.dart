

import 'package:flutter/material.dart';
import 'package:my_test/widgets/widgets.dart';

class OnlineCheck extends StatefulWidget {
  const OnlineCheck({Key? key}) : super(key: key);

  @override
  State<OnlineCheck> createState() => _OnlineCheckState();
}

class _OnlineCheckState extends State<OnlineCheck> {
  @override
  Widget build(BuildContext context) {
    return const SubCard(
      title: '線上檢核',
    );
  }
}
