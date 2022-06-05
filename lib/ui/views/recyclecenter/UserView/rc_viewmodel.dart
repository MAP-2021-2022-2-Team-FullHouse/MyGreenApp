import 'dart:math';

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

import '../../../../services/recycleCenter/recycleCenter_service_firebase.dart';

class RCViewmodel extends BaseViewModel {
  /* StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null; */
  final _authService = locator<AuthenticationService>();
  late final _dialogService = locator<DialogService>();
  late final _recycleCenterService = locator<RecycleCenterService>();
  late List<RecycleCenter> _rc = <RecycleCenter>[];
  List<RecycleCenter> get rc => _rc;

  RCViewmodel() {
    /* _userRepository.addListener(() {
      notifyListeners();
    }); */
  }
 Future<String?> getImgUrl(String imgUrl) async {
    RecycleCenterServiceFirebase rcService=new RecycleCenterServiceFirebase();
    var result=await rcService.getImage(imgUrl);
    return result;
  }
  Stream<List<RecycleCenter>> getRCList() {
    var results = _recycleCenterService.readRC();
   
    return results;
  
  }
  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  

  
}
