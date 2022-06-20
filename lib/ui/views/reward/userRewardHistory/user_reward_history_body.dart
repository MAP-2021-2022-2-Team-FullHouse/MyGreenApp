import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../../model/RewardUnit.dart';
import '../adminViewReward/admin_reward_viewmodel.dart';
import 'user_reward_history_list.dart';

class UserRewardHistoryBody extends StatefulWidget {
  // final AdminRewardScreenfulState state;
  
  const UserRewardHistoryBody({Key? key}) : super(key: key);

  @override
  State<UserRewardHistoryBody> createState() => _UserRewardHistoryBodyState();
}

class _UserRewardHistoryBodyState extends State<UserRewardHistoryBody> {

  AdminRewardViewmodel vm=AdminRewardViewmodel();
  @override


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
              
                  StreamBuilder<List<RewardUnit>>(
                      stream: model.getRewardUnitListPersonalized(),
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
                            children: rewards.map(buildRewardRedemption).toList(),
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
