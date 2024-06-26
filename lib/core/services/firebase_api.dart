
import 'package:firebase_messaging/firebase_messaging.dart';


class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {

    await _firebaseMessaging.requestPermission();

    try {
      final fCMToken = await _firebaseMessaging.getToken();
      print("fCMToken: $fCMToken");
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

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    //do ever you want with message
    print('Got a message whilst in the foreground!: ${message.toString()}');
  }
}


