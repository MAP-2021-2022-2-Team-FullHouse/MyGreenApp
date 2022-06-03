import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_body.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_button.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_body.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_viewmodel.dart';

import 'rc_viewmodel.dart';

class RCScreenful extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => RCScreenful());

  @override
  State<RCScreenful> createState() => RCScreenfulState();

 
}

class RCScreenfulState extends State<RCScreenful> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: RCBody(this));
  }
  
  Future<String?> getImgUrl(String imgUrl) async {
    RCViewmodel vm=new RCViewmodel();
    print(imgUrl);
    return await vm.getImgUrl(imgUrl);
  }
}


