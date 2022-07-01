import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/home/home_navBar.dart';
import 'package:my_green_app/ui/views/home/home_screenState.dart';

import 'home.dart';

class HomeScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const HomeScreen());
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: HomeAppBar(),
        body: HomeScreenful(),
        bottomNavigationBar: HomeNavigationBar(pageNo: 2),
      ),
    );
  }
}
