

import 'package:flutter/material.dart';
import 'package:my_test/widgets/widgets.dart';

class InsuredOwnerCorrection extends StatefulWidget {
  const InsuredOwnerCorrection({Key? key}) : super(key: key);

  @override
  State<InsuredOwnerCorrection> createState() => _InsuredOwnerCorrectionState();
}

class _InsuredOwnerCorrectionState extends State<InsuredOwnerCorrection> {
  @override
  Widget build(BuildContext context) {
    return const SubCard(
      title: '被保險人',
    );
  }
}
