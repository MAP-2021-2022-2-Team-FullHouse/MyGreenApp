
import 'package:stacked/stacked.dart';
import 'package:my_green_app/app/locator.dart';
import '../../../../services/reward/reward_service.dart';

// ignore: camel_case_types
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
      required int point
      }) async {

    dynamic result = await _rewardService.addReward(
      title: title,
       description: description,
        quantity: quantity,
        point:point, 
       );
       if(result=='ok') {
         return 'ok';
       } else{
        return result;
      }
    
   
  }


}
