//@dart=2.9
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygreenapp/app/app.dart';
import 'package:mygreenapp/services/authentication/authentication_service.dart';
import 'package:mygreenapp/services/resetpassword/reset_service.dart';
import 'package:mygreenapp/services/navigation_service.dart';
import 'package:mygreenapp/services/registration/registration_service.dart';
import 'package:mygreenapp/services/repository.dart';
import 'package:mygreenapp/ui/screen/home/home_screen.dart';

import '../../model/user.dart';
import '../../app/service_locator.dart';

class UserRepository extends Repository {
  User _user;
  String _error;
  StreamSubscription _streamObserver;
  bool get isObservingStream => _streamObserver != null;

  User get user => _user;
  String get error => _error;

  final AuthenticationService _authService = locator();
  final ResetPasswordService _resetPassService = locator();
  final RegistrationService _registrationService = locator();
  final NavigationService navigator = NavigationService();

  UserRepository() {
    _streamObserver = _authService.observeStream(
      onData: (user) async {
        await notifyListeners(onNotify: () async {
          _user = user?.copyWith();
          //The above line means,  _user =  user != null ? user.copyWith() : null

          _error = null;
        });
      },
      onError: (e) async {
        await notifyListeners(onNotify: () async {
          _user = null;
          _error = e.toString();
        });
      },
    );
  }

  Future _signIn(String email, String password) => _authService.signIn(
        email: email,
        password: password,
        onSuccess: (user) {
          _user = user.copyWith();
          _error = null;
          print('yeah2');
          return "Login";
          //navigator.navigateTo('/home');
        },
        onError: (e) async {
          _user = null;
          _error = e.toString();
          print(e);
          await notifyListeners();
          return e;
          /* if (_error == 'wrong-password') {
            return 'Password';
          } else if (_error == 'user-not-found') {
            return 'User';
          } */
        },
      );

  Future signIn({@required String email, @required String password}) async {
    if (_user != null) return; // sign in only if not signed in

    if (isObservingStream) {
      await _signIn(email, password);
    } else {
      await notifyListeners(onNotify: () => _signIn(email, password));
    }
  }

  Future _addUser(String email, String password, String name, String address,
          String phone) =>
      _registrationService.addUser(
        email: email,
        password: password,
        name: name,
        address: address,
        phone: phone,
        onSuccess: (user) {
          _user = user.copyWith();
          _error = "";
        },
        onError: (e, text) async {
          _user = null;
          _error = text;
          await notifyListeners();
        },
      );

  Future addUser(
      {@required String email,
      @required String password,
      @required String name,
      @required String address,
      @required String phone}) async {
    if (isObservingStream) {
      await _addUser(email, password, name, address, phone);
    } else {
      await notifyListeners(
          onNotify: () => _addUser(email, password, name, address, phone));
    }
  }

  Future _sendResetPassEmail(String email) =>
      _resetPassService.sendResetPassEmail(
        email: email,
        onSuccess: () {
          _user = user.copyWith();
          _error = "";
        },
        onError: (e, text) async {
          _user = User();
          _error = text;
          await notifyListeners();
          return _error;
        },
      );

  Future sendResetPassEmail({String email}) async {
    if (isObservingStream) {
      await _sendResetPassEmail(email);
    } else {
      await notifyListeners(onNotify: () => _sendResetPassEmail(email));
    }
  }

  Future<void> signOut() async {
    if (_user == null) return;

    await notifyListeners(
        onNotify: () => _authService.signOut(
            onSuccess: () => {_user = null, _error = null, print("logout")}));
  }

  @override
  void dispose() {
    _streamObserver.cancel();
    super.dispose();
  }
}
