

import 'package:flutter/material.dart';
import 'package:my_test/widgets/widgets.dart';

class PreviewSignature extends StatefulWidget {
  const PreviewSignature({Key? key}) : super(key: key);

  @override
  State<PreviewSignature> createState() => _PreviewSignatureState();
}

class _PreviewSignatureState extends State<PreviewSignature> {
  @override
  Widget build(BuildContext context) {
    return const SubCard(
      title: '預覽簽名',
    );
  }
}
