import 'package:flutter/cupertino.dart';

class AppLog
{
    //Applog不需傳line
    //AppUtils.log需傳入line
    factory AppLog(Object value,{int line = 4}) =>_getInstance(value,line);

    static AppLog? _instance;

    AppLog._() {
        // 初始化
    }
    static AppLog _getInstance(Object value,int line) {
        _instance ??= AppLog._();
        _instance!._print(value,line);
        return _instance!;
    }

    void _print(Object value,int? line)
    {
        line ??= 1;
        Iterable<String> lines =
        StackTrace.current.toString().trimRight().split('\n');
        lines = lines.take(line);
        String logLine = lines.last.replaceAll("#${line - 1}", "").trim();
        debugPrint('$logLine ${value.toString()}');
    }
}