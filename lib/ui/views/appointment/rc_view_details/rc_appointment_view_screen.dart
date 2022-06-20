import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_navbar.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_viewmodel.dart';
import 'package:my_green_app/ui/views/appointment/rc_view_details/rc_appointment_view_details.dart';

class RecycleCenterAppointmentDetailsScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(
      builder: (_) => RecycleCenterAppointmentDetailsScreen());

  @override
  State<RecycleCenterAppointmentDetailsScreen> createState() =>
      RecycleCenterAppointmentDetailsScreenState();
}

class RecycleCenterAppointmentDetailsScreenState
    extends State<RecycleCenterAppointmentDetailsScreen> {
  Widget getViewContainer(
      context, RecycleCenterAppointmentViewmodel viewmodel) {
    if (viewmodel.isViewAction == true) {
      print(RecycleCenterAppointmentViewmodel.viewAction);
      return Container();
      /* return ViewMap(
          viewmodel: AppointmentViewmodel(),
          state: this,
          model: AppointmentViewmodel.appointment); */
    } else {
      return Container();
    }
  }

  Future getImages(RecycleCenterAppointmentViewmodel viewmodel, String rcEmail,
      DateTime dt, String uEmail) async {
    //var id = await viewmodel.viewAppointmentID(rcEmail, dt, uEmail);
    return viewmodel.getImgUrls(RecycleCenterAppointmentViewmodel.chosenID);
  }

  void onCancel(RecycleCenterAppointmentViewmodel viewmodel) {
    viewmodel.cancelAppointment(RecycleCenterAppointmentViewmodel.chosenID);
  }

  void onChangeStatus(
      RecycleCenterAppointmentViewmodel viewmodel, String newStatus) {
    viewmodel.changeAppointmentStatus(
        RecycleCenterAppointmentViewmodel.chosenID, newStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RecycleCenterAppointmentDetails(),
      bottomNavigationBar: RecycleCenterAppointmentNavigationBar(),
    );
  }
}
