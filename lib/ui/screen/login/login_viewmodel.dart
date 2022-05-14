// @dart=2.9
import 'package:flutter/foundation.dart';
import 'package:mygreenapp/app/service_locator.dart';

import '../../../model/user.dart';
import '../viewmodel.dart';
import '../../../services/user/user_repository.dart';

class LoginViewmodel extends Viewmodel {
  final UserRepository _userRepository = locator();

  LoginViewmodel() {
    _userRepository.addListener(() {
      notifyListeners();
    });
  }

  User get user => _userRepository.user.copyWith();
  String _errorMessage;
  String get errorMessage => _errorMessage;
  set errorMessage(value) => update(() => _errorMessage = value);

  Future<void> signIn(
      {@required String email, @required String password}) async {
    await _userRepository.signIn(email: email, password: password);
    if (_userRepository.user != null) {
      _errorMessage = null;
      print(_userRepository.user.uid);
    } else {
      _errorMessage = _userRepository.error;
    }
  }
}
