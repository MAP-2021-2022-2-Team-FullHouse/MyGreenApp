import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_green_app/ui/views/appointment/appointment_button_list.dart';
import 'package:my_green_app/ui/views/appointment/appointment_screenstate.dart';

import '../../../model/Appointment.dart';
import 'package:my_green_app/ui/views/appointment/appointment_viewmodel.dart'
    as viewmodel;

AppointmentScreenfulState state = new AppointmentScreenfulState();

Widget buildRC(Appointment appointment) {
  int count = 0;

  return ListTile(
    leading: CircleAvatar(
        child: Container(
      child: buildImage(appointment.image),
    )),
    title: Text.rich(
      TextSpan(
        text: 'Title: ', // default text style
        children: <TextSpan>[
          TextSpan(
              text: appointment.name,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 2.5),
        Text.rich(
          TextSpan(
            text: 'Date: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: '${appointment.dateTime.day}/'
                      '${appointment.dateTime.month}/${appointment.dateTime.year}',
                  style: const TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        const SizedBox(height: 2.5),
        Text.rich(
          TextSpan(
            text: 'Time: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: DateFormat.jm().format(appointment.dateTime),
                  style: const TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        const SizedBox(height: 2.5),
        FutureBuilder<String>(
            future: viewmodel.AppointmentViewmodel()
                .getRecycleCenterName(appointment.recycleCenterEmail),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }
              if (snapshot.hasData) {
                final r = snapshot.data!;
                return Wrap(children: <Widget>[
                  Text.rich(
                    TextSpan(
                      text: 'Recycle Center: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: r,
                            style:
                                const TextStyle(fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
                ]);
              } else {
                return const Center(child: Text('No data found'));
              }
            }),
        const SizedBox(height: 1.5),
        //Text(appointment.status),
        Container(child: Row()),
        AppointmentListButton(
          view: viewmodel.AppointmentViewmodel(),
          model: appointment,
          state: AppointmentScreenfulState(),
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}

Widget buildImage(String data) {
  return ClipOval(
    child: Material(
      color: Colors.transparent,
      child: Ink.image(
        image: NetworkImage(data),
        fit: BoxFit.cover,
        width: 128,
        height: 128,
        child: InkWell(/* onTap: onClicked */),
      ),
    ),
  );
}
