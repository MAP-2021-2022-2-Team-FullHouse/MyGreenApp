import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/home/home_screenState.dart';
import '../home/rc_home_viewmodel.dart';

class RCHomeBody extends StatelessWidget {
  final HomeScreenfulState state;
  const RCHomeBody({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RecycleCenterHomeViewmodel viewmodel = RecycleCenterHomeViewmodel();

    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          const Text(
            'Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FutureBuilder<List<int>>(
              future: viewmodel.trackAppointmentData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (snapshot.hasData) {
                  final List<int> appointmentData = snapshot.data!;
                  return Container(
                      margin: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                      //padding: const EdgeInsets.symmetric(horizontal: 80),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white,
                        //Color.fromARGB(156, 11, 205, 27),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          //runSpacing: 5,
                          children: buildSummary(appointmentData)));
                          } else {
                  return const Center(child: Text('No data found'));
                }
              }),
            const SizedBox(height: 5),
          const SizedBox(height: 50),
          //       ViewModelBuilder<HomeViewmodel>.reactive(
          //   builder: (context, viewmodel, child)
          //      { return LogoutButton(viewmodel: viewmodel, state: state);},
          //   viewModelBuilder: () => HomeViewmodel(),
          // ),
        ],
      ),
    );
  }
}
