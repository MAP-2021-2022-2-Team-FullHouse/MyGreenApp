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
  }

  void getToken() async {
    mtoken = HomeViewmodel().getToken();
    print(mtoken);
  }

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
