import 'dart:async';

import 'package:mygreenapp/services/authentication/authentication_service.dart';
import 'package:mygreenapp/services/registration/registration_service.dart';
import 'package:mygreenapp/services/repository.dart';

import '../../model/user.dart';
import '../../app/service_locator.dart';

class UserRepository extends Repository {
  late User _user;
  late String _error;
  late StreamSubscription _streamObserver;
  bool get isObservingStream => _streamObserver != null;

  User get user => _user;
  String get error => _error;

  final AuthenticationService _authService = locator();
  final RegistrationService _registrationService = locator();

  UserRepository() {
    // if the auth service supports stream response (like Firebase Auth service)
    //  This is the place where the response or incoming stream data will arrive
    // Then, what it does here, it only passes / forwards the received data
    //  to the listeners of this repository (in this app example, they are LoginViewmodel and HomeViewmodel).

    _streamObserver = _authService.observeStream(
      onData: (user) async {
        await notifyListeners(onNotify: () async {
          _user = user?.copyWith();
          //The above line means,  _user =  user != null ? user.copyWith() : null

          _error = "";
        });
      },
      onError: (e) async {
        await notifyListeners(onNotify: () async {
          _user = User();
          _error = e.toString();
        });
      },
    );
  }

  Future<void> _signIn(String email, String password) => _authService.signIn(
        email: email,
        password: password,
        onSuccess: (user) {
          _user = user.copyWith();
          _error = "";
        },
        onError: (e) async {
          _user = User();
          _error = e.toString();
          await notifyListeners();
        },
      );

  Future<void> signIn({required String email, required String password}) async {
    if (_user != null) return; // sign in only if not signed in

    // If the auth service also provides stream (like in Firebase)
    // observe the response only from the stream. Do not use the "response"
    // from the Future. Otherwise, there will duplicate results.
    // That's means, if stream is enabled, do not use "notifyListeners()".

    if (isObservingStream) {
      await _signIn(email, password);
    } else {
      await notifyListeners(onNotify: () => _signIn(email, password));
    }
  }

  Future<void> _addUser(String email, String password, String name,
          String address, String phone) =>
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
        onError: (e) async {
          _user = User();
          _error = e.toString();
          await notifyListeners();
        },
      );

  Future<void> addUser(
      {required String email,
      required String password,
      required String name,
      required String address,
      required String phone}) async {
    // sign in only if not signed in

    // If the auth service also provides stream (like in Firebase)
    // observe the response only from the stream. Do not use the "response"
    // from the Future. Otherwise, there will duplicate results.
    // That's means, if stream is enabled, do not use "notifyListeners()".

    if (isObservingStream) {
      await _addUser(email, password, name, address, phone);
    } else {
      await notifyListeners(
          onNotify: () => _addUser(email, password, name, address, phone));
    }
  }

  Future<void> signOut() async {
    if (_user == null) return;

    await notifyListeners(
        onNotify: () => _authService.signOut(
            onSuccess: () => {_user = User(), _error = ""}));
  }

  @override
  void dispose() {
    _streamObserver.cancel();
    super.dispose();
  }
}
