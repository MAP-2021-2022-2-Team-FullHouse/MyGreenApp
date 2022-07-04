import 'package:flutter/material.dart';

//fontWeight: FontWeight.bold,
List<Widget> buildSummary(List<int> appointmentData) => [
      Container(
        width: 90,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color.fromRGBO(211, 250, 214, 100),
        ),
        child: Text(
          'This week\n\n${appointmentData[0]}',
          style: const TextStyle(
              fontSize: 15, fontWeight:FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        width: 90,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color.fromRGBO(211, 250, 214, 100),
        ),
        child: Text(
          'This month\n${appointmentData[1]}',
          style: const TextStyle(fontSize: 15, fontWeight:FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        width: 90,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color.fromRGBO(211, 250, 214, 100),
        ),
        child: Text(
          'This year\n\n${appointmentData[2]}',
          style: const TextStyle(fontSize: 15, fontWeight:FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        width: 90,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color.fromRGBO(211, 250, 214, 100),
        ),
        child: Text(
          'Pending\n\n${appointmentData[3]}',
          style: const TextStyle(fontSize: 15, fontWeight:FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        width: 90,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color.fromRGBO(211, 250, 214, 100),
        ),
        child: Text(
          'Accepted\n\n${appointmentData[4]}',
          style: const TextStyle(fontSize: 15, fontWeight:FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        width: 90,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color.fromRGBO(211, 250, 214, 100),
        ),
        child: Text(
          'Going\n\n${appointmentData[5]}',
          style: const TextStyle(fontSize: 15, fontWeight:FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        width: 90,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color.fromRGBO(211, 250, 214, 100),
        ),
        child: Text(
          'Rejected\n\n${appointmentData[6]}',
          style: const TextStyle(fontSize: 15, fontWeight:FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        width: 90,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color.fromRGBO(211, 250, 214, 100),
        ),
        child: Text(
          'Cancelled\n\n${appointmentData[7]}',
          style: const TextStyle(fontSize: 15, fontWeight:FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        width: 90,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color.fromRGBO(211, 250, 214, 100),
        ),
        child: Text(
          'Complete\n\n${appointmentData[8]}',
          style: const TextStyle(fontSize: 15, fontWeight:FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    ];
