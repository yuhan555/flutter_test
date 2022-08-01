

import 'package:flutter/material.dart';

class Photograph extends StatefulWidget {
  const Photograph({Key? key}) : super(key: key);

  @override
  State<Photograph> createState() => _PhotographState();
}

class _PhotographState extends State<Photograph> {
  @override
  Widget build(BuildContext context) {
    return Text('同意書編號/拍照');
  }
}
