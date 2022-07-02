import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_green_app/model/Appointment.dart';
import 'package:my_green_app/ui/views/appointment/appointment_user_list.dart';
import 'package:my_green_app/ui/views/appointment/appointment_screenstate.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_build_summary.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_list.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_screenstate.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RecycleCenterAppointmentBody extends StatefulWidget {
  final RecycleCenterAppointmentScreenfulState state;
  const RecycleCenterAppointmentBody({super.key, required this.state});

  @override
  State<RecycleCenterAppointmentBody> createState() =>
      _RecycleCenterAppointmentBodyState();
}

class _RecycleCenterAppointmentBodyState
    extends State<RecycleCenterAppointmentBody> {
  final StreamController _myStreamCtrl = StreamController.broadcast();
  Stream get onVariableChanged => _myStreamCtrl.stream;
  // ignore: prefer_typing_uninitialized_variables
  var stream;

  @override
  void initState() {
    super.initState();
    // stream = newStream();
  }

  /* Stream<List<Appointment>> newStream() => RecycleCenterAppointmentViewmodel()
      .getRCList()
      .map((snapshot) => snapshot.docs.map((doc) {
            var a = Appointment.fromJson(doc.data());
            a.rcName = RecycleCenterAppointmentViewmodel()
                .setName(a.recycleCenterEmail);
            a.documentId = doc.id;
            return a;
          }).toList()); */

  @override
  void dispose() {
    _myStreamCtrl.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecycleCenterAppointmentViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FutureBuilder<List<int>>(
                      future: model.trackAppointmentData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        }
                        if (snapshot.hasData) {
                          final List<int> appointmentData = snapshot.data!;
                          return Container(
                            height: MediaQuery.of(context).size.height/3,
                            margin: const EdgeInsets.all(15),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.grey,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Wrap(children: buildSummary(appointmentData))
                          );
                          /*<Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Column(children: [
                                const Text(
                                  "Appointment:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    shadows: [
                                      Shadow(
                                          color: Colors.grey,
                                          offset: Offset(1, 1),
                                          blurRadius: 5)
                                    ],
                                  ),
                                ),
                                Text(
                                  value[0].toString(),
                                  style: const TextStyle(
                                    fontSize: 38,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    shadows: [
                                      Shadow(
                                          color: Colors.grey,
                                          offset: Offset(1, 1),
                                          blurRadius: 5)
                                    ],
                                  ),
                                ),
                                Text(
                                  value[1].toString(),
                                ),
                                Text(
                                  value[2].toString(),
                                ),
                              ]),
                            )*/
                        } else {
                          return const Center(child: Text('No data found'));
                        }
                      }),
                  const SizedBox(height: 20),
                  StreamBuilder<List<Appointment>>(
                      stream: model.getAppointmentList(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
                        }
                        if (snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('There are no appointments.'));
                        }
                        if (snapshot.hasData) {
                          final appointments = snapshot.data!;

                          return ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children:
                                appointments.map(buildRCAppointment).toList(),
                          );
                        } else {
                          return const Center(child: Text('No data found'));
                        }
                      }),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                  child: widget.state.getViewContainer(context, model)),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => RecycleCenterAppointmentViewmodel(),
    );
  }
}
