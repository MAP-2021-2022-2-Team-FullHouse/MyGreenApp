import 'package:flutter/material.dart';
import '../../../../model/Reward.dart';
import '../redeemReward/redeem_reward_screen.dart';
import 'user_view_reward.dart';

class UserRewardButton extends StatelessWidget {
  final UserRewardViewmodel viewmodel;
  final UserRewardScreenfulState state;
  final Reward model;
  final String docID;
  const UserRewardButton(
      {Key?key,required this.viewmodel, required this.state, required this.model, required this.docID}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
   
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 0, 229, 187),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
),
    icon: const Icon(
      Icons.redeem,
      color: Colors.white,
      size: 18.0,
    ),
    label: const Text('Redeem Reward',style:TextStyle(color:Colors.white)),
    onPressed: () async {
      String result=await viewmodel.isPointSufficient(model.id);
      if(result=="true"){
          
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
          RedeemRewardScreen(rewardId:model.id),
           
      ));
      }else if(result=="false"){
          // ignore: use_build_context_synchronously
          showAlertDialog(context, "Your Reward Point Is Not Sufficient.");
      }else{
        // ignore: use_build_context_synchronously
        showAlertDialog(context, "Something went wrong. Please try again.");
      }
      
    },
      ),
      
    ]);
  }
showAlertDialog(BuildContext context, String text) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        //Navigator.pushNamed(context, routes.createRecycleCenterRoute);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Error"),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  
}
