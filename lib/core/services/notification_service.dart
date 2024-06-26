import 'package:ajhman/data/model/notification_model.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';

import '../../data/api/api_end_points.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelKey: 'high_important_channel',
              channelGroupKey: 'high_important_channel',
              channelName: 'Basic Notification',
              channelDescription: 'Notification channel',
              defaultColor: primaryColor,
              ledColor: Colors.white,
              importance: NotificationImportance.Max,
              channelShowBadge: true,
              onlyAlertOnce: true,
              playSound: true,
              criticalAlerts: true),
        ],
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'high_important_channel_group',
              channelGroupName: 'Group 1')
        ],
        debug: true);
    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
        onActionReceivedMethod: onActionReceivedMethod,
        onDismissActionReceivedMethod: onDismissActionReceivedMethod,
        onNotificationCreatedMethod: onNotificationCreatedMethod,
        onNotificationDisplayedMethod: onNotificationDisplayedMethod);
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print(
        "receivedAction.buttonKeyPressed: ${receivedAction.buttonKeyPressed}");
    print("receivedAction.buttonKeyInput: ${receivedAction.buttonKeyInput}");
    // final payload = receivedAction.payload ?? {};
    // if (payload['navigatie'] == 'true') {
    //   //do something
    // }
    if (receivedAction.buttonKeyPressed == "openFile") {
      final payload = receivedAction.payload ?? {};
      final String dir = payload['path'].toString();
      final String fileName = payload['url']
          .toString()
          .replaceAll(ApiEndPoints.baseURL, '')
          .substring(1)
          .replaceAll("/", '_');
      // await OpenFile.open(dir.replaceAll(fileName, ''));
    }
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // print(
    //     "receivedAction.buttonKeyPressed: ${receivedAction.buttonKeyPressed}");
    // if (receivedAction.buttonKeyPressed == 'cancelDownload') {
    //   downloadCancelToken.cancel();
    //   await AwesomeNotifications()
    //       .cancel(int.parse(receivedAction.payload!["id"].toString()));
    // }
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}

  static Future<void> showNotification(NotificationData data) async {
    assert(!data.scheduled || (data.scheduled && data.interval != null));
    // assert(data.notificationLayout != NotificationLayout.ProgressBar &&
    //     data.progress != null);
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: data.id ?? DateTime.now().millisecondsSinceEpoch ~/ 1000,
            channelKey: 'high_important_channel',
            title: data.title,
            body: data.body,
            actionType: data.actionType,
            notificationLayout: data.notificationLayout,
            summary: data.summery,
            category: data.notificationCategory,
            payload: data.payload,
            bigPicture: data.bigPicture,
            progress: data.progress,
            locked: data.locked),
        actionButtons: data.actionButtons,
        schedule: data.scheduled
            ? NotificationInterval(
                interval: data.interval,
                timeZone:
                    await AwesomeNotifications().getLocalTimeZoneIdentifier(),
                preciseAlarm: true)
            : null);
  }
}
