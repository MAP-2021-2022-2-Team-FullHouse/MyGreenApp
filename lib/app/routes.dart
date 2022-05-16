import 'package:flutter/material.dart';
import 'package:mygreenapp/ui/screen/login/login_screen.dart';
import 'package:mygreenapp/ui/screen/register/register_body.dart';
import 'package:mygreenapp/ui/screen/register/register_screen.dart';
import 'package:mygreenapp/ui/screen/admin/admin_screen.dart';


import '../ui/screen/home/home_screen.dart';

class Routes {
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String adminRoute = '/admin';

  static Route<dynamic>? createRoute(settings) {
    switch (settings.name) {
      case homeRoute:
        return HomeScreen.route();
      case loginRoute:
        return LoginScreen.route();
      case registerRoute:
        return RegisterScreen.route();
      case adminRoute:
        return AdminScreen.route();
    }
    return null;
  }
}
