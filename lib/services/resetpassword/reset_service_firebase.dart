import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase.dart';
import 'reset_service.dart';

class ResetPasswordServiceFirebase extends ResetPasswordService {
  final _firebaseAuth = FirebaseAuthentication();
  FirebaseAuth get _auth => _firebaseAuth.auth;
  late String error;

  @override
  Future sendResetPassEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      //onSuccess?.call();
    } on FirebaseAuthException catch (e) {
      String error;
      if (e.code == 'invalid-email') {
        error = 'invalid-email';
        //onError?.call(e, error);
      } else if (e.code == 'user-not-found') {
        error = 'user-not-found';
        //onError?.call(e, error);
      } else {
        error = "Something went wrong";
        //onError?.call(e, error);
      }
      return error;
    }
  }
}
