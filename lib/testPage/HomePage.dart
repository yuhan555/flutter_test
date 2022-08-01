import 'package:flutter/material.dart';
import 'package:my_test/extension/WidgetExtension.dart';
import 'package:my_test/testPage/ApplyCorrection.dart';
import 'package:my_test/testPage/InsuredOwnerCorrection.dart';
import 'package:my_test/testPage/OnlineCheck.dart';
import 'package:my_test/testPage/Photograph.dart';
import 'package:my_test/testPage/PolicyHolderCorrection.dart';
import 'package:my_test/testPage/PreviewSignature.dart';
import 'package:my_test/testPage/Upload.dart';
import 'package:my_test/testPage/bloc/test_bloc.dart';
import 'package:my_test/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../util/AppColors.dart';
import '../util/AppLog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TestBloc _testBloc = TestBloc();
  late Widget showPage;


  @override
  void initState(){
    _testBloc.add(InitData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final cWidth = screenSize.width;
    final cHeight = screenSize.height;

    return Scaffold(
      body: GestureDetector(
        onTap:  () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BlocProvider<TestBloc>(
          create: (context) => _testBloc,
          child: BlocListener<TestBloc,TestState>(
              listener: (BuildContext context,TestState state){
                if(state is ActivePage){
                  showPage = getPageWidget(state);
                }
          },
          child: BlocBuilder<TestBloc,TestState>(
              builder: (BuildContext context, TestState state) {
                if(state is TestInitial){
                  return Container();
                }else{
                  return Center(
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                width: cWidth * 0.25,
                                child: BookMark(
                                  pageList: _testBloc.getRemarkTitle(),
                                  focusPage: _testBloc.nowPage,
                                  callback: (bookMark){
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    Future.delayed(const Duration(milliseconds: 10), () async{
                                      _testBloc.add(ClickPage(bookMark:bookMark));
                                    });
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: cWidth - cWidth * 0.25,
                              padding: EdgeInsets.symmetric(horizontal: cWidth * 0.02),
                              child: Column(
                                children: [
                                  Expanded(child: showPage),
                                  Visibility(
                                    visible: _testBloc.nowPage.showNextButton,
                                    child: PrimaryButton(
                                        label: '下一步',
                                        color: const Color(0xff26aca9),
                                        margin: const EdgeInsets.symmetric(vertical: 20),
                                        onPressed: (){
                                          FocusScope.of(context).requestFocus(FocusNode());
                                          Future.delayed(const Duration(milliseconds: 10), () async{
                                            _testBloc.add(ClickPage(clickNext: true));
                                          });
                                        }
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                  );
                }
              })
          ),
        )
      )

    );
  }
}


Widget getPageWidget(ActivePage activePage){
  switch (activePage.bookMark) {
    case BookMarkType.ContractChange:
      return ApplyCorrection();
    case BookMarkType.EditApplication:
      return Container();
    case BookMarkType.InsuredOwner:
      return InsuredOwnerCorrection();
    case BookMarkType.PolicyHolder:
      return PolicyHolderCorrection();
    case BookMarkType.OnlineCheck:
      return OnlineCheck();
    case BookMarkType.PreviewSignature:
      return PreviewSignature();
    case BookMarkType.Photograph:
      return Photograph();
    case BookMarkType.Upload:
      return Upload();
    default:
      return Container();
  }
}



enum BookMarkType{
  ContractChange, //契約變更申請
  EditApplication, //編輯批改申請書
  InsuredOwner, //被保險人
  PolicyHolder, //要保人
  OnlineCheck, //線上檢核
  PreviewSignature, //預覽簽名
  Photograph, //同意書編號/拍照
  Upload, //上傳
}

extension BookMarkTypeExtension on BookMarkType {
  String get getPageName {
    switch (this) {
      case BookMarkType.ContractChange:
        return "契約變更申請";
      case BookMarkType.EditApplication:
        return "編輯批改申請書";
      case BookMarkType.InsuredOwner:
        return "被保險人";
      case BookMarkType.PolicyHolder:
        return "要保人";
      case BookMarkType.OnlineCheck:
        return "線上檢核";
      case BookMarkType.PreviewSignature:
        return "預覽簽名";
      case BookMarkType.Photograph:
        return "同意書編號/拍照";
      case BookMarkType.Upload:
        return "上傳";
      default:
        return "";
    }
  }

  bool get showNextButton{
    switch (this) {
      case BookMarkType.OnlineCheck:
      case BookMarkType.PreviewSignature:
      case BookMarkType.Photograph:
      case BookMarkType.Upload:
        return false;
      default:
        return true;
    }
  }
}

typedef BookMarkTypeClosure = void Function(BookMarkType bookMarkType);

class BookMark extends StatefulWidget {
  final List<List<BookMarkType>> pageList; //所有頁籤
  final BookMarkType? focusPage; //所在的頁籤(顏色為深色)
  final Map<BookMarkType, int> errCountMap; //頁籤對應錯誤訊息Map
  final BookMarkTypeClosure? callback; //回傳點擊之頁籤

  const BookMark({
    Key? key,
    this.pageList = const [],
    this.focusPage,
    this.errCountMap = const {},
    this.callback,
  }): super(key: key);
  @override
  _BookMarkState createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.pageList.length, (i) => getTitleWidget(i, widget.pageList[i])) ,
    );
  }

  int getErrCount(BookMarkType bookMarkType){
    return widget.errCountMap.containsKey(bookMarkType) ? widget.errCountMap[bookMarkType]! : 0;
  }

  void doCallBack(BookMarkType bookMarkType){
    if(widget.callback != null){
      widget.callback!(bookMarkType);
    }
  }

  ///取得大頁籤widget
  Widget getTitleWidget(int index, List<BookMarkType> bookMarkType){
    final screenSize = MediaQuery.of(context).size;
    final cHeight = screenSize.height;
    BookMarkType mainPageType = bookMarkType.first;
    bool isFocusMainPage;
    isFocusMainPage = bookMarkType.contains(widget.focusPage);
    int errCount = getErrCount(mainPageType);
    return Padding(
      padding: EdgeInsets.only(bottom: cHeight * 0.012),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              if(bookMarkType.length == 1){
                doCallBack(mainPageType);
              }
            },
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Color(0xffdd5c2f)),
                  width: 45,
                  height: 45,
                  child: Text(index.toString(),
                      style: const TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                      )),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10),
                    height: 45,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffff9934),
                        width: 1,
                      ),
                      color: isFocusMainPage
                          ? AppColors.dustyOrange
                          : Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: const Radius.circular(5),
                        bottomRight: bookMarkType.length > 1 ? const Radius.circular(0) : const Radius.circular(5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(mainPageType.getPageName,
                            style: TextStyle(
                              color: isFocusMainPage ? const Color(0xffffffff) : const Color(0xff373a3c),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0,
                            )),
                        Visibility(
                          visible: errCount != 0,
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            alignment: Alignment.center,
                            width: 35,
                            height: 35,
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                                color: Color(0xFFD0021B),
                                borderRadius: BorderRadius.all(Radius.circular(50))
                            ),
                            child: Text(errCount.toString(),style: const TextStyle(color: Colors.white,fontSize: 20),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...getSubTitleWidgetList(bookMarkType),
        ],
      ),
    );
  }

  ///取得小頁籤widget陣列
  List<Widget> getSubTitleWidgetList(List<BookMarkType> bookMarkType){
    if(bookMarkType.length <= 1) return [];
    List<BookMarkType> bookMarkList = bookMarkType;
    List<BookMarkType> subBookMarkList = bookMarkList.skip(1).toList();
    return List.generate(subBookMarkList.length, (index) => getSubTitleWidget(subBookMarkList[index]));
  }

  ///取得小頁籤widget
  Widget getSubTitleWidget(BookMarkType bookMarkType){
    int errCount = getErrCount(bookMarkType);
    return Container(
        height: 45,
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 1.0,
              color: Color(0xffff9934),
            ),
            bottom: BorderSide(
              width: 1.0,
              color: Color(0xffff9934),
            ),
          ),
        ),
        child: FlatButton(
          padding: const EdgeInsets.only(left: 55),
          color: widget.focusPage == bookMarkType ? const Color(0xffffe8d0) : Colors.white,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(bookMarkType.getPageName,
                  style: const TextStyle(
                    color: Color(0xff373a3c),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0,
                  )),
              Visibility(
                visible: errCount != 0,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  width: 35,
                  height: 35,
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      color: Color(0xFFD0021B),
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  child: Text(errCount.toString(),style: const TextStyle(color: Colors.white,fontSize: 20),),
                ),
              ),
            ],
          ),
          onPressed:  () {
            doCallBack(bookMarkType);
          },
        ));
  }
}
