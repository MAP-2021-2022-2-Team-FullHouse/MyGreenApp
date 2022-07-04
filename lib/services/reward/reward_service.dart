import 'dart:async';
import 'dart:io';

import 'package:my_green_app/model/Reward.dart';

import '../../model/RewardUnit.dart';

abstract class RewardService {
  Future<String> getRewardPoint();
  Future<String> getImage(String pathname) ;
  Future addReward(
      {required Reward reward, File? file});
Stream<List<Reward>> readUserRewards();
   Stream<List<Reward>>readRewards() ;
   Stream<List<RewardUnit>>readRewardUnits() ;
    Future getReward(String docID) ;
    Future returnImage(String pathname) ;
     Future getUser(String docID) ;
  Future deleteReward(String docID);
  Future editReward(
      {required Reward reward, File?file});
  Future editRewardUnit( {
    required String id,
    required String trackingNo,
    
  });
Future getRewardUnit(String docID) ;
 Future redeemReward(
      {
      required RewardUnit rewardUnit,
     
      });
      Future isPointSufficient(String docID);
      Stream<List<RewardUnit>> readRewardUnitsPersonalized() ;
      Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String address,
   required String trackingno,
   required String phone,
    
  });

}