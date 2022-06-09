import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/reward/adminViewReward/admin_reward_viewmodel.dart';
import '../../../../model/RewardUnit.dart';
import '../editTrackingNo/edit_trackingNo_screen.dart';


class RewardRedemptionButton extends StatelessWidget {
  final AdminRewardViewmodel viewmodel;
  // final AdminRewardScreenfulState state;
  final RewardUnit model;
  final String docID;
  const RewardRedemptionButton(
      {Key?key, required this.viewmodel,  required this.model, required this.docID}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      
      ElevatedButton.icon(
    icon: const Icon(
      Icons.edit,
      size: 18.0,
    ),
    label: const Text('Edit Tracking Number'),
    onPressed: () async {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
          EditTrackingNoScreen(docID:model.id),
           
      ));
    },
      ),
      
    ]);
  }
}
