// @dart=2.9

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../firebase.dart';
import 'reset_service.dart';

class ResetPasswordServiceFirebase extends ResetPasswordService {
  final _firebaseAuth = FirebaseAuthentication();
  FirebaseAuth get _auth => _firebaseAuth.auth;

  @override
  Future sendResetPassEmail(
      {@required String email,
      Function() onSuccess,
      Function(Exception, String) onError}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      onSuccess?.call();
    } on FirebaseAuthException catch (e) {
      String error;
      if (e.code == 'invalid-email') {
        error = 'invalid-email';
      } else if (e.code == 'user-not-found') {
        error = 'user-not-found';
      }
      onError?.call(e, error);
    }
  }
}
