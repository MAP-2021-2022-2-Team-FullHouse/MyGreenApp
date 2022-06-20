import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_green_app/model/Appointment.dart';
import 'package:my_green_app/ui/views/appointment/appointment_rclist.dart';
import 'package:my_green_app/ui/views/appointment/appointment_screenstate.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_list.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_screenstate.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RecycleCenterAppointmentBody extends StatefulWidget {
  final RecycleCenterAppointmentScreenfulState state;
  RecycleCenterAppointmentBody({required this.state});

  @override
  State<RecycleCenterAppointmentBody> createState() =>
      _RecycleCenterAppointmentBodyState();
}

class _RecycleCenterAppointmentBodyState
    extends State<RecycleCenterAppointmentBody> {
  final StreamController _myStreamCtrl = StreamController.broadcast();
  Stream get onVariableChanged => _myStreamCtrl.stream;
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
                  /* const SizedBox(height: 10),
                  Container(
                    width: 350,
                    height: 50,
                    //child:
                  ), */
                  const SizedBox(height: 20),
                  StreamBuilder<List<Appointment>>(
                      stream: model.getRCList(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text('Something went wrong'));
                        }
                        if (snapshot.hasData) {
                          final appointments = snapshot.data!;

                          return ListView(
                            physics: NeverScrollableScrollPhysics(),
                            children: appointments.map(buildRC2).toList(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                          );
                        } else {
                          return Center(child: Text('No data found'));
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
