import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/services/navigation_service.dart';

import '../firebase.dart';
import 'recycleCenter_service.dart';

class RecycleCenterServiceFirebase extends RecycleCenterService {
  final navigator = NavigationService();
  final firestoreInstance = FirebaseFirestore.instance;
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('RecycleCenter');

  @override
  Future deleteCenter(String documentId) async {
    try {
      await firestoreInstance
          .collection("RecycleCenter")
          .doc(documentId)
          .delete();
      /* if (firestoreInstance.collection("RecycleCenter").doc(documentId).get() ==
          null) {
        return true;
      } */
    } on FirebaseException catch (e) {
      return e.code;
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
  Stream<List<RecycleCenter>> readRC()=>FirebaseFirestore.instance
  .collection('RecycleCenter')
  .snapshots()
  .map((snapshot) => snapshot.docs.map((doc) => RecycleCenter.fromJson(doc.data())).toList());
}
