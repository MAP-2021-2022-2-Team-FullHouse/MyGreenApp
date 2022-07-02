import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/constants/routes_path.dart';
import 'package:my_green_app/model/Appointment.dart';
import 'package:my_green_app/services/appointment/appointment_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppointmentViewmodel extends BaseViewModel {
  // ignore: non_constant_identifier_names
  late final _AppointmentService = locator<AppointmentService>();

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
  AppointmentViewmodel();

  Stream<List<Appointment>> getAppointmentList() {
    var results = _AppointmentService.readUserAppointment();

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

  Future cancelAppointment(String id, String rcEmail) async {
    await _AppointmentService.cancelAppointment(id, rcEmail);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getAppointmentData() {
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
