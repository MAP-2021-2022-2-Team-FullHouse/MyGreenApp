import 'package:flutter/material.dart';
import 'package:my_green_app/app/routes.dart';
import 'package:my_green_app/ui/views/profile/profile_body.dart';
import 'package:my_green_app/ui/views/profile/profile_navbar.dart';
import 'package:my_green_app/ui/views/profile/profile_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => ProfileScreen());
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  var fileField = TextEditingController();
  ProfileViewmodel viewmodel = ProfileViewmodel();
  void updateUser(String name, String phone, String address) async {
    viewmodel.updateUser(name, phone, address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileBody(this),
      bottomNavigationBar: ProfileNavigationBar(),
    );
  }
}
