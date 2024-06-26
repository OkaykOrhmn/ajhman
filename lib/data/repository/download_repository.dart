
import 'package:dio/dio.dart';

import '../api/dio_helper.dart';

final downloadRepository = DownloadRepository(DioHelper());
final CancelToken downloadCancelToken = CancelToken();

class DownloadRepository implements Download {
  final DioHelper dioHelper;

  DownloadRepository(this.dioHelper);

  @override
  Future<Response> getAudio(String url,  String path,
      Function(int, int)? progress) async {
    // try {
    final response = await dioHelper.sendRequest.download(url, path,
        cancelToken: downloadCancelToken,
        deleteOnError: true,
        onReceiveProgress: progress);
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
        onReceiveProgress: progress);
    return response;
  }
}

abstract class Download {
  Future<Response> getAudio(
      String url, String path, Function(int, int)? progress);
  Future<Response> getVideo(
      String url, String name, String path, Function(int, int)? progress);
}
