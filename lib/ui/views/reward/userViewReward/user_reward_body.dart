import 'package:flutter/material.dart';
import 'package:my_green_app/model/Reward.dart';
import 'package:stacked/stacked.dart';
import '../userRewardHistory/user_reward_history_screen.dart';
import 'user_reward_list.dart';
import 'user_reward_viewmodel.dart';



class UserRewardBody extends StatefulWidget {
  // final AdminRewardScreenfulState state;
  
  const UserRewardBody({Key? key}) : super(key: key);

  @override
  State<UserRewardBody> createState() => _UserRewardBodyState();
}

class _UserRewardBodyState extends State<UserRewardBody> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserRewardViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children:  [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height:10),
                  Align(
                    alignment: Alignment.center,
                    child: 
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.redeem,
                        size: 18.0,
                      ),
                      label: const Text('Reward Redemption Record'),
                      onPressed: () async {
                        
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                            const UserRewardHistoryScreen(),
                            
                        ));
                      
                        
                      },
                    ),),
                    
                
                  StreamBuilder<List<Reward>>(
                      stream: model.getUserRewardList(),
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
      viewModelBuilder: () => UserRewardViewmodel(),
    );
  }
}
