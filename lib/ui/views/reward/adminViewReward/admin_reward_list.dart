
import 'package:flutter/material.dart';
import '../../../../model/Reward.dart';
import 'admin_view_reward.dart';


Widget buildReward(Reward rc) => ListTile(
      
      title: Text(rc.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(rc.description),
          Text('Quantity: ${rc.quantity}'),
          Text('Points to Redeem: ${rc.point}'),
          Row(),
          AdminRewardButton(
            viewmodel: AdminRewardViewmodel(),
            model: rc,
            state: AdminRewardScreenfulState(),
            docID:rc.id ,
          )
        ],
      ),
    );


