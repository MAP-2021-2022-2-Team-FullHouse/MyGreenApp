import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_green_app/model/Appointment.dart';

abstract class AppointmentService {
  Future addAppointment(
      {required String name,
      required String category,
      required String deliveryMethod,
      required String userEmail,
      required String rcEmail,
      required String quantity,
      required String remark,
      required String dateTime,
      List<File>? imageURLs});
  Stream<DocumentSnapshot<Map<String, dynamic>>> getAppointment(String id);
  Stream<List<Appointment>> readRCAppointments();
  Future<String> readAppointmentID(String rcEmail, DateTime dt, String uEmail);
  Future<String> retrieveRecycleCenterName(String email);
  Future<String> retrieveUserName(String email);
  Future<String> retrievePhone(String email);
  Future<String> retrieveUserDevice(String email);
  Future<String> getID(String rcEmail, DateTime dt, String uEmail);
  Stream<List<Appointment>> readUserAppointment();
  String? getEmail();
  Future cancelAppointment(String id, String oppositeEmail);
  Future changeAppointmentStatus(String id, String status, String email);
  Future getPhotoURLs(String id);
  Future readPhoto(String email);
  //Future getPostsOnceOff();
  //Stream listenToPostsRealTime();
}