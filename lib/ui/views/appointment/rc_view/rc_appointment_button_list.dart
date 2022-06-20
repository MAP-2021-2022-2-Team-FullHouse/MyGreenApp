import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/model/Appointment.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_screenstate.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_viewmodel.dart';

class RecycleCenterAppointmentListButton extends StatelessWidget {
  final RecycleCenterAppointmentViewmodel view;
  final RecycleCenterAppointmentScreenfulState state;
  final Appointment model;
  const RecycleCenterAppointmentListButton(
      {required this.view, required this.state, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: <Widget>[
      ElevatedButton.icon(
        icon: const Icon(
          Icons.info,
          size: 18.0,
        ),
        label: const Text('Details'),
        onPressed: () {
          state.onView(
              view,
              model.rcName,
              model.userName,
              model.recycleCenterEmail,
              model.dateTime,
              model.userEmail,
              model.phone,
              model.documentId);
          Navigator.of(context).pushNamed(routes.rcAppointmentDetailsRoute);
        },
      ),
      const SizedBox(
        width: 8,
      ),
      /* ElevatedButton.icon(
        icon: const Icon(
          Icons.delete,
          size: 18.0,
        ),
        label: const Text('Delete'),
        onPressed: () async {
          //state.onDelete(view, model.remail);
        },
      ), */
    ]));
  }
}
