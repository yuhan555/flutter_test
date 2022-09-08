import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test/widgets/widgets.dart';

import 'bloc/test_bloc.dart';

class PolicyHolderCorrection extends StatefulWidget {
  const PolicyHolderCorrection({Key? key}) : super(key: key);

  @override
  State<PolicyHolderCorrection> createState() => _PolicyHolderCorrectionState();
}

class _PolicyHolderCorrectionState extends State<PolicyHolderCorrection> {
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
                          controller: _testBloc.owner.name,
                          label:'要保人姓名',
                        ),
                        RadioBox(
                          radioLabel:'性別',
                          opt: const [['男','M'],['女','F']],
                          val: _testBloc.owner.sex.text,
                          optPressed: (v){
                            _testBloc.owner.sex.text = v;
                            _testBloc.add(FieldChange());
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
