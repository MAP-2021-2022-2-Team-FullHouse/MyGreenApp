import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_appbar.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_body.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_navbar.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_screenstate.dart';

class RecycleCenterScreen extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const RecycleCenterScreen());
  const RecycleCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const RecycleCenterAppBar(),
        body: RecycleCenterScreenful(),
        //floatingActionButton: const AdminFloat(),
        bottomNavigationBar: const RecycleCenterNavigationBar(),
      ),
    );
  }
}
