import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/services/appointment/appointment_service.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:my_green_app/services/push_notification_service.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:stacked_services/stacked_services.dart';

class RecycleCenterHomeViewmodel extends BaseViewModel {
  final _appointmentService = locator<AppointmentService>();
  final _authService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _pushNotificationService = locator<PushNotificationService>();
  final streamController = StreamController(
  );
  static RemoteMessage newMessage = const RemoteMessage();
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

  void loadFCM() {
    _pushNotificationService.loadFCM();
  }

  void listenFCM() {
    _pushNotificationService.listenFCM();
  }

  void requestPermission() {
    _pushNotificationService.requestPermission();
  }

  String? getToken() {
    _pushNotificationService.getToken();
    return null;
  }

  void listenToMessage() {
    setBusy(true);
    _pushNotificationService.listenToMessage()?.listen((message) {
      if (message != null) {
        newMessage = message;
        notifyListeners();
        NavigationService().navigateTo(routes.appointmentRoute);
      }
      setBusy(false);
    });
  }
}
