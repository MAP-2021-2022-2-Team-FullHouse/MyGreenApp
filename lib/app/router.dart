import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/ui/views/admin/admin_screen.dart';
import 'package:my_green_app/ui/views/home/home_screen.dart';
import 'package:my_green_app/ui/views/login/login_screen.dart';
import 'package:my_green_app/ui/views/profile/profile_screen.dart';
import 'package:my_green_app/ui/views/recyclecenter/CreateRecycleCenter/create_recycle_center_screen.dart';
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_screen.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_screen.dart';

import '../ui/views/appointment/CreateAppointment/create_appointment_screen.dart';
import '../ui/views/appointment/CreateAppointment/create_appointment_upload.dart';
import '../ui/views/appointment/appointment_screen.dart';
import '../ui/views/appointment/rc_view/rc_appointment_screen.dart';
import '../ui/views/appointment/rc_view_details/rc_appointment_view_screen.dart';
import '../ui/views/appointment/view/appointment_view_screen.dart';
import '../ui/views/home/rc_home_screen.dart';
import '../ui/views/reward/adminViewReward/admin_reward_screen.dart';
import '../ui/views/reward/createReward/create_reward_screen.dart';

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
    case routes.profileRoute:
      return MaterialPageRoute(builder: (context) => ProfileScreen());
    case routes.user_rcRoute:
      return MaterialPageRoute(builder: (context) => RCScreen());
    case routes.createRecycleCenterRoute:
      return MaterialPageRoute(builder: (context) => CreateRecycleCenterScreen());
       case routes.createRewardRoute:
      return MaterialPageRoute(builder: (context) => CreateRewardScreen());
       case routes.adminRewardRoute:
      return MaterialPageRoute(builder: (context) => AdminRewardScreen());
      case routes.rcHomeRoute:
      return MaterialPageRoute(builder: (context) => RCHomeScreen());
      case routes.appointmentRoute:
      return MaterialPageRoute(builder: (context) => AppointmentScreen());
    case routes.createAppointmentRoute:
      return MaterialPageRoute(builder: (context) => CreateAppointmentScreen());
    case routes.addImageRoute:
      return MaterialPageRoute(builder: (context) => AddImage());
    case routes.appointmentDetailsRoute:
      return MaterialPageRoute(
          builder: (context) => AppointmentDetailsScreen());
    case routes.recycleCenterAppointmentRoute:
      return MaterialPageRoute(
          builder: (context) => RecycleCenterAppointmentScreen());
    case routes.rcAppointmentDetailsRoute:
      return MaterialPageRoute(
          builder: (context) => RecycleCenterAppointmentDetailsScreen());

    
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
