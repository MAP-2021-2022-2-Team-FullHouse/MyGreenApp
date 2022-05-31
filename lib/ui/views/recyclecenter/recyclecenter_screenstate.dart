import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/app/routes.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_body.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_viewmodel.dart';

class RecycleCenterScreenful extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => RecycleCenterScreenful());

  @override
  State<RecycleCenterScreenful> createState() => RecycleCenterScreenfulState();

  void onLogout(RecycleCenterViewmodel viewmodel) {}
}

class RecycleCenterScreenfulState extends State<RecycleCenterScreenful> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: RecycleCenterBody(this));
  }
}
