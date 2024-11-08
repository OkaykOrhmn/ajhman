import 'dart:io';
import 'package:ajhman/data/repository/download_repository.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/notification_model.dart';
import '../../services/notification_service.dart';
import '../../services/storage_handler.dart';
part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(DownloadInitial());

  Function(int, int)? _loadingNotification(
      int id, String path, String name, String type) {
    return (count, total) async {
      if (Platform.isAndroid) {
        final progress = ((count * 100) / total).round();
        if (count != total && (state as DownloadLoading).pr != progress) {
          emit(DownloadLoading(pr: progress));
          NotificationService.showNotification(NotificationData(
            id: id,
            title: "$type $name",
            body: 'درحال دانلود',
            summery: "پیشرفت: $progress%",
            notificationLayout: NotificationLayout.ProgressBar,
            notificationCategory: NotificationCategory.Progress,
            payload: {"path": path, "name": name, "id": id.toString()},
            progress: progress,
            locked: true,
          ));
        }
      }
    };
  }

  Future<void> downloadAudio(
      String url, List<String> names, String type) async {
    emit(DownloadLoading(pr: 0));
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    try {
      final path = await StorageHandler.getMediaFileDir(url, names);
      if (path == null) {
        emit(DownloadFail(error: "لطفا دسترسی هارا تایید کنید!!"));
      } else if (path == "exist") {
        emit(DownloadedAlready());
      } else {
        await downloadRepository.getAudio(
            url, path, _loadingNotification(id, path, names.last, type));
        final p = {
          "path": path,
          "name": names.last,
          "url": url,
          "id": id.toString()
        };
        await Future.delayed(
            const Duration(milliseconds: 500),
            () => NotificationService.showNotification(NotificationData(
                    id: id,
                    title: "$type ${names.last}",
                    body: 'دانلود تکمیل شد',
                    payload: p,
                    actionButtons: [
                      NotificationActionButton(
                          key: 'autoDisable',
                          label: 'بستن',
                          autoDismissible: true,
                          actionType: ActionType.DismissAction),
                    ])));
        emit(DownloadSuccess());
      }
    } catch (e) {
      String error = "خطا در برقراری ارتباط دوباره تلاش کنید!!";
      NotificationService.showNotification(NotificationData(
          id: id,
          title: "فایل صوتی کتاب ${names.last}",
          body: 'خطا در دانلود فایل',
          actionButtons: [
            NotificationActionButton(
                key: 'autoDisable',
                label: 'بستن',
                autoDismissible: true,
                actionType: ActionType.DismissAction),
          ]));

      emit(DownloadFail(error: error));
    }
  }
}
