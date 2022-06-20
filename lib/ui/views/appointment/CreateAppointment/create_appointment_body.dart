import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/appointment/CreateAppointment/create_appointment_upload.dart';
import 'package:stacked/stacked.dart';
import 'create_appointment_screen.dart';
import 'create_appointment_textfield.dart';
import 'create_appointment_button.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:my_green_app/constants/routes_path.dart' as routes;

import 'create_appointment_viewmodel.dart';

class CreateAppointmentBody extends StatelessWidget {
  final CreateAppointmentScreenState _state;
  UploadTask? task;
  File? file;
  CreateAppointmentBody(this._state);

  @override
  Widget build(BuildContext context) {
    CreateAppointment_ViewModel vm = CreateAppointment_ViewModel();

    return ViewModelBuilder<CreateAppointment_ViewModel>.reactive(
      builder: (context, viewmodel, _) => Scaffold(
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
              child: SingleChildScrollView(
                  child: Column(children: [
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      const Text(
                        "Recycling Appointment",
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(
                                color: Colors.grey,
                                offset: Offset(2, 1),
                                blurRadius: 5)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      ...buildCreateTextFields(_state),
                      if (viewmodel.errorMessage != null)
                        Text(
                          viewmodel.errorMessage,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 20.0),
                        ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddImage()),
                          );
                        },
                        child: const Text('Attach Images'),
                      ),
                      const SizedBox(height: 10.0),
                      CreateButton(state: _state),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                )
              ])))),
      viewModelBuilder: () => CreateAppointment_ViewModel(),
    );
  }
}
