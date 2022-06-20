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
    //String id = ' ';
    //String id = firestoreInstance.collection("RecyclingInfo").id;
    final recyclingInfo =
        FirebaseFirestore.instance.collection('RecyclingInfo').doc();
    try {
      /*
      firestoreInstance.collection("RecyclingInfo").add({
        "title": title,
        "content": content,
        "image": image,
        "createdDate": DateTime.now()
      }).then((value) {
        id = value.id;
      });
      
      firestoreInstance.collection("RecyclingInfo").doc(id).set({
        "infoId": id,
        "title": title,
        "content": content,
        "image": image,
        "createdDate": DateTime.now(),
      });*/
      //firestoreInstance.collection("RecyclingInfo").doc(id).set({"infoId": id});
      String? img = '';
      int pos = image.indexOf('.');
      img = "${recyclingInfo.id}${image.substring(pos)}";
      recyclingInfo.set({
        'infoId': recyclingInfo.id,
        "title": title,
        "content": content,
        "image": img,
        "createdDate": DateTime.now(),
      });
      /*firestoreInstance.collection('RecyclingInfo').doc(id).set(
          {'infoId': id, 'image': img}, SetOptions(merge: true)).then((value) {
        //Do your stuff.
      });*/
      /*
      await firestoreInstance
          .collection('RecyclingInfo')
          .doc(id)
          .set({"infoId": id, "image": img}, SetOptions(merge: true));*/
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
  Stream<List<RecyclingInfo>> readRecyclingInfoList() =>
      FirebaseFirestore.instance.collection('RecyclingInfo').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => RecyclingInfo.fromJson(doc.data()))
              .toList());

  @override
  Future<String> getRecyclingInfoImage(String pathname) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(pathname);
      String imageUrl = await ref.getDownloadURL();
      print(imageUrl);
      return imageUrl;
    } catch (e) {
      print("Error: $e");
      return e.toString();
    }
  }

  @override
  Future<RecyclingInfo?> readRecyclingInfo(String infoId) async {
    final rc =
        FirebaseFirestore.instance.collection("RecycleCenter").doc(infoId);
    final snapshot = await rc.get();
    if (snapshot.exists) {
      return RecyclingInfo.fromJson(snapshot.data()!);
    } else {
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
