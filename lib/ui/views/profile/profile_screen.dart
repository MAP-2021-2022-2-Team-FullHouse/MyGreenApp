import 'package:flutter/material.dart';
import 'package:my_green_app/app/routes.dart';
import 'package:my_green_app/ui/views/home/home_navBar.dart';
import 'package:my_green_app/ui/views/home/rc_home_navBar.dart';
import 'package:my_green_app/ui/views/profile/profile_body.dart';
import 'package:my_green_app/ui/views/profile/profile_viewmodel.dart';
import 'package:my_green_app/ui/views/home/home_viewmodel.dart';

import '../admin/admin_navBar.dart';

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

  String role = '';
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileBody(this),

      bottomNavigationBar: FutureBuilder(future:HomeViewmodel().myRole(), builder:(context, snapshot){
        if(snapshot.hasData){
          role="${snapshot.data}";
          return  role.compareTo("user") == 0
          ? HomeNavigationBar(pageNo: 4)
           :( role.compareTo("Recycle Center") == 0
              ? RCHomeNavigationBar(pageNo: 2)
              : AdminNavigationBar());
        }else{
          return Container();
        }
      })
      // role.compareTo("user") == 0
      //     ? HomeNavigationBar(pageNo: 2)
      //     :( role.compareTo("Recycle Center") == 0
      //         ? RCHomeNavigationBar(pageNo: 2)
      //         : AdminNavigationBar()),
      //ProfileNavigationBar(),
    );
  }

  Future<String?> getImgUrl(String imgUrl) async {
    ProfileViewmodel vm = new ProfileViewmodel();
    return await vm.getImgUrl(imgUrl);
  }

 
}
