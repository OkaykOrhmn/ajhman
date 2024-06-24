import 'dart:io';

import 'package:ajhman/data/repository/download_repository.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../data/model/notification_model.dart';
import '../../services/notification_service.dart';
import '../../services/storage_handler.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(DownloadInitial());

  Function(int, int)? _loadingNotification(
      int id, String path, String name, String type) {
    return (count, total) async {
      print("count: $count");
      print("total: $total");
      print("((count * 100) / total): ${((count * 100) / total)}");
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
            // actionButtons: [
            //   NotificationActionButton(
            //       key: 'cancelDownload',
            //       label: 'لغو',
            //       autoDismissible: false,
            //       actionType: ActionType.DismissAction),
            // ]
          ));
        }
      }
    };
  }

  Future<void> downloadAudio(String url, String name) async {
    emit(DownloadLoading(pr: 0));
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    try {
      final path = await StorageHandler.getMediaFileDir(url, name);
      if (path == null) {
        emit(DownloadFail(error: "لطفا دسترسی هارا تایید کنید!!"));
      } else if (path == "exist") {
        emit(DownloadedAlready());
      } else {
        await downloadRepository.getAudio(
            url, name, path, _loadingNotification(id, path, name, "فایل صوتی"));
        final p = {"path": path, "name": name, "url": url, "id": id.toString()};
        await Future.delayed(
            const Duration(milliseconds: 500),
            () => NotificationService.showNotification(NotificationData(
                    id: id,
                    title: "فایل صوتی $name",
                    body: 'دانلود تکمیل شد',
                    payload: p,
                    actionButtons: [
                      NotificationActionButton(
                          key: 'autoDisable',
                          label: 'بستن',
                          autoDismissible: true,
                          actionType: ActionType.DismissAction),
                      // NotificationActionButton(
                      //   key: 'openFile',
                      //   label: 'باز کردن فایل',
                      //   autoDismissible: true,
                      // ),
                    ])));
        emit(DownloadSuccess());
      }
    } catch (e) {
      String error = "خطا در برقراری ارتباط دوباره تلاش کنید!!";
      NotificationService.showNotification(NotificationData(
          id: id,
          title: "فایل صوتی کتاب ${name}",
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

  Future<void> downloadVideo(String url, String name) async {
    emit(DownloadLoading(pr: 0));
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    try {
      final path = await StorageHandler.getMediaFileDir(url, name);
      if (path == null) {
        emit(DownloadFail(error: "لطفا دسترسی هارا تایید کنید!!"));
      } else if (path == "exist") {
        emit(DownloadedAlready());
      } else {
        final response = await downloadRepository.getVideo(
            url, name, path, _loadingNotification(id, path, name, "فایل صوتی"));
        File file = File(path);
        var raf = file.openSync(mode: FileMode.write);
        // response.data is List<int> type
        raf.writeFromSync(response.data);
        await raf.close();
        final p = {"path": path, "name": name, "url": url, "id": id.toString()};
        await Future.delayed(
            const Duration(milliseconds: 500),
            () => NotificationService.showNotification(NotificationData(
                    id: id,
                    title: "فایل صوتی $name",
                    body: 'دانلود تکمیل شد',
                    payload: p,
                    actionButtons: [
                      NotificationActionButton(
                          key: 'autoDisable',
                          label: 'بستن',
                          autoDismissible: true,
                          actionType: ActionType.DismissAction),
                      // NotificationActionButton(
                      //   key: 'openFile',
                      //   label: 'باز کردن فایل',
                      //   autoDismissible: true,
                      // ),
                    ])));
        emit(DownloadSuccess());
      }
    } catch (e) {
      String error = "خطا در برقراری ارتباط دوباره تلاش کنید!!";
      NotificationService.showNotification(NotificationData(
          id: id,
          title: "فایل صوتی کتاب ${name}",
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
