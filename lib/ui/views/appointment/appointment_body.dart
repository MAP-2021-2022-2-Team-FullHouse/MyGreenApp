import 'package:flutter/material.dart';
import 'package:my_green_app/model/Appointment.dart';
import 'package:my_green_app/ui/views/appointment/appointment_user_list.dart';
import 'package:my_green_app/ui/views/appointment/appointment_screenstate.dart';
import 'package:stacked/stacked.dart';
import '../appointment/appointment_viewmodel.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;

class AppointmentBody extends StatefulWidget {
  final AppointmentScreenfulState state;
  AppointmentBody({required this.state});

  @override
  State<AppointmentBody> createState() => _AppointmentBodyState();
}

class _AppointmentBodyState extends State<AppointmentBody> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppointmentViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  StreamBuilder<List<Appointment>>(
                      stream: model.getAppointmentList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Something went wrong'));
                        }

                        if (snapshot.hasData) {
                          if (snapshot.data!.length == 0) {
                            return ListView(
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                children: [
                                  Center(
                                      child: Text(
                                          'You do not have any appointments made.')),
                                  ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.add,
                                      size: 18.0,
                                    ),
                                    label: const Text('Make An Appointment'),
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          routes.createAppointmentRoute);
                                    },
                                  ),
                                ]);
                          }
                          final appointments = snapshot.data!;

                          return ListView(
                            physics: NeverScrollableScrollPhysics(),
                            children:
                                appointments.map(buildAppointment).toList(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                          );
                        } else {
                          return ListView(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: [
                                Center(
                                    child: Text(
                                        'You do not have any appointments made.')),
                                ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.add,
                                    size: 18.0,
                                  ),
                                  label: const Text('Make An Appointment'),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        routes.createAppointmentRoute);
                                  },
                                ),
                              ]);
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
      viewModelBuilder: () => AppointmentViewmodel(),
    );
  }
}
