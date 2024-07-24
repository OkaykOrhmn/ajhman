import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationData {
  final int? id;
  final String title;
  final String body;
  final String? summery;
  final String? bigPicture;
  final String? icon;
  final Map<String, String>? payload;
  final ActionType actionType;
  final NotificationLayout notificationLayout;
  final NotificationCategory? notificationCategory;
  final List<NotificationActionButton>? actionButtons;
  final bool scheduled;
  final bool locked;
  final int? interval;
  final int? progress;

  NotificationData({
    this.id,
    required this.title,
    required this.body,
    this.summery,
    this.bigPicture,
    this.icon,
    this.payload,
    this.actionType = ActionType.Default,
    this.notificationLayout = NotificationLayout.Default,
    this.notificationCategory,
    this.actionButtons,
    this.scheduled = false,
    this.locked = false,
    this.interval,
    this.progress,
  });
}
