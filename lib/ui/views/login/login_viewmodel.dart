import 'dart:async';

import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/user.dart';
import '../../../services/user/user_repository.dart';

class LoginViewmodel extends BaseViewModel {
  late final UserRepository _userRepository = locator<UserRepository>();
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthenticationService>();
  static String currRole = '';

  User get user => _userRepository.user.copyWith();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future signIn({required String email, required String password}) async {
    dynamic result =
        await _authService.signIn(email: email, password: password);
    if (result != null) {
      _errorMessage = null;

      print(result.uid);
      String role = await _authService.getRole(result.uid);
      currRole = role;
      print(role.toString());
      if (role.toString() == "user") {
        print("user page");
        _navigationService.navigateTo(routes.homeRoute);
      } else if (role.toString() == "Admin") {
        print("admin page");
        _navigationService.navigateTo(routes.adminRoute);
      } else if (role.toString() == "Recycle Center") {
        print("recycle center page");
        _navigationService.navigateTo(routes.rcHomeRoute);
      } else {
        print("error");
        throw 'error occur in reading user role';
      }

      return result;

      //_navigationService.navigateTo(routes.homeRoute);
    } else {
      return result;
    }
  }
}
