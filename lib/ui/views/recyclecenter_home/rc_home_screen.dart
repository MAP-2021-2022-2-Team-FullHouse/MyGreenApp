import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclecenter_home/home_navBar.dart';
import 'package:my_green_app/ui/views/recyclecenter_home/home_screenState.dart';
import 'home.dart';

class RecycleCenterHomeScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const RecycleCenterHomeScreen());
  const RecycleCenterHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: RecycleCenterHomeAppBar(),
        body: RecycleCenterHomeScreenful(),
        bottomNavigationBar: RecycleCenterHomeNavigationBar(pageNo: 1),
      ),
    );
  }
}
