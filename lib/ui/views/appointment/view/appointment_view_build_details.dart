import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_green_app/ui/views/appointment/appointment_viewmodel.dart';
import 'package:my_green_app/ui/views/appointment/view/appointment_view_screen.dart';
import 'package:my_green_app/ui/views/profile/profile_screen.dart';
import 'package:my_green_app/ui/views/profile/profile_viewmodel.dart'
    as profileviewmodel;
import 'package:my_green_app/ui/views/profile/profile_viewmodel.dart';

late final String imagePath;
late final bool isEdit;
AppointmentViewmodel model = AppointmentViewmodel();
AppointmentDetailsScreenState state = AppointmentDetailsScreenState();
//late final VoidCallback onClicked;
Widget buildDetails(DocumentSnapshot<Map<String, dynamic>> appointment) =>
    Column(
      children: [
        Container(
            width: 250,
            height: 128,
            //model.viewAppointmentID(appointment['recycleCenterEmail'], appointment['dateTime'], appointment['userEmail']
            child: futureBulder(
                model,
                appointment['recycleCenterEmail'],
                DateTime.fromMicrosecondsSinceEpoch(
                    appointment['dateTime'].microsecondsSinceEpoch),
                appointment['userEmail'])),
        const SizedBox(height: 10),
        Text(
          appointment['name'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 10),
        FutureBuilder<String>(
            future:
                model.getRecycleCenterName(appointment['recycleCenterEmail']),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }
              if (snapshot.hasData) {
                final r = snapshot.data!;
                return Wrap(children: <Widget>[
                  Text.rich(
                    TextSpan(
                      text: "Recycle Center: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: r,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14)),
                      ],
                    ),
                  ),
                ]);
              } else {
                return const Center(child: Text('No data found'));
              }
            }),
        FutureBuilder<String>(
            future:
                model.getRecycleCenterPhone(appointment['recycleCenterEmail']),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }
              if (snapshot.hasData) {
                final r = snapshot.data!;
                return Wrap(children: <Widget>[
                  Text.rich(
                    TextSpan(
                      text: "Contact number: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900]),
                      children: <TextSpan>[
                        TextSpan(
                            text: r,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14)),
                      ],
                    ),
                  ),
                ]);
              } else {
                return const Center(child: Text('No data found'));
              }
            }),
        Text.rich(
          TextSpan(
            text: "Date: ",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.green[900]),
            children: <TextSpan>[
              TextSpan(
                  text:
                      "${DateTime.fromMicrosecondsSinceEpoch(appointment['dateTime'].microsecondsSinceEpoch).day}/${DateTime.fromMicrosecondsSinceEpoch(appointment['dateTime'].microsecondsSinceEpoch).month}/${DateTime.fromMicrosecondsSinceEpoch(appointment['dateTime'].microsecondsSinceEpoch).year}",
                  style: const TextStyle(color: Colors.black, fontSize: 14)),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: "Time: ",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.green[900]),
            children: <TextSpan>[
              TextSpan(
                  text: buildTime(DateTime.fromMicrosecondsSinceEpoch(
                      appointment['dateTime'].microsecondsSinceEpoch)),
                  style: const TextStyle(color: Colors.black, fontSize: 14)),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Text.rich(
          TextSpan(
            text: "Status: ",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.green[900]),
            children: <TextSpan>[
              TextSpan(
                  text: appointment['status'],
                  style: const TextStyle(color: Colors.black, fontSize: 14)),
            ],
          ),
        ),
        const SizedBox(height: 15),
      ],
    );

Widget futureBulder(AppointmentViewmodel viewmodel, String rcEmail, DateTime dt,
    String uEmail) {
  return FutureBuilder<dynamic>(
      future: state.getImages(viewmodel, rcEmail, dt, uEmail),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        bool error = snapshot.data == null;
        return snapshot.connectionState == ConnectionState.waiting
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    snapshot.data!.length,
                    (index) {
                      return buildIMG(snapshot.data![index]['url'], index);
                    },
                  ),
                ));
        /* return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return Image(image: NetworkImage(snapshot.data![index]['url']));
          },
        ); */
      });
}

Widget buildIMG(String url, int index) {
  return Row(children: [
    Image(image: NetworkImage(url)),
    const SizedBox(width: 5),
  ]);
}

String buildTime(DateTime dt) {
  return DateFormat.jm().format(dt);
}
