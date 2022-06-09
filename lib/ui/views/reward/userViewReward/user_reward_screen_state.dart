
import 'package:flutter/material.dart';
import 'user_reward_body.dart';
import 'user_reward_viewmodel.dart';

class UserRewardScreenful extends StatefulWidget {
  const UserRewardScreenful({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) =>const UserRewardScreenful());

  @override
  State<UserRewardScreenful> createState() => UserRewardScreenfulState();
}

class UserRewardScreenfulState extends State<UserRewardScreenful> {
  void onDelete(UserRewardViewmodel viewmodel, String docID) async {
    //dynamic result;
    await viewmodel.deleteReward(docID);
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: UserRewardBody());
  }
}

