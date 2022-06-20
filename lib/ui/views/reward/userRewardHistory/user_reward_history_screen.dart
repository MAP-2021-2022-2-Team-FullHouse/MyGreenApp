import 'package:flutter/material.dart';
import '../userViewReward/user_view_reward.dart';
import 'user_reward_history_body.dart';


class UserRewardHistoryScreen extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const UserRewardHistoryScreen());
  const UserRewardHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
        elevation: 10,
        toolbarHeight: 70,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'Reward Redemption',
          style: TextStyle(color: Colors.black.withOpacity(1.0)),
        ),
        // backgroundColor: Colors.green,
      ),
   
        body: const UserRewardHistoryBody(),
        //floatingActionButton: const AdminFloat(),
        bottomNavigationBar: const UserRewardNavigationBar(),
      ),
    );
  }
}
