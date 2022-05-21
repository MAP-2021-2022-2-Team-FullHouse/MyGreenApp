// @dart=2.9
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mygreenapp/app/app.dart';
import 'package:mygreenapp/app/service_locator.dart';
import '../viewmodel.dart';
import '../../../services/user/user_repository.dart';

class ResetViewmodel extends Viewmodel {
  final UserRepository _userRepository = locator();

  ResetViewmodel() {
    _userRepository.addListener(() {
      notifyListeners();
    });
  }

  User get user => _userRepository.user.copyWith();
  String _errorMessage;
  String get errorMessage => _errorMessage;
  set errorMessage(value) => update(() => _errorMessage = value);

  Future sendResetPassEmail({@required String email}) async {
    dynamic result = await _userRepository.sendResetPassEmail(email: email);
    if (_userRepository.error != null) {
      //_errorMessage = null;
      _errorMessage = _userRepository.error;
      return _errorMessage;
    } else {
      _errorMessage = " ";
      return _errorMessage;
    }
  }
}
