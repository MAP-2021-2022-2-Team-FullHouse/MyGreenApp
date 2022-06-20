import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_green_app/model/recycling_info.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'recycling_info_service.dart';

class RecyclingInfoServiceFirebase extends RecyclingInfoService {
  final navigator = NavigatorService();
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Future addRecyclingInfo(
      {required String title,
      required String content,
      required String image,
      //required String createdDate,
      File? file}) async {
    String id = ' ';
    try {
      firestoreInstance.collection("RecyclingInfo").add({
        "title": title,
        "content": content,
        "image": image,
        "createdDate": DateTime.now()
      }).then((value) {
        id = value.id;
      });
      firestoreInstance.collection("RecyclingInfo").doc(id).set({"infoId": id});
      String? img = '';
      int pos = image.indexOf('.');
      img = "${id}${image.substring(pos)}";
      if (file != null) {
        uploadFile(img, file);
      }
      return "ok";
    } on FirebaseException catch (e) {
      return e;
    }
  }

  static Future<UploadTask?> uploadFile(String img, File file) async {
    try {
      final destination = "recyclingInfo/" + img;
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  @override
  Future deleteRecyclingInfo(String infoId) async {
    try {
      await firestoreInstance.collection("RecyclingInfo").doc(infoId).delete();
      return true;
    } on FirebaseException catch (e) {
      return e.code + ". Something went wrong. Please try again.";
    }
  }

/*  static Future<UploadTask?> uploadImage(String destination, File file) async {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }*/
}
