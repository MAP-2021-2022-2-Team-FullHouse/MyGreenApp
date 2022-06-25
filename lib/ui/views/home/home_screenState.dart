import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/home/home.dart';
import 'package:my_green_app/ui/views/home/home_viewmodel.dart';

class HomeScreenful extends StatefulWidget {
  const HomeScreenful({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute(builder: (_) => const HomeScreenful());

  @override
  State<HomeScreenful> createState() => HomeScreenfulState();

  void onLogout(HomeViewmodel viewmodel) {}
}

class HomeScreenfulState extends State<HomeScreenful> {
  void onLogout(HomeViewmodel viewmodel) async {
    await viewmodel.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeBody(state:this));
  }
}
