import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/app/routes.dart';
import 'package:my_green_app/ui/views/admin/admin.dart';
import 'package:my_green_app/ui/views/admin/admin_viewmodel.dart';

class AdminScreenful extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => AdminScreenful());

  @override
  State<AdminScreenful> createState() => AdminScreenfulState();

  void onLogout(AdminViewmodel viewmodel) {}
}

class AdminScreenfulState extends State<AdminScreenful> {
  void onLogout(AdminViewmodel viewmodel) async {
    await viewmodel.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AdminBody(this));
  }
}
