// @dart=2.9
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mygreenapp/app/routes.dart';

import '../../../model/user.dart';
import '../../../app/service_locator.dart';
import '../viewmodel.dart';
import '../../../services/user/user_repository.dart';

class RegisterViewmodel extends Viewmodel {
  final UserRepository _userRepository = locator();

  RegisterViewmodel() {
    _userRepository.addListener(() {
      notifyListeners();
    });
  }

  User get user => _userRepository.user;
  String _errorMessage;
  String get errorMessage => _errorMessage;
  set errorMessage(value) => update(() => _errorMessage = value);

  Future addUser(
      {@required String email,
      @required String password,
      @required String name,
      @required String address,
      @required String phone}) async {
    dynamic result = await _userRepository.addUser(
        email: email,
        password: password,
        name: name,
        address: address,
        phone: phone);
    if (_userRepository.user != null) {
      _errorMessage = null;
    } else {
      _errorMessage = _userRepository.error;
      return _errorMessage;
    }
  }
}
