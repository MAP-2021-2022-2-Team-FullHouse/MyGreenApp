import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:my_green_app/services/resetpassword/reset_service.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'package:my_green_app/services/registration/registration_service.dart';
import 'package:my_green_app/services/repository.dart';

import '../../model/user.dart' as AppUser;

class UserRepository extends Repository {
  late AppUser.User _user;
  late String _error;

  AppUser.User get user => _user;
  String get error => _error;

  final AuthenticationService _authService = locator();
  final ResetPasswordService _resetPassService = locator();
  final RegistrationService _registrationService = locator();
  final NavigationService navigator = NavigationService();

  UserRepository() {
    _user = user.copyWith();
    _error = "";
  }

  Future _signIn(String email, String password) => _authService.signIn(
        email: email,
        password: password,
      );

  Future signIn({required String email, required String password}) async {
    if (_user != null) return;
  }

  Future _addUser(String email, String password, String name, String address,
          String phone) =>
      _registrationService.addUser(
        email: email,
        password: password,
        name: name,
        address: address,
        phone: phone,
        /* onSuccess: (user) {
          _user = user.copyWith();
          _error = "";
        },
        onError: (e, text) async {
          //_user = null;
          _error = text;
          //await notifyListeners();
        }, */
      );

  Future addUser(
      {required String email,
      required String password,
      required String name,
      required String address,
      required String phone}) async {}

  Future _sendResetPassEmail(String email) =>
      _resetPassService.sendResetPassEmail(
        email: email,
        /* onSuccess: () {
          _user = user.copyWith();
          _error = "";
        },
        onError: (e, text) async {
          //_user = null;
          _error = text;
          //await notifyListeners();
          return _error;
        }, */
      );

  Future<void> signOut() async {
    if (_user == null) return;
  }

  /* @override
  void dispose() {
    _streamObserver.cancel();
    super.dispose();
  } */
}
