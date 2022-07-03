
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:my_green_app/services/reward/reward_firebaseservice.dart';
import 'package:my_green_app/services/reward/reward_service.dart';

import 'package:stacked/stacked.dart';
import '../../../../model/Reward.dart';
import 'edit_reward_screen.dart';


class EditRewardViewModel extends BaseViewModel {
 
RewardService rewardService= RewardFirebaseService();
   static late File? file;
  static late String fileName;
  late String _errorMessage;
  String get errorMessage => _errorMessage;
  EditRewardViewModel() {
    _errorMessage = '';
  }

  Future<Reward> readReward(String docID)async {
    file=null;
    var rc = await rewardService.getReward(docID);
    if(rc.image.isNotEmpty){
      file= await rewardService.returnImage("reward/${rc.image}");
      if(file==null){
        rc.image="";
      }
      
    }

    return rc;
  }

  static Future selectFile(EditRewardScreenState state) async {
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


  Future editReward({
    required String id,
    required String title,
    required String description,
    required int quantity,
    required int point,
    required String image,
    
  }) async {
    Reward reward=Reward(id:id,title:title, description:description,quantity:quantity, point:point, image:image);
    dynamic result = await rewardService.editReward(
      reward:reward,
      file:file
      
    );
    
     if(result=='ok') {
       return 'ok';
     } else{
        return result;
      }
  }
}
