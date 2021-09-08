import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   'This channel is used for important notifications.', // description
//   importance: Importance.max,
// );
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings;
  bool _initialized = false;
  bool _hasPermission = false;

  Future<void> init(context) async {
    settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    if (!_initialized) {
      String token = await messaging.getToken();
      // use the returned token to send messages to users from your custom server
      print("FirebaseMessaging token: $token");

      var notifPerm = await Permission.notification.request();
      if (notifPerm.isGranted) _hasPermission = true;

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );

      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('app_icon');
      final IOSInitializationSettings initializationSettingsIOS =
          IOSInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
      );

      final InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
      );

      // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      //     FlutterLocalNotificationsPlugin();

      // await flutterLocalNotificationsPlugin
      //     .resolvePlatformSpecificImplementation<
      //         AndroidFlutterLocalNotificationsPlugin>()
      //     ?.createNotificationChannel(channel);

      final bool result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        AndroidNotification android = message.notification?.android;
        // AppleNotification apple = message.notification?.apple;

        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');
        }
        if (message.notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            message.notification.hashCode,
            message.notification.title,
            message.notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android?.smallIcon,
              ),
              iOS: IOSNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
              ),
            ),
          );
        }
      });
      //   _firebaseMessaging.configure(
      //     onMessage: (Map<String, dynamic> message) async {
      //       print("onMessage: $message");
      //       await _handleNotification(context, message['data']);
      //     },
      //     onResume: (message) async {
      //       print("onMessage: $message");
      //       await _handleNotification(context, message['data']);
      //     },
      //     onLaunch: (message) async {
      //       await _handleNotification(context, message['data']);
      //     },
      //     onBackgroundMessage: myBackgroundMessageHandler,
      //   );
      //   await _saveToken(token);
      //   _initialized = true;
      // } else {
      //   _firebaseMessaging.requestNotificationPermissions();
      // }
      await _saveToken(token);
      _initialized = true;
    }
  }

  Future<void> _handleNotification(context, data) async {
    if (data['type'] == 'room') {
      var details = jsonDecode(data['details']);
      print(details);
      String roomId = details['roomId'];
      String password = details['password'];
      String subject = details['subject'];
      if (roomId != null || roomId != 'null') {
        await Navigator.pushNamed(context,
            '/room?roomId=$roomId&password=$password&subject=$subject');
      }
    }
  }

  Future<void> _saveToken(token) async {
    if (FirebaseAuth.instance.currentUser != null) {
      var doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('tokens')
          .doc(token)
          .get();
      if (!doc.exists) {
        await doc.reference.set({
          'token': token,
          'userId': FirebaseAuth.instance.currentUser.uid,
          'createdAt': DateTime.now(),
          'platform': kIsWeb ? 'web' : Platform.operatingSystem
        });
      }
    }
  }

  Future onDidReceiveLocalNotification(int id, String title, String body,
      String payload, BuildContext context) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
              isDefaultAction: true, child: Text('Ok'), onPressed: () {})
        ],
      ),
    );
  }
}
