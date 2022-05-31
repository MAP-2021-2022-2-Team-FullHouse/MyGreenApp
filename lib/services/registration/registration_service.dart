import 'dart:async';
import '../../model/user.dart';

abstract class RegistrationService {
  Future addUser(
      {required String email,
      required String password,
      required String name,
      required String address,
      required String phone});

  User? transformUserData(dynamic userData) => null;
}
