import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_viewmodel.dart';
import 'package:my_green_app/ui/views/appointment/rc_view_details/rc_appointment_view_screen.dart';
import 'package:my_green_app/ui/views/appointment/view/appointment_view_screen.dart';

RecycleCenterAppointmentDetailsScreenState state =
    RecycleCenterAppointmentDetailsScreenState();
RecycleCenterAppointmentViewmodel viewmodel =
    RecycleCenterAppointmentViewmodel();
bool cancel = true;

Widget buildRecycleCenterButton(DocumentSnapshot<Map<String, dynamic>> a) {
  if (a['status'] == 'pending') {
    return Container(
        child: Column(children: <Widget>[
      ElevatedButton.icon(
        icon: const Icon(
          Icons.check,
          size: 18.0,
        ),
        label: const Text('Accept'),
        onPressed: () async {
          state.onChangeStatus(viewmodel, 'accept', a['userEmail']);
        },
      ),
      const SizedBox(
        width: 8,
      ),
      ElevatedButton.icon(
        icon: const Icon(
          Icons.cancel,
          size: 18.0,
        ),
        label: const Text('Reject'),
        onPressed: () async {
          state.onChangeStatus(viewmodel, 'reject', a['userEmail']);
        },
      ),
    ]));
  } else if (a['status'] == 'accept') {
    return Container(
        child: Column(children: <Widget>[
      ElevatedButton.icon(
        icon: const Icon(
          Icons.check,
          size: 18.0,
        ),
        label: const Text('Going Now'),
        onPressed: () async {
          state.onChangeStatus(viewmodel, 'going', a['userEmail']);
        },
      ),
      FutureBuilder<String>(
          future: viewmodel.getUserName(a['userEmail']),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            if (snapshot.hasData) {
              final r = snapshot.data!;
              return Wrap(children: <Widget>[
                Text(
                  "Tap to inform " + r + " that you are on the way.",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ]);
            } else {
              return const Center(child: Text('No data found'));
            }
          }),
      const SizedBox(
        width: 10,
      ),
      ElevatedButton.icon(
        icon: const Icon(
          Icons.cancel_outlined,
          size: 18.0,
        ),
        label: const Text('Cancel Appointment'),
        onPressed: () async {
          state.onCancel(viewmodel,a['userEmail']);
        },
      ),
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
  } else if (a['status'] == 'reject') {
    return Container(
        child: Column(children: <Widget>[
      ElevatedButton.icon(
        icon: const Icon(
          Icons.info,
          size: 18.0,
        ),
        label: const Text('You have rejected this appointment!'),
        onPressed: () async {
          //state.onCancel(viewmodel);
        },
      ),
      const SizedBox(
        width: 8,
      )
    ]));
  } else if (a['status'] == 'going') {
    return Container(
        child: Column(children: <Widget>[
      ElevatedButton.icon(
        icon: const Icon(
          Icons.info,
          size: 18.0,
        ),
        label: const Text('Complete'),
        onPressed: () async {
          state.onChangeStatus(viewmodel, 'complete', a['userEmail']);
        },
      ),
      Text('Tap to complete the appointment.',
          style: TextStyle(color: Colors.black, fontSize: 12)),
      const SizedBox(
        width: 8,
      )
    ]));
  }
  return Container();
}
