import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/services/local_notification_service.dart';
import 'package:stacked_services/stacked_services.dart';

class PushNotificationService {
  late AndroidNotificationChannel channel;
  late var flutterLocalNotificationsPlugin;

  Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  void sendPushMessage(String body, String title, String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAW_9lKRA:APA91bFJkK4zXIzF2UM7ahoz5NCJfZ74-wCPw2NJ6DcTAQ0SuwFMkV0oh8bKyzOK5rG7P2vicrUv3L5sLbF3Ui6JIDRji3cWJdn5-W30-xHbvH3C32P7pphSITYaFjUvFE1qPNOG_TY5',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'route': routes.appointmentRoute
            },
            "to": token,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }

  void sendPushMessageRecycleCenter(
      String body, String title, String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAW_9lKRA:APA91bFJkK4zXIzF2UM7ahoz5NCJfZ74-wCPw2NJ6DcTAQ0SuwFMkV0oh8bKyzOK5rG7P2vicrUv3L5sLbF3Ui6JIDRji3cWJdn5-W30-xHbvH3C32P7pphSITYaFjUvFE1qPNOG_TY5',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'route': routes.recycleCenterAppointmentRoute
            },
            "to": token,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }

  final StreamController<RemoteMessage> _remoteMessageController =
      StreamController<RemoteMessage>.broadcast();

  Stream? listenToMessage() {
    //terminated
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        //setState(() {
        //"${event.notification!.title} ${event.notification!.body} I am coming from terminated state";
        //Navigator.of(context).pushNamed(event.data['route']);
        _remoteMessageController.add(event);
        //});
      }
    });

    //foreground
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.showNotificationOnForeground(event);
      //setState(() {
      //notificationMsg =
      //    "${event.data['route']} ${event.notification!.body} I am coming from foreground";
      //Navigator.of(context).pushNamed(event.data['route']);
      _remoteMessageController.add(event);
      //});
    });

    //background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      //setState(() {
      //notificationMsg =
      //    "${event.data['route']} ${event.notification!.body} I am coming from background";
      //Navigator.of(context).pushNamed(event.data['route']);
      _remoteMessageController.add(event);
      //NavigationService().navigateTo(event.data['route']);
      //});
    });

    return _remoteMessageController.stream;
  }

  Stream? listenToMessageFore() {
    late RemoteMessage rm = RemoteMessage();

    //foreground
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.showNotificationOnForeground(event);
      //setState(() {
      //notificationMsg =
      //    "${event.data['route']} ${event.notification!.body} I am coming from foreground";
      //Navigator.of(context).pushNamed(event.data['route']);
      _remoteMessageController.add(event);
      //});
    });

    //background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      //setState(() {
      //notificationMsg =
      //    "${event.data['route']} ${event.notification!.body} I am coming from background";
      //Navigator.of(context).pushNamed(event.data['route']);
      _remoteMessageController.add(event);
      //NavigationService().navigateTo(event.data['route']);
      //});
    });

    return _remoteMessageController.stream;
  }

  /* RemoteMessage? listenToMessageForeground() {
    late RemoteMessage rm = RemoteMessage();
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.showNotificationOnForeground(event);
      setState(() {
      notificationMsg =
          "${event.data['route']} ${event.notification!.body} I am coming from foreground";
      Navigator.of(context).pushNamed(event.data['route']);
      rm = event;
      });
    });
    return rm;
  }*/

  RemoteMessage? listenToMessageBackground() {
    late RemoteMessage rm = RemoteMessage();
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      //setState(() {
      //notificationMsg =
      //    "${event.data['route']} ${event.notification!.body} I am coming from background";
      //Navigator.of(context).pushNamed(event.data['route']);
      rm = event;
      NavigationService().navigateTo(event.data['route']);
      //});
    });
    return rm;
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<String?> getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      /*setState(() {
        mtoken = token;
        print(mtoken);
      });*/
      return token;
    });
  }
}
