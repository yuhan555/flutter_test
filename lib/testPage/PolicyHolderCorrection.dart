

import 'package:flutter/material.dart';
import 'package:my_test/widgets/widgets.dart';

class PolicyHolderCorrection extends StatefulWidget {
  const PolicyHolderCorrection({Key? key}) : super(key: key);

  @override
  State<PolicyHolderCorrection> createState() => _PolicyHolderCorrectionState();
}

class _PolicyHolderCorrectionState extends State<PolicyHolderCorrection> {
  @override
  Widget build(BuildContext context) {
    return const SubCard(
      title: '要保人',
    );
  }
}
