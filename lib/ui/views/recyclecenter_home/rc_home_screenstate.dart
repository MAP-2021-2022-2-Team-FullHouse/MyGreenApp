import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclecenter_home/rc_home_body.dart';
import 'package:my_green_app/ui/views/recyclecenter_home/rc_home_viewmodel.dart';

class RecycleCenterHomeScreenful extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => RecycleCenterHomeScreenful());

  @override
  State<RecycleCenterHomeScreenful> createState() => RecycleCenterHomeScreenfulState();

  void onLogout(RecycleCenterHomeViewmodel viewmodel) {}
}

class RecycleCenterHomeScreenfulState extends State<RecycleCenterHomeScreenful> {
  void onLogout(RecycleCenterHomeViewmodel viewmodel) async {
    await viewmodel.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: RecycleCenterHomeBody(state: this));
  }
}
