import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_green_app/services/navigation_service.dart';

import '../../model/user.dart' as AppUser;

import '../firebase.dart';
import 'authentication_service.dart';

class AuthenticationServiceFirebase extends AuthenticationService {
  final _firebaseAuth = FirebaseAuthentication();
  FirebaseAuth get _auth => _firebaseAuth.auth;
  final navigator = NavigationService();

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
  Future signOut() async {
    try {
      await _auth.signOut();
      return FirebaseAuth.instance.currentUser;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
}
