// @dart=2.9
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mygreenapp/app/app.dart';
import 'package:mygreenapp/app/routes.dart';
import 'package:mygreenapp/app/service_locator.dart';
import 'package:mygreenapp/services/navigation_service.dart';
import 'package:mygreenapp/ui/screen/home/home_screen.dart';

import '../../../model/user.dart';
import '../viewmodel.dart';
import '../../../services/user/user_repository.dart';

class LoginViewmodel extends Viewmodel {
  final UserRepository _userRepository = locator();
  final _navigationService = locator<NavigationService>();

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
      //_navigationService.navigateTo('/home');

    } else {
      _errorMessage = _userRepository.error;
    }
  }
}
