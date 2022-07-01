import 'package:flutter/material.dart';

class AppointmentAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppointmentAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      elevation: 5,
      automaticallyImplyLeading: false,
      title: Text("Appointment History"),
      //centerTitle: true,
    );
  }
}
