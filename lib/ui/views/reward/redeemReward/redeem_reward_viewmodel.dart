
import 'package:stacked/stacked.dart';
import 'package:my_green_app/app/locator.dart';
import '../../../../model/RewardUnit.dart';
import '../../../../services/reward/reward_service.dart';

class RedeemRewardViewModel extends BaseViewModel{
   final _rewardService = locator<RewardService>();
  
  late String _errorMessage;
  String get errorMessage => _errorMessage;
  RedeemRewardViewModel(){
    _errorMessage='';
  }
 
  
  Future redeemReward(
      { 
      
      required String rewardId,
      required String shippingAddress,
      required String phone,
    
     
      }) async {
    RewardUnit rewardUnit=RewardUnit(rewardId:rewardId,shippingAddress:shippingAddress,phone:phone);
    dynamic result = await _rewardService.redeemReward(
    
      rewardUnit: rewardUnit,
    
       );
       if(result=='ok') {
         return 'ok';
       } else{
        return result;
      }
   
  }




 

}
