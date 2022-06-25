import 'package:flutter/material.dart';
import '../userViewReward/user_reward_screen.dart';
import 'redeem_reward.dart';

class RedeemRewardScreen extends StatefulWidget {
  final String rewardId;
  const RedeemRewardScreen({Key? key, required this.rewardId})
      : super(key: key);
String get rID =>rewardId;
  @override
  RedeemRewardScreenState createState() => RedeemRewardScreenState();
}

class RedeemRewardScreenState extends State<RedeemRewardScreen> {
  late String rewardId;
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  
  RedeemRewardViewModel viewmodel = RedeemRewardViewModel();
  

   void redeemReward(String rewardId) async {
    dynamic result;
    try {
      result = await viewmodel.redeemReward(
          rewardId: rewardId,
          shippingAddress: addressController.text,
          phone:phoneController.text,
         
          
          );
      
      if (result != null) {
        if (result == 'ok') {
         
           // ignore: use_build_context_synchronously
           showConfirmDialog(context, "Reward is redeemed Successfully!");
        } else if (result != "ok") {
          // ignore: use_build_context_synchronously
          showAlertDialog(context, result);
        } 
      }else{
        // ignore: use_build_context_synchronously
        showAlertDialog(context, "Something went wrong. Please try again.");
      }
     
    } catch (e) {
      showAlertDialog(context, "Something went wrong. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    rewardId=widget.rewardId;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'Reward',
          style: TextStyle(color: Colors.black.withOpacity(1.0)),
        ),
        
      ),
      body:RedeemRewardBody(this),
    );
  }
  showConfirmDialog(BuildContext context, String text){
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        //Navigator.pushNamed(context, Routes.homeRoute);
        Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const UserRewardScreen(),
            ));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Message"),
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
