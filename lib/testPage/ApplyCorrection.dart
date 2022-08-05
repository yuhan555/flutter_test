import 'package:flutter/material.dart';
import 'package:my_test/widgets/widgets.dart';

class ApplyCorrection extends StatefulWidget {
  const ApplyCorrection({Key? key}) : super(key: key);

  @override
  State<ApplyCorrection> createState() => _ApplyCorrectionState();
}

class _ApplyCorrectionState extends State<ApplyCorrection> {
  @override
  Widget build(BuildContext context) {
    return const SubCard(
      title: '契約變更申請',
    );
  }
}
