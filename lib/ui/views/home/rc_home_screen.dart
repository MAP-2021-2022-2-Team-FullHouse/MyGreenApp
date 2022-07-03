import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/home/rc_home_body.dart';
import 'package:my_green_app/ui/views/home/rc_home_navBar.dart';
import 'package:my_green_app/ui/views/home/home_screenState.dart';

import 'home.dart';


class RCHomeScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const RCHomeScreen());
  const RCHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const HomeAppBar(),
        body:RCHomeBody(state:HomeScreenfulState()),
        bottomNavigationBar: const RCHomeNavigationBar(pageNo: 1),
      ),
    );
  }
}