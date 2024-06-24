import 'dart:io';

import 'package:ajhman/core/services/permission_handler.dart';
import 'package:ajhman/data/api/api_end_points.dart';
import 'package:ajhman/data/repository/download_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageHandler {
  static Future<Directory?> getAjhmanInAppDocDir() async {
    final a = await permissionHandler
        .requestPermission(Permission.accessMediaLocation);
    final m = await permissionHandler
        .requestPermission(Permission.manageExternalStorage);
    if (a && m) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      if (Platform.isAndroid) {
        appDocDir = (await Directory('/storage/emulated/0'))!;
      }
      final Directory appDocDirFolder = Directory('${appDocDir.path}/Ajhman');
      if (await appDocDirFolder.exists()) {
        return appDocDirFolder;
      } else {
        final Directory appDocDirNewFolder =
            await appDocDirFolder.create(recursive: true);
        return appDocDirNewFolder;
      }
    } else {
      return null;
    }
  }

  static Future<String?> createFolderInAppDocDir(String folderName) async {
    final Directory? appDocDir = await getAjhmanInAppDocDir();
    if (appDocDir == null) {
      return null;
    } else {
      final Directory appDocDirFolder =
          Directory('${appDocDir.path}/$folderName');
      if (await appDocDirFolder.exists()) {
        return appDocDirFolder.path;
      } else {
        final Directory appDocDirNewFolder =
            await appDocDirFolder.create(recursive: true);
        return appDocDirNewFolder.path;
      }
    }
  }

  static Future<String?> getMediaFileDir(String url, String name) async {
    String? dir = await createFolderInAppDocDir(name);
    if (dir == null) return null;
    String fileName = url
        .replaceAll(ApiEndPoints.baseURL, '')
        .substring(1)
        .replaceAll("/", '_');
    File file = File('$dir/$fileName');
    if (await file.exists()) {
      return "exist";
    } else {

    return file.path;
    }
  }
}
