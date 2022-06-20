import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/Appointment/appointment_viewmodel.dart';
import 'package:my_green_app/ui/views/appointment/appointment_viewmodel.dart'
    as second;
import 'package:my_green_app/ui/views/appointment/view/appointment_cancel_button.dart';
import 'package:my_green_app/ui/views/appointment/view/appointment_view_build_details.dart';
import 'package:my_green_app/ui/views/appointment/view/appointment_view_screen.dart';
import 'package:stacked/stacked.dart';

class AppointmentDetails extends StatelessWidget {
  second.AppointmentViewmodel view = second.AppointmentViewmodel();
  AppointmentDetailsScreenState state = AppointmentDetailsScreenState();
  AppointmentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppointmentViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(209, 239, 181, 100),
                      Color.fromRGBO(211, 250, 214, 100)
                    ]),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Center(
                  child: Container(
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(16.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListView(
                  children: [
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream:
                          second.AppointmentViewmodel().getAppointmentData(),
                      builder: (ctx, streamSnapshot) {
                        if (streamSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          );
                        }
                        if (streamSnapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
                        }
                        if (streamSnapshot.hasData) {
                          return Column(
                            children: [
                              //SizedBox(height: 5),
                              //futureBulder(streamSnapshot.data!['image']),
                              const SizedBox(height: 5),
                              buildDetails(streamSnapshot.data!),
                              const SizedBox(height: 5),
                              buildButton(streamSnapshot.data!),
                              const SizedBox(height: 5),
                            ],
                          );
                        } else {
                          return const Center(child: Text('No data found.'));
                        }
                      },
                    ),
                  ],
                ),
              )))),
      viewModelBuilder: () => AppointmentViewmodel(),
    );
  }
}
