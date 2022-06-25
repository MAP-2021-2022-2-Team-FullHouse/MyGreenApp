import 'dart:async';

import 'package:my_green_app/model/Reward.dart';

import '../../model/RewardUnit.dart';

abstract class RewardService {
  Future<String> getRewardPoint();
  Future addReward(
      {required String title,
      required String description,
      required int quantity,
      required int point});
Stream<List<Reward>> readUserRewards();
   Stream<List<Reward>>readRewards() ;
   Stream<List<RewardUnit>>readRewardUnits() ;
    Future getReward(String docID) ;
     Future getUser(String docID) ;
  Future deleteReward(String docID);
  Future editReward(
      {required String id,
        required String title,
      required String description,
      required int quantity,
      required int point});
  Future editRewardUnit( {
    required String id,
    required String trackingNo,
    
  });
Future getRewardUnit(String docID) ;
 Future redeemReward(
      {
      required String rewardId,
      required String shippingAddress,
      required String phone,
     
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