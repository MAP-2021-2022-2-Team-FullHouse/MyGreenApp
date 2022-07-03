import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/services/appointment/appointment_service.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:my_green_app/services/push_notification_service.dart';
import 'package:my_green_app/services/recycling_info/recycling_info_service.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:stacked_services/stacked_services.dart';

class RecycleCenterHomeViewmodel extends BaseViewModel {
  final _appointmentService = locator<AppointmentService>();
  final _authService = locator<AuthenticationService>();
  //final _pushNotificationService = locator<PushNotificationService>();
  final _navigationService = locator<NavigationService>();
  final _pushNotificationService = locator<PushNotificationService>();
  final _recyclingInfoService = locator<RecyclingInfoService>();
  final streamController = StreamController(
    onPause: () => print('Paused'),
    onResume: () => print('Resumed'),
    onCancel: () => print('Cancelled'),
    onListen: () => print('Listens'),
  );
  static RemoteMessage newMessage = RemoteMessage();
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

  /*static Future getUserRole() async {
    currUserRole = await AuthenticationServiceFirebase.getCurrentRole();
  }

  static String getCurrentRole() {
    getUserRole();
    return currUserRole;
  }*/
}
