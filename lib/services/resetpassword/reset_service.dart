// @dart=2.9

import 'dart:async';
import 'package:flutter/foundation.dart';

abstract class ResetPasswordService {
  Future sendResetPassEmail({@required String email,Function() onSuccess,Function(Exception, String) onError});

  // this getter is to be overidden,
  Stream get stream => null;

}