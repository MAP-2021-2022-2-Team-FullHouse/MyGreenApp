import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/constants/routes_path.dart';
import 'package:my_green_app/model/Appointment.dart';
import 'package:my_green_app/model/user.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'package:my_green_app/services/appointment/appointment_service.dart';
import 'package:my_green_app/services/user/user_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;

class AppointmentViewmodel extends BaseViewModel {
  /* StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null; */
  late final _dialogService = locator<DialogService>();
  late final _AppointmentService = locator<AppointmentService>();
  late final _authenticationService = locator<AuthenticationService>();

  late List<Appointment> _rc = <Appointment>[];
  List<Appointment> get rc => _rc;
  static Appointment appointment = Appointment(dateTime: DateTime.now());
  Appointment get getRC => appointment;
  static late File? file;
  static String chosenID = '';
  static late String fileName;
  int rcIndex = 0;
  static String appointmentID = '';
  static bool viewAction = false;
  bool get isViewAction => viewAction;
  static String name = '';
  static String rcEmail = '';
  static DateTime chosenDT = DateTime.now();
  static String u = '';
  List recycleCenterEmails = [];
  List recycleCenterNames = [];
  String rcName = '';
  AppointmentViewmodel() {}

  Stream<List<Appointment>> getRCList() {
    var results = _AppointmentService.readRC();

    //print(results as List<Appointment>);

    return results;
  }

  String setName(String email) {
    getRecycleCenterName(email);
    return rcName;
  }

  Future viewAppointmentID(String rcEmail, DateTime dt, String uEmail) async {
    appointmentID =
        await _AppointmentService.readAppointmentID(rcEmail, dt, uEmail);
    if (appointmentID != null) {
      NavigationService().navigateTo(appointmentDetailsRoute);
    }
  }

  Future<String> getRecycleCenterName(String email) async {
    rcName = await _AppointmentService.retrieveRecycleCenterName(email);
    return rcName;
  }

  Future<String> getRecycleCenterPhone(String email) async {
    var phone = await _AppointmentService.retrievePhone(email);
    return phone;
  }

  Future cancelAppointment(String id) async {
    await _AppointmentService.cancelAppointment(id);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getAppointmentData() {
    //Future.delayed(Duration(milliseconds: 5000));
    print(chosenID + "here stream");
    return _AppointmentService.getAppointment(chosenID);
  }

  Future getAppointmentID(String rcEmail, DateTime dt, String uEmail) async {
    appointmentID = await _AppointmentService.getID(rcEmail, dt, uEmail);
  }

  Future getImgUrls(String id) async {
    var result = _AppointmentService.getPhotoURLs(id);
    return result;
  }
}
