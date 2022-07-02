import 'package:flutter/material.dart';
import 'rc_appointment_screen.dart';

List<Widget> buildSummary(List<int> appointmentData) =>
[
  SizedBox.fromSize(
    size: const Size.square(15),
    child: Text('This week\n\n${appointmentData[0]}'),
  ),
  SizedBox.fromSize(
    size: const Size.square(15),
    child: Text('This month\n\n${appointmentData[1]}'),
  ),
  SizedBox.fromSize(
    size: const Size.square(15),
    child: Text('This year\n\n${appointmentData[2]}'),
  ),
  SizedBox.fromSize(
    size: const Size.square(15),
    child: Text('Pending\n\n${appointmentData[3]}'),
  ),
  SizedBox.fromSize(
    size: const Size.square(15),
    child: Text('Accepted\n\n${appointmentData[4]}'),
  ),
  SizedBox.fromSize(
    size: const Size.square(15),
    child: Text('In-Progress\n\n${appointmentData[5]}'),
  ),
  SizedBox.fromSize(
    size: const Size.square(15),
    child: Text('Rejected\n\n${appointmentData[6]}'),
  ),
  SizedBox.fromSize(
    size: const Size.square(15),
    child: Text('Cancelled\n\n${appointmentData[7]}'),
  ),
  SizedBox.fromSize(
    size: const Size.square(15),
    child: Text('Completed\n\n${appointmentData[8]}'),
  ),
];