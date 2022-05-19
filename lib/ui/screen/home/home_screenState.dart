import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mygreenapp/app/routes.dart';
import 'package:mygreenapp/ui/screen/home/home.dart';
import 'package:mygreenapp/ui/screen/home/home_viewmodel.dart';

class HomeScreenful extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => HomeScreenful());

  @override
  State<HomeScreenful> createState() => HomeScreenfulState();

  void onLogout(HomeViewmodel viewmodel) {}
}

class HomeScreenfulState extends State<HomeScreenful> {
  void onLogout(HomeViewmodel viewmodel) async {
    await viewmodel.signOut();
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushNamed(context, Routes.loginRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeBody(this));
  }
}
