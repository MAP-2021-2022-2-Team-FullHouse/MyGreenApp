import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclecenter_home/rc_home_body.dart';
import 'package:my_green_app/ui/views/recyclecenter_home/rc_home_navBar.dart';
import 'package:my_green_app/ui/views/recyclecenter_home/rc_home_screenState.dart';

import '../home/home.dart';


class RecycleCenterHomeScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const RecycleCenterHomeScreen());
  const RecycleCenterHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const HomeAppBar(),
        body:RecycleCenterHomeBody(state:RecycleCenterHomeScreenfulState()),
        bottomNavigationBar: const RecycleCenterHomeNavigationBar(pageNo: 1),
      ),
    );
  }
}