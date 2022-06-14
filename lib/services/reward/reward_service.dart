import 'dart:async';

import 'package:my_green_app/model/Reward.dart';

abstract class RewardService {
  // Future deleteReward(String docID);
  // Future getRewardList();
  // Stream<List<Reward>> readReward();
  // Future<Reward?> readRewardList(String docID);
  Future addReward(
      {required String title,
      required String description,
      required int quantity,
      required double point});
  // Future editReward(
  //     {required String title,
  //     required String description,
  //     required int quantity,
  //     required double point});
  
}
