import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_appbar.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_screenstate.dart';
import '../../recyclecenter_home/home_navBar.dart';

class RecycleCenterAppointmentScreen extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const RecycleCenterAppointmentScreen());
  const RecycleCenterAppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const RecycleCenterAppointmentAppBar(),
        body: RecycleCenterAppointmentScreenful(),
        bottomNavigationBar: const RecycleCenterHomeNavigationBar(pageNo: 0),
      ),
    );
  }
}
