

import 'package:flutter/material.dart';
import 'package:my_test/widgets/widgets.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    return const SubCard(
      title: '上傳',
    );
  }
}
