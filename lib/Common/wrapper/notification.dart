// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myecomapp/main.dart';

class NotificationWrapper extends StatefulWidget {
  final Widget child;
  const NotificationWrapper({
    super.key,
    required this.child,
  });

  @override
  State<NotificationWrapper> createState() => _NotificationWrapperState();
}

class _NotificationWrapperState extends State<NotificationWrapper> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    initializa();
    super.initState();
  }

  initializa() async {
    await notificationPermission();
    await initializaFirebaseNotification();
    await onForegroundListener();
    await onBackgroudListener();
    await initializationLocalNotification();
  }

  notificationPermission() async {
    NotificationSettings _ = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  onForegroundListener() async {
    FirebaseMessaging.onMessage.listen((event) {
      final notifId = Random().nextInt(10000);
      flutterLocalNotificationsPlugin.show(
          notifId,
          event.notification?.title,
          event.notification?.body,
          const NotificationDetails(
              android: AndroidNotificationDetails("test", "app",
                  channelDescription: "This is default notification")));
      print(event);
    });
  }

  onBackgroudListener() async {
    FirebaseMessaging.onBackgroundMessage(onBackgroundHandler);
  }

  initializaFirebaseNotification() async {
    final webToken = await messaging.getToken();
    print("firebase Token");
    print(webToken);
  }

  initializationLocalNotification() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('bell.png');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print(details);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}


// FirebaseMessaging messaging = FirebaseMessaging.instance;



// print('User granted permission: ${settings.authorizationStatus}');