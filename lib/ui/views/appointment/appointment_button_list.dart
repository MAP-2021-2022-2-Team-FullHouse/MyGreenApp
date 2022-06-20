import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/model/Appointment.dart';
import 'package:my_green_app/ui/views/appointment/appointment_viewmodel.dart';
import 'package:my_green_app/ui/views/appointment/appointment_screenstate.dart';

class AppointmentListButton extends StatelessWidget {
  final AppointmentViewmodel view;
  final AppointmentScreenfulState state;
  final Appointment model;
  const AppointmentListButton(
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
          state.onView(view, model.rcName, model.recycleCenterEmail,
              model.dateTime, model.userEmail, model.documentId);
          Navigator.of(context).pushNamed(routes.appointmentDetailsRoute);
        },
      ),
      const SizedBox(
        width: 8,
      ),
    ]));
  }
}
