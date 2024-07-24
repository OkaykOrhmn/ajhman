import 'package:ajhman/data/model/notification_data_model.dart';
import 'package:ajhman/data/model/notification_model.dart';
import 'package:ajhman/ui/theme/colors.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

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
        // channelGroups: [
        //   NotificationChannelGroup(
        //       channelGroupKey: 'high_important_channel_group',
        //       channelGroupName: 'Group 1')
        // ],
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
      ReceivedAction receivedAction) async {}

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}

  static Future<void> showFirebaseNotification(RemoteMessage message) async {
    final data = NotificationDataModel.fromJson(message.data);
    NotificationService.showNotification(NotificationData(
        title: data.title.toString(),
        body: data.body.toString(),
        bigPicture: data.image.toString(),
        notificationLayout: data.image.toString().isNotEmpty
            ? NotificationLayout.BigPicture
            : NotificationLayout.BigText));
  }

  static Future<void> showNotification(NotificationData data) async {
    assert(!data.scheduled || (data.scheduled && data.interval != null));
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
