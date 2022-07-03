import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/services/appointment/appointment_service.dart';
import 'package:stacked/stacked.dart';

class RecycleCenterHomeViewmodel extends BaseViewModel {
  // ignore: non_constant_identifier_names
  late final _AppointmentService = locator<AppointmentService>();
  RecycleCenterHomeViewmodel();

  Future<List<int>> trackAppointmentData() {
    var appointmentData = _AppointmentService.trackAppointment();
    return appointmentData;
  }
}
