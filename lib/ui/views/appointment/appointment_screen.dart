import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/appointment/appointment_appbar.dart';
import 'package:my_green_app/ui/views/appointment/appointment_body.dart';
import 'package:my_green_app/ui/views/appointment/appointment_navbar.dart';
import 'package:my_green_app/ui/views/appointment/appointment_screenstate.dart';

class AppointmentScreen extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => AppointmentScreen());
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppointmentAppBar(),
        body: AppointmentScreenful(),
        //floatingActionButton: const AdminFloat(),
        bottomNavigationBar: AppointmentNavigationBar(),
      ),
    );
  }
}
