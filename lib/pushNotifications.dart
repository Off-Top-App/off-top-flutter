import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");

      _initialized = true;
    }
  }
  // final FirebaseMessaging _fcm = FirebaseMessaging();

  // Future initialize() async {
  //   if (Platform.isIOS) {
  //     _fcm.requestNotificationPermissions(IosNotificationSettings());
  //   }

  //   _fcm.configure(
  //     //Called when the app is in the foreground and we receive a push notification
  //     onMessage: (Map<String, dynamic> message) async {
  //       print('onMessage: $message');
  //     },
  //     //Called when the app has been closed completely and it's opened
  //     //from the push notification
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print('onMessage: $message');
  //     },
  //     //Called when the app is in the background and it's opened
  //     //from the push notification.
  //     onResume: (Map<String, dynamic> message) async {
  //       print('onMessage: $message');
  //     },
  //   );
  // }
}
