import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_green_app/model/PushNotification.dart';
import 'package:my_green_app/services/local_notification_service.dart';
import 'package:my_green_app/services/push_notification_service.dart';
import 'package:my_green_app/ui/notification_badge.dart';
import 'package:my_green_app/ui/views/home/home.dart';
import 'package:my_green_app/ui/views/home/home_viewmodel.dart';
import 'package:overlay_support/overlay_support.dart';

class HomeScreenful extends StatefulWidget {
  const HomeScreenful({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) => const HomeScreenful());

  @override
  State<HomeScreenful> createState() => HomeScreenfulState();

  void onLogout(HomeViewmodel viewmodel) {}
}

/* Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
} */

class HomeScreenfulState extends State<HomeScreenful> {
  late int _totalNotifications = 0;
  late AndroidNotificationChannel channel;
  late var flutterLocalNotificationsPlugin;
  String? mtoken = " ";
  late FirebaseMessaging _messaging = FirebaseMessaging.instance;
  late PushNotification? _notificationInfo = PushNotification();
  String notificationMsg = "Waiting for notifications";
  final StreamController _myStreamCtrl = StreamController.broadcast();
  Stream get onVariableChanged => _myStreamCtrl.stream;
  var stream;

  @override
  void initState() {
    _totalNotifications = 0;
    super.initState();
    //LocalNotificationService.initilize();
    getToken();
    HomeViewmodel().requestPermission();
    HomeViewmodel().loadFCM();
    HomeViewmodel().listenFCM();
    /*PushNotificationService().sendPushMessage(
        'Notification Body',
        'Notification Title',
        /* 'eu4WdXm8SwSTr47yDIJMf8:APA91bFS2306ncfClQiyqrUwTHJJCCXuRp6wsJogVAbzPoOoqZjj-auFFcedvhB9Vk0NmpaL4MK0A9exWkKrpyee1G95bNHNPILVC7qKidT4-87aLefRgMOVaUcUj3DWATk1QvLZZphA' 
        'cWfStNg1R1iFnSS2sEWRIM:APA91bHsHKP5WAvsgFDBU7Zl16zUbn3wF_jRvHQg1Xm0VwOAfaSBE4AIBMpuk28k7DKzgbFpesBeFVfK3NAn8t-hWjx9-WyH-QsBfB0_J1wpl34BNGBBfmKdno6Gn0XXzECZnz9w-w2C'*/
        //'crnZVWXQQqWkKXIhem53DM:APA91bF16pB7kNYMdoadGQc1gkmi6F-BUfVLnona33HQWbXgivvWVMUTMRasmImwO9wAfo1N0C9XjJwfGzgkCROsgdqv_MM-3rmKYi5KWhnxsdNFiqtCMpsKTIFcBtlDPx1zJZ5gDgXH');
        //'d0DOM9z-RZWozXeDyi6z9m:APA91bEj8DUolmcaO8_PTcnLvPCVp7vKkEI3HXKQVvx3n0l2ZZPNoV4Pbq0qiae8VK-fegBB_Kthwdmp9yPC5vfNTAE3Fa-lWqWh9ll9h6OmvEn6HMiU_Y66xujd9OHBsK2hA8rC2nWR');
        'dkZsDfABRhedmTmrSB866g:APA91bFnknFhGA4LzTLL7uZpBEReQDv1jRk_y4vElhCgsx6B2G89xy-xZaR-VdQvjCMt4CuhUaCBXamuoDLvkxhI58cY2pswlUL8hNYuGvqYClS8-uDQZOxwtija6RpZmjEedfsI6W4x');
    //'cipQ0SiCScGu4R9z--C1GT:APA91bE95WbwArZKK7TC2p0qUSRY0NyuUhQMNI7P_kO4VeClo_KsjLmFp7crX_86k_yaZPY6WdudXT_w8vgAyFk4v3TAzzRgjNTEtQ9cZstA1mFXKiqpWx3B4bOvfQ3iFzI4k45X0eWC');
    // Terminated State
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        setState(() {
          // notificationMsg =
          "${event.notification!.title} ${event.notification!.body} I am coming from terminated state";
          Navigator.of(context).pushNamed(event.data['route']);
        });
      }
    });

     Foregrand State
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.showNotificationOnForeground(event);
      setState(() {
        //notificationMsg =
        //    "${event.data['route']} ${event.notification!.body} I am coming from foreground";
        Navigator.of(context).pushNamed(event.data['route']);
      });
    });

    // background State
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      setState(() {
        //notificationMsg =
        //    "${event.data['route']} ${event.notification!.body} I am coming from background";
        Navigator.of(context).pushNamed(event.data['route']);
      });
    });*/
    /* FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      registerNotification();
      checkForInitialMessage();
    });
    _totalNotifications = 0;
    super.initState(); */
  }

  void getToken() async {
    /*await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print(mtoken);
      });
    });*/
    mtoken = HomeViewmodel().getToken();
    print(mtoken);
  }
/*
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
  }*/

  void onLogout(HomeViewmodel viewmodel) async {
    await viewmodel.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBody(state: this, notificationMsg: notificationMsg),
    );
  }
}
