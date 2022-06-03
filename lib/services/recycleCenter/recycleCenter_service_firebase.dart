import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/services/navigation_service.dart';

import '../firebase.dart';
import 'recycleCenter_service.dart';

class RecycleCenterServiceFirebase extends RecycleCenterService {
  final navigator = NavigatorService();
  final firestoreInstance = FirebaseFirestore.instance;
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('RecycleCenter');

  @override
  Future deleteCenter(String docemail) async {
    try {
      String id = '';
      String rcName = '';
      await FirebaseFirestore.instance
          .collection('RecycleCenter')
          .where('email', isEqualTo: docemail)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          print(element.id);
          id = element.id;
        });
      });
      print(id);
      await firestoreInstance.collection("RecycleCenter").doc(id).delete();
      return true;
    } on FirebaseException catch (e) {
      return e.code + ". Something went wrong. Please try again.";
    }
  }

  @override
  Future getRCList() async {
    try {
      if (await RecycleCenter.getCenterList() != null) {
        //rcList = rcDocuments;
        return await RecycleCenter.getCenterList();
      } else {
        return "Error in fetching list";
      }
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Stream<List<RecycleCenter>> readRC() => FirebaseFirestore.instance
      .collection('RecycleCenter')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => RecycleCenter.fromJson(doc.data()))
          .toList());
}
