import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_body.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_viewmodel.dart';

class RecycleCenterAppointmentScreenful extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => RecycleCenterAppointmentScreenful());

  @override
  State<RecycleCenterAppointmentScreenful> createState() =>
      RecycleCenterAppointmentScreenfulState();
}

class RecycleCenterAppointmentScreenfulState
    extends State<RecycleCenterAppointmentScreenful> {
  @override
  void initState() {
    super.initState();
  }

  Widget getViewContainer(
      context, RecycleCenterAppointmentViewmodel viewmodel) {
    if (viewmodel.isViewAction == true) {
      //print(RecycleCenterAppointmentViewmodel.viewAction);
      return Container();
      /* return ViewMap(
          viewmodel: AppointmentViewmodel(),
          state: this,
          model: AppointmentViewmodel.appointment); */
    } else {
      return Container();
    }
  }

  void onView(
      RecycleCenterAppointmentViewmodel viewmodel,
      String name,
      String uName,
      String rcEmail,
      DateTime dt,
      String uEmail,
      String phone,
      String id) {
    RecycleCenterAppointmentViewmodel.u = uEmail;
    RecycleCenterAppointmentViewmodel.rcEmail = rcEmail;
    RecycleCenterAppointmentViewmodel.chosenDT = dt;
    RecycleCenterAppointmentViewmodel.name = name;
    RecycleCenterAppointmentViewmodel.uName = uName;
    RecycleCenterAppointmentViewmodel.chosenID = id;
    RecycleCenterAppointmentViewmodel.phone = phone;
    //AppointmentViewmodel().getRecycleCenterName(rcEmail);
    //await AppointmentViewmodel().getAppointmentID(rcEmail, dt, uEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: RecycleCenterAppointmentBody(state: this));
  }
}

showAlertDialog(BuildContext context, String text) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pushNamed(context, routes.loginRoute);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text(text),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
