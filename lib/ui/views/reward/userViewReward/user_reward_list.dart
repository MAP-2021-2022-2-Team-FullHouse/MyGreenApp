
import 'package:flutter/material.dart';
import '../../../../model/Reward.dart';
import 'user_view_reward.dart';



Widget buildReward(Reward rc) => ListTile(
      
      title: Text(rc.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(rc.description),
          Text('Quantity: ${rc.quantity}'),
          Text('Points to Redeem: ${rc.point}'),
          Row(),
          UserRewardButton(
            viewmodel: UserRewardViewmodel(),
            model: rc,
            state: UserRewardScreenfulState(),
            docID:rc.id ,
          )
        ],
      ),
    );

