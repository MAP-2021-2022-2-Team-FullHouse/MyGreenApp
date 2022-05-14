// @dart=2.9

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../model/user.dart'
    as AppUser; // To resolve conflict with firebase 'User' class

import '../firebase.dart';
import 'registration_service.dart';

class RegistrationServiceFirebase extends RegistrationService {
  final _firebaseAuth = FirebaseAuthentication();
  FirebaseAuth get _auth => _firebaseAuth.auth;
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Future<void> addUser(
      {@required String email,
      @required String password,
      @required String name,
      @required String address,
      @required String phone,
      Function onSuccess,
      Function(Exception) onError}) async {
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
        "address": address
      }).then((value) {
        print('User added');
      });
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = credential?.user;

      if (user == null) return;

      onSuccess?.call(transformUserData(user));
    } on FirebaseAuthException catch (e) {
      onError?.call(e);
    }
  }

  AppUser.User transformUserData(dynamic userData) {
    if (userData == null) return null;

    final User user = userData; // Firebase Auth User class

    return AppUser.User(
      // User data that are passed to Viewmodel is in the form our own User model class (not Firebase Auth user)
      username: user.email,
      email: user.email,
      name: user.displayName,
      uid: user.uid,
    );
  }

  @override
  Future<void> signOut({Function onSuccess, Function(Exception p1) onError}) {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
