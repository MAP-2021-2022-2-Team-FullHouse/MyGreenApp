import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/model/Appointment.dart';
import 'package:my_green_app/ui/views/appointment/appointment_viewmodel.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_viewmodel.dart';
import 'package:my_green_app/ui/views/appointment/rc_view_details/rc_appointment_view_screen.dart';
import 'package:my_green_app/ui/views/appointment/view/appointment_view_screen.dart';

AppointmentDetailsScreenState state = AppointmentDetailsScreenState();
AppointmentViewmodel viewmodel = AppointmentViewmodel();
bool cancel = true;

Widget buildButton(DocumentSnapshot<Map<String, dynamic>> a) {
  if (a['status'] == 'pending' || a['status'] == 'accept') {
    return Container(
        child: Column(children: <Widget>[
      ElevatedButton.icon(
        icon: const Icon(
          Icons.cancel_outlined,
          size: 18.0,
        ),
        label: Text('Cancel'),
        onPressed: () async {
          state.onCancel(viewmodel);
        },
      ),
      const SizedBox(
        width: 8,
      ),
    ]));
  } else if (a['status'] == 'reject') {
    return Container(
        child: Column(children: <Widget>[
      ElevatedButton.icon(
        icon: const Icon(
          Icons.info,
          size: 18.0,
        ),
        label: const Text('Your appointment has been rejected!'),
        onPressed: () async {
          //state.onCancel(viewmodel);
        },
      ),
      const SizedBox(
        width: 8,
      )
    ]));
  } else if (a['status'] == 'complete') {
    return Container(
        child: Column(children: <Widget>[
      ElevatedButton.icon(
        icon: const Icon(
          Icons.info,
          size: 18.0,
        ),
        label: const Text('Your appointment has been completed!'),
        onPressed: () async {
          //state.onCancel(viewmodel);
        },
      ),
      const SizedBox(
        width: 8,
      )
    ]));
  } else if (a['status'] == 'cancel') {
    return Container(
        child: Column(children: <Widget>[
      ElevatedButton.icon(
        icon: const Icon(
          Icons.info,
          size: 18.0,
        ),
        label: const Text('Your appointment has been cancelled!'),
        onPressed: () async {
          //state.onCancel(viewmodel);
        },
      ),
      const SizedBox(
        width: 8,
      )
    ]));
  } else if (a['status'] == 'going') {
    return Center(
        child: Column(children: <Widget>[
      ElevatedButton.icon(
        icon: const Icon(
          Icons.info,
          size: 18.0,
        ),
        label: const Text('The recycle center is on their way.'),
        onPressed: () async {
          //state.onCancel(viewmodel);
        },
      ),
      const SizedBox(
        width: 8,
      )
    ]));
  }
  return Container();
}
