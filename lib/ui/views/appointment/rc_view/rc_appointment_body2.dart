// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_green_app/model/Appointment.dart';
import 'package:my_green_app/ui/views/appointment/appointment_rclist.dart';
import 'package:my_green_app/ui/views/appointment/appointment_screenstate.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/appointment_item.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_list.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_screenstate.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RecycleCenterAppointmentBody2 extends StatefulWidget {
  final RecycleCenterAppointmentScreenfulState state;
  RecycleCenterAppointmentBody2({required this.state});

  @override
  State<RecycleCenterAppointmentBody2> createState() =>
      _RecycleCenterAppointmentBody2State();
}

class _RecycleCenterAppointmentBody2State
    extends State<RecycleCenterAppointmentBody2> {
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
        viewModelBuilder: () => RecycleCenterAppointmentViewmodel(),
        onModelReady: (model) => model.listenToPosts(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                // ignore: sort_child_properties_last
                child: !model.isBusy
                    ? Icon(Icons.add)
                    : CircularProgressIndicator(),
                onPressed: model.navigateToCreateView,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //verticalSpace(35),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                          //child: Image.asset('assets/images/title.png'),
                        ),
                      ],
                    ),
                    Expanded(
                        child: model.posts != null
                            ? ListView.builder(
                                itemCount: model.posts.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () => model.navigateToCreateView(),
                                  child: AppointmentItem(
                                    post: model.posts[index],
                                    //onDeleteItem: () => model.deletePost(index),
                                  ),
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      Theme.of(context).primaryColor),
                                ),
                              ))
                  ],
                ),
              ),
            ));
  }
}
