import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/constants/routes_path.dart';
import 'package:my_green_app/model/Appointment.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'package:my_green_app/services/appointment/appointment_service.dart';
import 'package:my_green_app/services/user/user_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;

class RecycleCenterAppointmentViewmodel extends BaseViewModel {
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
  static String uName = '';
  static String phone = '';
  List recycleCenterEmails = [];
  List recycleCenterNames = [];
  String rcName = '';
  RecycleCenterAppointmentViewmodel() {}
  late List<Appointment> _posts = [];
  List<Appointment> get posts => _posts;

  void listenToPosts() {
    setBusy(true);
    _AppointmentService.listenToPostsRealTime().listen((postsData) {
      List<Appointment> updatedPosts = postsData;
      if (updatedPosts != null && updatedPosts.length > 0) {
        _posts = updatedPosts;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  Future navigateToCreateView() async {
    await NavigationService().navigateTo(homeRoute);
  }

  Stream<List<Appointment>> getRCList() {
    var results = _AppointmentService.readRCAppointments();

    return results;
  }

  String setName(String email) {
    getRecycleCenterName(email);
    return rcName;
  }

  String setUserName(String email) {
    getUserName(email);
    return uName;
  }

  Future viewAppointmentID(String rcEmail, DateTime dt, String uEmail) async {
    appointmentID =
        await _AppointmentService.readAppointmentID(rcEmail, dt, uEmail);
    if (appointmentID != null) {
      NavigationService().navigateTo(appointmentDetailsRoute);
    }
    //appointment = await _AppointmentService.getAppointment(appointmentID);
    //viewAction = true;
  }

  Future<String> getRecycleCenterName(String email) async {
    rcName = await _AppointmentService.retrieveRecycleCenterName(email);
    return rcName;
    //notifyListeners();
  }

  Future<String> getUserName(String email) async {
    uName = await _AppointmentService.retrieveUserName(email);
    return uName;
    //notifyListeners();
  }

  Future<String> getPhone(String email) async {
    phone = await _AppointmentService.retrievePhone(email);
    return phone;
    //notifyListeners();
  }

  Future cancelAppointment(String id) async {
    await _AppointmentService.cancelAppointment(id);
  }

  Future changeAppointmentStatus(String id, String newStatus) async {
    await _AppointmentService.changeAppointmentStatus(id, newStatus);
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
