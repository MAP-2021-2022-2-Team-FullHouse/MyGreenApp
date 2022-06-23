import 'package:flutter/material.dart';
import 'package:my_green_app/model/Reward.dart';
import 'package:stacked/stacked.dart';
import '../adminRewardRedemption/reward_redemption_screen.dart';
import '../createReward/create_reward_screen.dart';
import 'admin_view_reward.dart';



class AdminRewardBody extends StatefulWidget {
  // final AdminRewardScreenfulState state;
  
  const AdminRewardBody({Key? key}) : super(key: key);

  @override
  State<AdminRewardBody> createState() => _AdminRewardBodyState();
}

class _AdminRewardBodyState extends State<AdminRewardBody> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminRewardViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children:  [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height:10),
              SizedBox(
          width: 350,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
               ElevatedButton(
              style:ElevatedButton.styleFrom(
                primary: Colors.greenAccent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold)),
              child: const Text("Create"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreateRewardScreen(),
            ));

              },
            ),
            const SizedBox(width: 20,),
            ElevatedButton(
              style:ElevatedButton.styleFrom(
                primary: Colors.cyanAccent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold)),
              child: const Text("Reward Redemption"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const RewardRedemptionScreen(),
            ));

              },
            ),
            ]
          ),
        ),
              const SizedBox(height:10),
                  StreamBuilder<List<Reward>>(
                      stream: model.getRewardList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Something went wrong ${snapshot.error}'));
                        }
                        if (snapshot.hasData) {
                          final rewards = snapshot.data!;
                          return ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: rewards.map(buildReward).toList(),
                          );
                        } else {
                          return const Center(child: Text('No data found'));
                        }
                  }),
            ],
          ),
        ),
      
        ],
        ),
      ),
      viewModelBuilder: () => AdminRewardViewmodel(),
    );
  }
}
