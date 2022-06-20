import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/home/rc_home_navBar.dart';
import 'package:my_green_app/ui/views/home/home_screenState.dart';
import 'package:my_green_app/ui/views/map/mapScreen.dart';

import 'home.dart';


class RCHomeScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => RCHomeScreen());
  const RCHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const HomeAppBar(),
        body:HomeScreenful(),
        bottomNavigationBar: RCHomeNavigationBar(pageNo: 1),
      ),
    );
  }
}
