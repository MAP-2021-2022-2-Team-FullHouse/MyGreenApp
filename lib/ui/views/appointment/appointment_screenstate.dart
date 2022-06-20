import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/ui/views/appointment/appointment_body.dart';
import 'package:my_green_app/ui/views/appointment/appointment_viewmodel.dart';

class AppointmentScreenful extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => AppointmentScreenful());

  @override
  State<AppointmentScreenful> createState() => AppointmentScreenfulState();
}

class AppointmentScreenfulState extends State<AppointmentScreenful> {
  @override
  void initState() {
    super.initState();
  }

  Widget getViewContainer(context, AppointmentViewmodel viewmodel) {
    if (viewmodel.isViewAction == true) {
      print(AppointmentViewmodel.viewAction);
      return Container();
      /* return ViewMap(
          viewmodel: AppointmentViewmodel(),
          state: this,
          model: AppointmentViewmodel.appointment); */
    } else {
      return Container();
    }
  }

  void onView(AppointmentViewmodel viewmodel, String name, String rcEmail,
      DateTime dt, String uEmail, String id) {
    AppointmentViewmodel.u = uEmail;
    AppointmentViewmodel.rcEmail = rcEmail;
    AppointmentViewmodel.chosenDT = dt;
    AppointmentViewmodel.name = name;
    AppointmentViewmodel.chosenID = id;
    //AppointmentViewmodel().getRecycleCenterName(rcEmail);
    //await AppointmentViewmodel().getAppointmentID(rcEmail, dt, uEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AppointmentBody(state: this));
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
