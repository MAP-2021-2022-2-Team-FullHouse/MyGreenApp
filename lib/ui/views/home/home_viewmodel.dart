import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:my_green_app/services/authentication/authentication_service_firebase.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'package:my_green_app/ui/views/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:stacked_services/stacked_services.dart';

class HomeViewmodel extends BaseViewModel {
  final _authService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final streamController = StreamController(
    onPause: () => print('Paused'),
    onResume: () => print('Resumed'),
    onCancel: () => print('Cancelled'),
    onListen: () => print('Listens'),
  );
  static String role = '';
  static String currUserRole = '';

  HomeViewmodel() {}

  Future<void> signOut() async {
    dynamic result = await _authService.signOut();
    if (result == null) {
      _navigationService.navigateTo(routes.loginRoute);
    } else {
      return result;
    }
  }

  String getRole() {
    return LoginViewmodel.currRole;
  }

  static Future getUserRole() async {
    currUserRole = await AuthenticationServiceFirebase.getCurrentRole();
  }

  static String getCurrentRole() {
    getUserRole();
    return currUserRole;
  }
}
