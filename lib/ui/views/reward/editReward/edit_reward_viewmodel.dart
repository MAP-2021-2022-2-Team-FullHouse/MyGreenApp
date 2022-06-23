
import 'package:my_green_app/services/reward/reward_firebaseservice.dart';
import 'package:my_green_app/services/reward/reward_service.dart';

import 'package:stacked/stacked.dart';
import '../../../../model/Reward.dart';


class EditRewardViewModel extends BaseViewModel {
 
RewardService rewardService= RewardFirebaseService();
  
  late String _errorMessage;
  String get errorMessage => _errorMessage;
  EditRewardViewModel() {
    _errorMessage = '';
  }

  Future<Reward> readReward(String docID)async {
    var rc = await rewardService.getReward(docID);
    return rc;
  }


  Future editReward({
    required String id,
    required String title,
    required String description,
    required int quantity,
    required int point,
    
  }) async {
    dynamic result = await rewardService.editReward(
      id: id,
      title: title,
      description: description,
      quantity: quantity,
      point: point,
      
    );
    
     if(result=='ok') {
       return 'ok';
     } else{
        return result;
      }
  }
}
