import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/ui/views/appointment/appointment_body.dart';
import 'package:my_green_app/ui/views/appointment/appointment_navbar.dart';
import 'package:my_green_app/ui/views/appointment/appointment_viewmodel.dart';
import 'package:my_green_app/ui/views/appointment/view/appointment_view_details.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => AppointmentDetailsScreen());

  @override
  State<AppointmentDetailsScreen> createState() =>
      AppointmentDetailsScreenState();
}

class AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
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

  Future getImages(AppointmentViewmodel viewmodel, String rcEmail, DateTime dt,
      String uEmail) async {
    //var id = await viewmodel.viewAppointmentID(rcEmail, dt, uEmail);
    return viewmodel.getImgUrls(AppointmentViewmodel.chosenID);
  }

  void onCancel(AppointmentViewmodel viewmodel, String rcEmail) {
    viewmodel.cancelAppointment(AppointmentViewmodel.chosenID, rcEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppointmentDetails(),
      bottomNavigationBar: AppointmentNavigationBar(),
    );
  }
}
