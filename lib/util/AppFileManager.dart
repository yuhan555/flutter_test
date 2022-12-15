
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'AppLog.dart';


class AppFileManager{
  static Future<String> getRootDirectory() async {
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    String path = directory!.path;
    AppLog("rootPath = $path");
    return path;
  }

  /*取得暫存目錄(一進app就會刪除)*/
  static Future<String> getTempPath() async {
    var rootDirectory = await getRootDirectory();
    var path = "$rootDirectory/TEMP";

    Directory file = Directory(path);
    if (!file.existsSync())
    {
      file.createSync();
    }
    return path;
  }
}