import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_appbar.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_appbar.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_navbar.dart';

import '../../home/home_navBar.dart';
import 'rc_screenstate.dart';



class RCScreen extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => RCScreen());
  const RCScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const RCAppBar(),
      
        body: RCScreenful(),
        bottomNavigationBar: HomeNavigationBar(pageNo:0),
        //floatingActionButton: const AdminFloat(),
        //bottomNavigationBar: RecycleCenterNavigationBar(),
      ),
    );
  }
}
