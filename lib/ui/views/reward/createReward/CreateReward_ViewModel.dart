
import 'package:my_green_app/services/recycleCenter/gps_service.dart';
import 'package:my_green_app/ui/views/recyclecenter/CreateRecycleCenter/create_recycle_center_screen.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/services/navigation_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';

import '../../../../services/recycleCenter/recycleCenter_service.dart';
import '../../../../services/recycleCenter/recycleCenter_service_firebase.dart';
import '../../../../services/reward/reward_service.dart';

class CreateReward_ViewModel extends BaseViewModel{
   final _rewardService = locator<RewardService>();
  
  late String _errorMessage;
  String get errorMessage => _errorMessage;
  CreateReward_ViewModel(){
    _errorMessage='';
  }
 
  
  Future addReward(
      { required String title,
      required String description,
      required int quantity,
      required double point
      }) async {

    dynamic result = await _rewardService.addReward(
      title: title,
       description: description,
        quantity: quantity,
        point:point, 
       );
      
    // if (result != null) {
    //   if (result == 'email-already-in-use') {
    //     return "Email is registered.";
    //   } else if (result == "weak-password") {
    //     return "Weak password";
    //   } else if (result == 'invalid-email') {
    //     return "Invalid email address.";
    //   }else if (result == 'name duplicated') {
    //     return "Name duplicated";
    //   }else if (result == 'image duplicated') {
    //     return "Image duplicated";
    //   }else if (result == 'phone duplicated') {
    //     return "Phone duplicated";
    //   }else {
    //     return "ok";
    //   }
      //  else {
        
      //   _navigationService.navigateTo(routes.createRecycleCenterRoute);
      // }
    if(result==null){
      return "Something went wrong.";
      
    }
  }

//   Future<bool> isRecycleCenterNameExist(String name)async{
//  return RecycleCenterServiceFirebase.isRecycleCenterNameExist(name);

//   }


 

}
