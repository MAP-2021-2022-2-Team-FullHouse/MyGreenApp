import 'package:flutter/material.dart';
import '../adminViewReward/admin_reward_navbar.dart';
import 'user_reward_history_body.dart';


class UserRewardHistoryScreen extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const UserRewardHistoryScreen());
  const UserRewardHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
      toolbarHeight:75,
      elevation: 10,
      automaticallyImplyLeading: false, 
      title: const Text("Reward Redemption"),
      centerTitle: true,
    ),
        body: const UserRewardHistoryBody(),
        //floatingActionButton: const AdminFloat(),
        bottomNavigationBar: const AdminRewardNavigationBar(),
      ),
    );
  }
}
