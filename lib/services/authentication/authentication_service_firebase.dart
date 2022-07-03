import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/services/navigation_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../model/user.dart' as AppUser;

import '../firebase.dart';
import 'authentication_service.dart';

class AuthenticationServiceFirebase extends AuthenticationService {
  final _firebaseAuth = FirebaseAuthentication();
  FirebaseAuth get _auth => _firebaseAuth.auth;
  final navigator = NavigatorService();

  @override
  String? getCurrentUserEmail() {
    return _auth.currentUser!.email;
  }

  @override
  Future<String> getDevice(String userid) async {
    final docUser = FirebaseFirestore.instance.collection('User').doc(userid);
    final snapshot = await docUser.get();
    return AppUser.User.fromJson(snapshot.data()).deviceToken;
    //return role;
  }

  @override
  Future signIn({required String email, required String password}) async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;

      if (user == null) {
        return;
      } else {
        print(_auth.currentUser?.uid);
        FirebaseMessaging.instance.getToken().then((token) {
          FirebaseFirestore.instance
              .collection('User')
              .doc(_auth.currentUser?.uid)
              .update({'fcmToken': token});
        });
        return user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return e.code;
      } else if (e.code == 'user-not-found') {
        return e.code;
      }
      return e.code;
    }
  }

  @override
  Future<String> getRole(String userid) async {
    final docUser = FirebaseFirestore.instance.collection('User').doc(userid);
    final snapshot = await docUser.get();
    return AppUser.User.fromJson(snapshot.data()).role;
    //return role;
  }

  @override
  Future readUser(String docID) async {
    final docUser = FirebaseFirestore.instance.collection('User').doc(docID);
    final snapshot = await docUser.get();
    return AppUser.User.fromJson(snapshot.data());
  }

  @override
  Future signOut() async {
    try {
      await _auth.signOut();
      return FirebaseAuth.instance.currentUser;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<String> getCurrentRole() async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final docUser = FirebaseFirestore.instance.collection('User').doc(uid);
    final snapshot = await docUser.get();
    return AppUser.User.fromJson(snapshot.data()).role;
  }

  static Future<String> getCurrentEmail() async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final docUser = FirebaseFirestore.instance.collection('User').doc(uid);
    final snapshot = await docUser.get();
    return AppUser.User.fromJson(snapshot.data()).email;
  }

  static String getCurrentID() => FirebaseAuth.instance.currentUser!.uid;

  static Future<String> getCurrentUserName(docid) async {
    final docUser = FirebaseFirestore.instance.collection('User').doc(docid);
    final snapshot = await docUser.get();
    return AppUser.User.fromJson(snapshot.data()).name;
  }

  @override
  Future<String> getPhoneNo(String userid) async {
    final docUser = FirebaseFirestore.instance.collection('User').doc(userid);
    final snapshot = await docUser.get();
    return AppUser.User.fromJson(snapshot.data()).phone;
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUser() {
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance.collection('User').doc(uid).snapshots();
  }

  static Future<UploadTask?> uploadFile(String destination, File file) async {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      print("error");
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  @override
  Future<String> getImage(String pathname) async {
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
  Future updateUser(AppUser.User user) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('User')
          .doc(uid)
          .update(user.updateFirestore());
      return true;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  @override
  Future getUserRole() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String role = '';
      await FirebaseFirestore.instance
          .collection('User')
          .doc(uid)
          .get()
          .then((value) {
        role = value.data()?['role'];
      });
      return role;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  @override
  Future getUserName() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String name = '';
      await FirebaseFirestore.instance
          .collection('User')
          .doc(uid)
          .get()
          .then((value) {
        name = value.data()?['name'];
      });
      return name;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}
