import 'dart:async';

import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:stacked/stacked.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';

class AdminViewmodel extends BaseViewModel {
  /* StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null; */
  final _authService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  AdminViewmodel() {
    /* _userRepository.addListener(() {
      notifyListeners();
    }); */
  }
/* 
  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;
  } */

  Future signOut() async {
    dynamic result = await _authService.signOut();
    if (result == null) {
      _navigationService.navigateTo(routes.loginRoute);
    } else {
      return result;
    }
  }

  /* @override
  void dispose() {
    _streamListener?.cancel();
    _streamListener = null;
    super.dispose();
  } */

  // Future<User?> readUser() async {
  //   final docUser=FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser.uid);
  // }
}
