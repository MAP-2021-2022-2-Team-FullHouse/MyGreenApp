import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/services/appointment/appointment_service.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;

class RecycleCenterHomeViewmodel extends BaseViewModel {
  // ignore: non_constant_identifier_names
  late final _AppointmentService = locator<AppointmentService>();
  final _authService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  RecycleCenterHomeViewmodel();

  Future signOut() async {
    dynamic result = await _authService.signOut();
    if (result == null) {
      _navigationService.navigateTo(routes.loginRoute);
    } else {
      return result;
    }
  }

  Future<List<int>> trackAppointmentData() {
    var appointmentData = _AppointmentService.trackAppointment();
    return appointmentData;
  }
}
