import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/user.dart' as AppUser;

import '../firebase.dart';
import 'registration_service.dart';

class RegistrationServiceFirebase extends RegistrationService {
  final _firebaseAuth = FirebaseAuthentication();
  FirebaseAuth get _auth => _firebaseAuth.auth;
  final firestoreInstance = FirebaseFirestore.instance;
  final role = "user";

  @override
  Future addUser(
      {required String email,
      required String password,
      required String name,
      required String address,
      required String phone}) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      firestoreInstance.collection("User").doc(userCredential.user?.uid).set({
        "name": name,
        "phone": phone,
        "email": email,
        "address": address,
        "role": role,
      }).then((value) {
        print('User added');
      });
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = credential.user;
      print(credential.user?.uid);
      if (user == null) {
        return;
      } else {
        return transformUserData(user);
      }
    } on FirebaseAuthException catch (e) {
      String error;
      if (e.code == 'weak-password') {
        error = 'weak-password';
      } else if (e.code == 'email-already-in-use') {
        error = 'email-already-in-use';
      } else {
        error = "Something went wrong";
      }
      return error;
    }
  }

  @override
  AppUser.User? transformUserData(dynamic userData) {
    if (userData == null) return null;
    final User user = userData;
    return AppUser.User(email: userData.email, uid: user.uid);
  }
}
