
import 'package:stacked/stacked.dart';
import 'package:my_green_app/app/locator.dart';
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

    dynamic result = await _rewardService.redeemReward(
    
      rewardId:rewardId,
      shippingAddress:shippingAddress,
      phone:phone,
    
       );
       if(result=='ok') {
         return 'ok';
       } else{
        return result;
      }
   
  }




 

}
