import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/reward/adminRewardRedemption/reward_redemption_body.dart';
import '../adminViewReward/admin_reward_navbar.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;


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
     automaticallyImplyLeading: false,
     leading: IconButton(
            icon: Icon(Icons.arrow_back), 
            onPressed: () { 
              Navigator.of(context).pushNamed(routes.adminRewardRoute);
            },
          ),
      title: const Text("Manage Reward Redemption"),
      centerTitle: true,
    ),
        body: const RewardRedemptionBody(),
        //floatingActionButton: const AdminFloat(),
       
      ),
    );
  }
}
