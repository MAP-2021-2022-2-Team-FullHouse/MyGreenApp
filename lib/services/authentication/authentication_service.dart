import 'dart:async';

abstract class AuthenticationService {
  Future signIn({required String email, required String password});
  Future<String> getRole(String userid);

  Future signOut();
}
