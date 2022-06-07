import 'dart:async';

abstract class ResetPasswordService {
  Future sendResetPassEmail({required String email});

  // this getter is to be overidden,
  Stream? get stream => null;
}
