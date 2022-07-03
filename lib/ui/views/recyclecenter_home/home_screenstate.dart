import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_green_app/ui/views/recyclecenter_home/rc_home_body.dart';
import 'package:my_green_app/ui/views/recyclecenter_home/rc_home_viewmodel.dart';

class RecycleCenterHomeScreenful extends StatefulWidget {
  const RecycleCenterHomeScreenful({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) => const RecycleCenterHomeScreenful());

  @override
  State<RecycleCenterHomeScreenful> createState() =>
      RecycleCenterHomeScreenfulState();

  void onLogout(RecycleCenterHomeViewmodel viewmodel) {}
}

class RecycleCenterHomeScreenfulState
    extends State<RecycleCenterHomeScreenful> {
  late AndroidNotificationChannel channel;
  // ignore: prefer_typing_uninitialized_variables
  late var flutterLocalNotificationsPlugin;
  String? mtoken = " ";
  String notificationMsg = "Waiting for notifications";
  final StreamController _myStreamCtrl = StreamController.broadcast();
  Stream get onVariableChanged => _myStreamCtrl.stream;
  // ignore: prefer_typing_uninitialized_variables
  var stream;

  @override
  void initState() {
    super.initState();
    //LocalNotificationService.initilize();
    getToken();
    RecycleCenterHomeViewmodel().requestPermission();
    RecycleCenterHomeViewmodel().loadFCM();
    RecycleCenterHomeViewmodel().listenFCM();
  }

  void getToken() async {
    mtoken = RecycleCenterHomeViewmodel().getToken();
  }

  void onLogout(RecycleCenterHomeViewmodel viewmodel) async {
    await viewmodel.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          RecycleCenterHomeBody(state: this, notificationMsg: notificationMsg),
    );
  }
}
