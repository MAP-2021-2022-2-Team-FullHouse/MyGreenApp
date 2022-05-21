import 'package:flutter/material.dart';
import 'package:mygreenapp/ui/screen/admin/admin_navBar.dart';
import 'package:mygreenapp/ui/screen/admin/admin_screenstate.dart';
import 'package:mygreenapp/ui/screen/home/home_app_bar.dart';
import 'admin.dart';

class AdminScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => AdminScreen());
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: AdminScreenful(),
        floatingActionButton: const AdminFloat(),
        bottomNavigationBar: AdminNavigationBar(),
      ),
    );
  }
}
