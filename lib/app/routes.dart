import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/appointment/appointment_screen.dart';
import 'package:my_green_app/ui/views/login/login_screen.dart';
import 'package:my_green_app/ui/views/register/register_body.dart';
import 'package:my_green_app/ui/views/register/register_screen.dart';
import 'package:my_green_app/ui/views/admin/admin_screen.dart';
import 'package:my_green_app/ui/views/reset/reset_screen.dart';

import '../ui/views/home/home_screen.dart';

class Routes {
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String adminRoute = '/admin';
  static const String resetRoute = '/reset';
  static const String appointmentRoute = '/appointment';

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
      case resetRoute:
        return ResetScreen.route();
      case appointmentRoute:
        return AppointmentScreen.route();
    }
    return null;
  }
}
