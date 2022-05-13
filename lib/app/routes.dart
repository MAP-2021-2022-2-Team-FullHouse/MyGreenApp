import 'package:flutter/material.dart';
import 'package:mygreenapp/view/login/login_view.dart';
import 'package:mygreenapp/view/register/register_view.dart';

import '../view/home/home_screen.dart';

class Routes {
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';

  static Route<dynamic>? createRoute(settings) {
    switch (settings.name) {
      case homeRoute:
        return HomeScreen.route();
      case loginRoute:
        return Login.route();
      case registerRoute:
        return Register.route();
    }
    return null;
  }
}
