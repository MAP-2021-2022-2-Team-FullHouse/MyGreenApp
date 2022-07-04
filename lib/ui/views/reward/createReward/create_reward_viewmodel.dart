
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/app/locator.dart';
import '../../../../model/Reward.dart';
import '../../../../services/reward/reward_service.dart';
import 'create_reward_screen.dart';

// ignore: camel_case_types
class CreateReward_ViewModel extends BaseViewModel{
   final _rewardService = locator<RewardService>();
  static late File? file;
  static late String fileName;
  
  late String _errorMessage;
  String get errorMessage => _errorMessage;
  CreateReward_ViewModel(){
    _errorMessage='';
  }
 
  static Future selectFile(CreateRewardScreenState state) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    // ignore: await_only_futures
    final path = await result.files.single.path!;
    // ignore: await_only_futures
    file=await File(path);
    // ignore: await_only_futures
    fileName=await path.substring(path.lastIndexOf('/')+1); 
    // ignore: unnecessary_null_comparison
    if(fileName!=null)
    // ignore: await_only_futures
    {state.fileField.text=await fileName;}
    
  }
  Future addReward(
      { required String title,
      required String description,
      required int quantity,
      required int point,
      required String image,
      }) async {
        Reward reward=Reward(title:title, description:description,quantity:quantity,point:point,image:image);
    dynamic result = await _rewardService.addReward(
     reward:reward,
     file:file,
   
       );
       if(result=='ok') {
         return 'ok';
       } else{
        return result;
      }
    
   
  }


}
