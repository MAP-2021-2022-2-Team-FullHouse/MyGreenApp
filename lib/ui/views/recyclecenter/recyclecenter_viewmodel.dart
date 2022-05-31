import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/constants/routes_path.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'package:my_green_app/services/recycleCenter/recycleCenter_service.dart';
import 'package:my_green_app/services/user/user_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';

class RecycleCenterViewmodel extends BaseViewModel {
  /* StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null; */
  final _authService = locator<AuthenticationService>();
  late final _dialogService = locator<DialogService>();
  late final _recycleCenterService = locator<RecycleCenterService>();
  late List<RecycleCenter> _rc = <RecycleCenter>[];
  List<RecycleCenter> get rc => _rc;

  RecycleCenterViewmodel() {
    /* _userRepository.addListener(() {
      notifyListeners();
    }); */
  }

  Stream<List<RecycleCenter>> getRCList() {
    var results =  _recycleCenterService.readRC();
    return results;
    // if (results != null) {
    //   return results;
    // } else {
    //     _dialogService.showDialog(
    //     title: 'Posts Update Failed',
    //   );
    //   return results;
    // }
  }

/* 
  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;
  } */

  

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
