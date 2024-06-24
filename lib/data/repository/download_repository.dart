import 'dart:io';

import 'package:ajhman/core/services/notification_service.dart';
import 'package:ajhman/data/model/notification_model.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../core/services/storage_handler.dart';
import '../../gen/assets.gen.dart';
import '../api/dio_helper.dart';

final downloadRepository = DownloadRepository(DioHelper());
final CancelToken downloadCancelToken = CancelToken();

class DownloadRepository implements Download {
  final DioHelper dioHelper;

  DownloadRepository(this.dioHelper);

  @override
  Future<Response> getAudio(String url, String name, String path,
      Function(int, int)? progress) async {
    // try {
    final response = await dioHelper.sendRequest.download(url, path,
        cancelToken: downloadCancelToken,
        deleteOnError: true,
        onReceiveProgress: await progress);
    return response;
    // } catch (e) {
    //   rethrow;
    // }
  }

  @override
  Future<Response> getVideo(String url, String name, String path, Function(int p1, int p2)? progress) async{
    final response = await dioHelper.sendRequest.get(url,
        cancelToken: downloadCancelToken,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
        onReceiveProgress: await progress);
    return response;
  }
}

abstract class Download {
  Future<Response> getAudio(
      String url, String name, String path, Function(int, int)? progress);
  Future<Response> getVideo(
      String url, String name, String path, Function(int, int)? progress);
}
