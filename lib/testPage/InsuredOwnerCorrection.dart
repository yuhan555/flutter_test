import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test/widgets/widgets.dart';

import 'bloc/test_bloc.dart';

class InsuredOwnerCorrection extends StatefulWidget {
  const InsuredOwnerCorrection({Key? key}) : super(key: key);

  @override
  State<InsuredOwnerCorrection> createState() => _InsuredOwnerCorrectionState();
}

class _InsuredOwnerCorrectionState extends State<InsuredOwnerCorrection> {
  late TestBloc _testBloc;
  @override
  void initState() {
    _testBloc = BlocProvider.of<TestBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TestBloc, TestState>(
      listener: (context, state) {
        // TODO: implement listener}
      },
      child:BlocBuilder<TestBloc, TestState>(
        builder: (BuildContext context,TestState state){
          return Scaffold(
            body: ListView(
              children: [
                SubCard(
                  child: Column(
                    children: [
                      InsTextField(
                        controller: _testBloc.policy.name,
                        label:'被保人姓名',
                      ),
                      RadioBox(
                        radioLabel:'性別',
                        opt: const [['男','M'],['女','F'],['不告知','N']],
                        val: _testBloc.policy.sex.text,
                        optPressed: (v){
                          _testBloc.policy.sex.text = v;
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      )
    );
  }
}
