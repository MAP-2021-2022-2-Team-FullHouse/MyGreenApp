import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:my_green_app/services/authentication/authentication_service_firebase.dart';
import 'package:my_green_app/services/push_notification_service.dart';
import 'package:my_green_app/services/reward/reward_firebaseservice.dart';
import 'package:my_green_app/services/reward/reward_service.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:stacked_services/stacked_services.dart';
import '../login/login_viewmodel.dart';

class HomeViewmodel extends BaseViewModel {
  final _authService = locator<AuthenticationService>();
  final _pushNotificationService = locator<PushNotificationService>();
  final _navigationService = locator<NavigationService>();
  final streamController = StreamController(
    onPause: () => print('Paused'),
    onResume: () => print('Resumed'),
    onCancel: () => print('Cancelled'),
    onListen: () => print('Listens'),
  );
  static String role = '';
  static String currUserRole = '';
  static RemoteMessage newMessage = RemoteMessage();

  HomeViewmodel() {}

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

  Future<void> signOut() async {
    dynamic result = await _authService.signOut();
    if (result == null) {
      _navigationService.navigateTo(routes.loginRoute);
    } else {
      return result;
    }
  }

  Future<String> getRewardPoint() async {
    RewardService service = RewardFirebaseService();
    var result = service.getRewardPoint();
    return result;
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
