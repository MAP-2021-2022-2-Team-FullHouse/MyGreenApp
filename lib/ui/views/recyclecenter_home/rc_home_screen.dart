import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/home/home_app_bar.dart';
import 'package:my_green_app/ui/views/home/rc_home_navBar.dart';
import 'package:my_green_app/ui/views/recyclecenter_home/rc_home_navBar.dart';
import 'package:my_green_app/ui/views/recyclecenter_home/home_screenState.dart';
import 'rc_home.dart';

class RecycleCenterHomeScreen extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const RecycleCenterHomeScreen());
  const RecycleCenterHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: RecycleCenterHomeScreenful(),
        bottomNavigationBar: RCHomeNavigationBar(pageNo: 1),
      ),
    );
  }
}
