import 'dart:async';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/services/appointment/appointment_service.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:stacked_services/stacked_services.dart';

class RecycleCenterHomeViewmodel extends BaseViewModel {
  final _appointmentService = locator<AppointmentService>();
  final _authService = locator<AuthenticationService>();
  //final _pushNotificationService = locator<PushNotificationService>();
  final _navigationService = locator<NavigationService>();
  //tatic String role = '';
  //static String currUserRole = '';
  RecycleCenterHomeViewmodel();

  Future<void> signOut() async {
    dynamic result = await _authService.signOut();
    if (result == null) {
      _navigationService.navigateTo(routes.loginRoute);
    } else {
      return result;
    }
  }

  Future<List<int>> trackAppointmentData() {
    var appointmentData = _appointmentService.trackAppointment();
    return appointmentData;
  }

  /*static Future getUserRole() async {
    currUserRole = await AuthenticationServiceFirebase.getCurrentRole();
  }

  static String getCurrentRole() {
    getUserRole();
    return currUserRole;
  }*/
}
