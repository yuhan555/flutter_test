import 'package:flutter/cupertino.dart';
export 'package:my_test/util/AppColors.dart';
export 'package:my_test/util/AppLog.dart';
export 'package:my_test/util/AppTextStyle.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  @override
  void initState() {
    initViewState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildViews(context);
  }

  /*關閉鍵盤*/
  void hideKeyboard()
  {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void initViewState();

  Widget buildViews(BuildContext context);
}
