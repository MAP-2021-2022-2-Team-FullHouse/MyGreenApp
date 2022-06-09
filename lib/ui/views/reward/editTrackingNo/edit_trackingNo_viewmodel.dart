
import 'package:my_green_app/model/RewardUnit.dart';
import 'package:my_green_app/services/reward/reward_firebaseservice.dart';
import 'package:my_green_app/services/reward/reward_service.dart';

import 'package:stacked/stacked.dart';

class EditTrackingNoViewModel extends BaseViewModel {
 
RewardService rewardService=RewardFirebaseService();
  
  late String _errorMessage;
  String get errorMessage => _errorMessage;
  EditTrackingNoViewModel() {
    _errorMessage = '';
  }

  Future<RewardUnit> readRewardUnit(String docID)async {
    var rc = await rewardService.getRewardUnit(docID);
    return rc;
  }


  Future editRewardUnit({
    required String id,
    required String trackingNo,
    
  }) async {
    dynamic result = await rewardService.editRewardUnit(
      id: id,
      trackingNo: trackingNo,
      
    );
    
     if(result=='ok') {
       return 'ok';
     } else{
        return result;
      }
  }
}
