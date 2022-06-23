import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/reward/adminRewardRedemption/reward_redemption_body.dart';
import '../adminViewReward/admin_reward_navbar.dart';


class RewardRedemptionScreen extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const RewardRedemptionScreen());
  const RewardRedemptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
      toolbarHeight:75,
      elevation: 10,
     
      title: const Text("Manage Reward Redemption"),
      centerTitle: true,
    ),
        body: const RewardRedemptionBody(),
        //floatingActionButton: const AdminFloat(),
       
      ),
    );
  }
}
