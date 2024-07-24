// ignore_for_file: empty_catches

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../data/model/notification_data_model.dart';
import 'notification_service.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    try {
      final fCMToken = await _firebaseMessaging.getToken();
      if (kDebugMode) {
        print("fCMToken: $fCMToken");
      }
    } catch (e) {}

    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessageOpenedApp.listen((event) {});
    FirebaseMessaging.onMessage.listen((event) => handleMessage(event));
  }

  void handleMessage(RemoteMessage? message) async {
    if (message == null) return;
    //do ever you want with message
    if (kDebugMode) {
      print(
          "forground: ${NotificationDataModel.fromJson(message.data).toJson()}");
    }
    try {
      await NotificationService.showFirebaseNotification(message);
    } catch (e) {
      rethrow;
    }
  }
}
