import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/model/recycling_info.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'package:my_green_app/services/recycling_info/recycling_info_service.dart';
import 'package:my_green_app/services/reward/reward_firebaseservice.dart';
import 'package:my_green_app/services/reward/reward_service.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:stacked_services/stacked_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../services/authentication/authentication_service_firebase.dart';
import '../login/login_viewmodel.dart';
import 'package:my_green_app/services/push_notification_service.dart';

class HomeViewmodel extends BaseViewModel {
  final _authService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _pushNotificationService = locator<PushNotificationService>();
  final _recyclingInfoService = locator<RecyclingInfoService>();
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

  Future<String> myRole() async {
    String role = await _authService.getUserRole();
    print("lalalalala" + role);
    return role;
  }

  Future<String> myName() async {
    String name = await _authService.getUserName();

    return name;
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
        if (_authService.getCurrentID() != null) {
          NavigationService().navigateTo(routes.appointmentRoute);
        } else {
          NavigationService().navigateTo(routes.loginRoute);
        }
      }
      setBusy(false);
    });
  }

  Stream<List<RecyclingInfo>> getRecyclingInfoList() {
    var results = _recyclingInfoService.readRecyclingInfoList();
    return results;
  }

  Future<String?> getImgUrl(String imgUrl) async {
    var result = await _recyclingInfoService.getRecyclingInfoImage(imgUrl);
    return result;
  }
}
