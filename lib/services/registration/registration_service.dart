import 'dart:async';

import 'package:flutter/material.dart';

abstract class RegistrationService {
  Future<void> addUser(
      {@required String email,
      @required String password,
      @required String name,
      @required String address,
      @required String phone,
      Function onSuccess,
      Function(Exception, String) onError});

  // this getter is to be overidden,
  @override
  Stream? get stream => null;

  // to be overridden by concrete class
  // This method is meant for normalizing of user data, as each
  //  service has their own structure of user data

}
