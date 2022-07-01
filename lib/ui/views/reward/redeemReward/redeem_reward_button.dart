
import 'package:flutter/material.dart';
import 'redeem_reward_screen.dart';

class RedeemRewardButton extends StatelessWidget {
  
  final RedeemRewardScreenState state;

 const RedeemRewardButton({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 2,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromRGBO(195, 196, 141, 100),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: MaterialButton(
            onPressed: () => {state.redeemReward(state.rewardId)}, child: const Text("Redeem Reward")));
  }
}
