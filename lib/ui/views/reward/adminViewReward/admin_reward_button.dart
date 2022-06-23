import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/reward/editReward/edit_reward_screen.dart';
import '../../../../model/Reward.dart';
import 'admin_view_reward.dart';

class AdminRewardButton extends StatelessWidget {
  final AdminRewardViewmodel viewmodel;
  final AdminRewardScreenfulState state;
  final Reward model;
  final String docID;
  const AdminRewardButton(
      {Key?key, required this.viewmodel, required this.state, required this.model, required this.docID}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      
      ElevatedButton.icon(
    icon: const Icon(
      Icons.edit,
      size: 18.0,
    ),
    label: const Text('Edit'),
    onPressed: () async {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
          EditRewardScreen(docID:model.id),
            // EditRecycleCenterScreen(docEmail: model.email),
      ));
    },
      ),
      const SizedBox(
    width: 8,
      ),
      ElevatedButton.icon(
    icon: const Icon(
      Icons.delete,
      size: 18.0,
    ),
    label: const Text('Delete'),
    onPressed: () async {
     
      state.onDelete(viewmodel, docID);
    },
      ),
    ]);
  }
}
