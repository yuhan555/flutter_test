import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test/testPage/HomePage.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  // TestBloc() : super(TestInitial()) {
  //   on<TestEvent>((event, emit) {
  //     // TODO: implement event handler
  //   });
  // }
  BookMarkType nowPage = BookMarkType.ContractChange;

  TestBloc() : super(TestInitial());

  TestState get initialState => TestInitial();


  ///Stream
  Stream<TestState> mapEventToState(TestEvent event) async* {
    if(event is InitData){
      yield* _mapInitDataToState();
    }else if(event is ClickPage){
      yield* _mapClickPageToState(event);
    }
  }










  Stream<TestState> _mapInitDataToState() async*{
    yield ActivePage(bookMark: nowPage);
  }


  Stream<TestState> _mapClickPageToState(ClickPage event) async*{
    BookMarkType nextPage = event.clickNext! ? getNextPage(getRemarkTitle() ,nowPage) : event.bookMark!;
    nowPage = nextPage;
    yield ActivePage(bookMark: nowPage);
  }






  ///取得所有頁籤陣列
  List<List<BookMarkType>> getRemarkTitle(){
    // List<BookMarkType> hidePage = getHidePage();

    List<List<BookMarkType>> bookMark = [
      [BookMarkType.ContractChange],
      [
        BookMarkType.EditApplication,
        BookMarkType.InsuredOwner,
        BookMarkType.PolicyHolder,
      ],
      [BookMarkType.OnlineCheck],
      [BookMarkType.PreviewSignature],
      [BookMarkType.Photograph],
      [BookMarkType.Upload],
    ];
    // bookMark.removeWhere((e){
    //   e.removeWhere((ele) => hidePage.contains(ele));
    //   return e.isEmpty;
    // });
    return bookMark;
  }

  ///取得下一頁
  BookMarkType getNextPage(List<List<BookMarkType>> allPages, BookMarkType nowPage){
    List<BookMarkType> pageList = allPages.expand((element) => element).toList();
    final List<BookMarkType> groupFirstPage = [];
    for(var p in allPages){
      if(p.length > 1){
        groupFirstPage.add(p.first);
      }
    }

    final index = pageList.indexOf(nowPage);

    if(index+1 >= pageList.length){
      return nowPage;
    }

    if(groupFirstPage.contains(pageList[index + 1])){
      getNextPage(allPages,pageList[index + 1]);
    }

    return pageList[index + 1];
  }


}
