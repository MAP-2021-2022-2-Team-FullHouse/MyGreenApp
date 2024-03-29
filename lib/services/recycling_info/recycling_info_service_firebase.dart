import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_green_app/model/recycling_info.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'recycling_info_service.dart';

class RecyclingInfoServiceFirebase extends RecyclingInfoService {
  final navigator = NavigatorService();
  final storageInstance = FirebaseStorage.instance;
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Future addRecyclingInfo(
      {required String title,
      required String content,
      required String image,
      File? file}) async {
    final recyclingInfo = firestoreInstance.collection('RecyclingInfo').doc();
    try {
      String? img = '';
      int pos = image.indexOf('.');
      img = "${recyclingInfo.id}${image.substring(pos)}";
      recyclingInfo.set({
        'infoId': recyclingInfo.id,
        "title": title,
        "content": content,
        "image": img,
        "createdDate": DateTime.now(),
        "lastModifiedDate": DateTime.now(),
      });
      if (file != null) {
        uploadFile(img, file);
      }
      return "ok";
    } on FirebaseException catch (e) {
      return e;
    }
  }

  @override
  Future editRecyclingInfo(
      {required String infoId,
      required String title,
      required String content,
      required String image,
      File? file}) async {
    try {
      firestoreInstance.collection('RecyclingInfo').doc(infoId).update({
        "title": title,
        "content": content,
        "lastModifiedDate": DateTime.now(),
      });
      if (file != null) {
        String? img = '';
        int pos = image.indexOf('.');
        img = "$infoId${image.substring(pos)}";
        uploadFile(img, file);
        firestoreInstance.collection('RecyclingInfo').doc(infoId).update({
          "image": img,
        });
      }
      return "ok";
    } on FirebaseException catch (e) {
      return e;
    }
  }

  static Future<UploadTask?> uploadFile(String img, File file) async {
    try {
      final destination = "recyclingInfo/$img";
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
      // ignore: unused_catch_clause
    } on FirebaseException catch (e) {
      return null;
    }
  }

  @override
  Stream<List<RecyclingInfo>> readRecyclingInfoList() =>
      FirebaseFirestore.instance
          .collection('RecyclingInfo')
          .orderBy('createdDate', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => RecyclingInfo.fromJson(doc.data()))
              .toList());

  @override
  Future<String> getRecyclingInfoImage(String pathname) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(pathname);
      String imageUrl = await ref.getDownloadURL();
      //print(imageUrl);
      return imageUrl;
    } catch (e) {
      //print("Error: $e");
      return e.toString();
    }
  }

  @override
  Future<RecyclingInfo?> readRecyclingInfo(String infoId) async {
    final recyclingInfo =
        FirebaseFirestore.instance.collection("RecyclingInfo").doc(infoId);
    final snapshot = await recyclingInfo.get();
    if (snapshot.exists) {
      return RecyclingInfo.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }

  @override
  Future deleteRecyclingInfo(String infoId) async {
    //Get Image
    final recyclingInfo =
        FirebaseFirestore.instance.collection("RecyclingInfo").doc(infoId);
    final snapshot = await recyclingInfo.get();
    final image = RecyclingInfo.fromJson(snapshot.data()!).image.toString();
    //return recyclingInfo.image;
    final imagePath = "recyclingInfo/$image";
    // Create a reference to the file to delete
    final storageRef = storageInstance.ref();
    // Create a child reference
    final imageRef = storageRef.child(imagePath);
    // Delete the file
    await imageRef.delete();
    await firestoreInstance.collection("RecyclingInfo").doc(infoId).delete();
    return "ok";
  }
}


  /*
  static Future<String> getImageName(String infoId) async {
    final recyclingInfo =
        FirebaseFirestore.instance.collection("RecyclingInfo").doc(infoId);
    final snapshot = await recyclingInfo.get();
    if (snapshot.exists) {
      final recyclingInfo = RecyclingInfo.fromJson(snapshot.data()!);
      return recyclingInfo.image.toString();
    } else {
      return '';
    }
  }*/

