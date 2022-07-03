import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclecenter_home/home.dart';
import 'package:my_green_app/ui/views/recyclecenter_home/home_viewmodel.dart';

class RecycleCenterHomeScreenful extends StatefulWidget {
  const RecycleCenterHomeScreenful({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) => const RecycleCenterHomeScreenful());

  @override
  State<RecycleCenterHomeScreenful> createState() => RecycleCenterHomeScreenfulState();

  void onLogout(RecycleCenterHomeViewmodel viewmodel) {}
}

class RecycleCenterHomeScreenfulState extends State<RecycleCenterHomeScreenful> {

  @override
  void initState() {
    super.initState();
  }

  void onLogout(RecycleCenterHomeViewmodel viewmodel) async {
    await viewmodel.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RecycleCenterHomeBody(state: this));
  }
}
