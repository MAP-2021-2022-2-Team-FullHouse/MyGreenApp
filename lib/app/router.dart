import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/ui/views/admin/admin_screen.dart';
import 'package:my_green_app/ui/views/home/home_screen.dart';
import 'package:my_green_app/ui/views/login/login_screen.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.loginRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case routes.homeRoute:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    case routes.adminRoute:
      return MaterialPageRoute(builder: (context) => AdminScreen());
    case routes.rcRoute:
      return MaterialPageRoute(builder: (context) => RecycleCenterScreen());
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
