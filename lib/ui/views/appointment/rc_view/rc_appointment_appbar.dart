import 'package:flutter/material.dart';

class RecycleCenterAppointmentAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const RecycleCenterAppointmentAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      elevation: 5,
      automaticallyImplyLeading: false,
      title: const Text("Appointment"),
    );
  }
}
