
import 'package:flutter/material.dart';
import 'package:my_green_app/model/RewardUnit.dart';
import '../../../../model/Reward.dart';
import '../adminViewReward/admin_reward_viewmodel.dart';
import 'reward_redemption_button.dart';

AdminRewardViewmodel vm=AdminRewardViewmodel();

Widget buildRewardRedemption(RewardUnit rc) {
// User  user=vm.readUser(rc.userId);
// dynamic reward=vm.readReward(rc.rewardId);
return ExpansionTile(
  title:Text('RedemptionID: ${rc.id}',style: const TextStyle(fontWeight: FontWeight.bold),),
  subtitle: Text('Status: ${rc.status}') ,
  children:[
        ListTile(
          title:const Text("Reward:\n",style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            Text('Reward ID: ${rc.rewardId}'),
            const SizedBox(height:5),
            FutureBuilder<Reward?>(
        future: vm.readReward(rc.rewardId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text('Something went wrong'));
          }
          if (snapshot.hasData) {
            final r = snapshot.data!;
            return Wrap(
                children:<Widget>[
                  
                 
                  Text(r.title),
                  
                    Text(' (${r.description})'),
                ]);
          } else {
            return const Center(child: Text('No data found'));
          }
        }),
                    const SizedBox(height:5),
                     Text('User ID: ${rc.userId}'),
       const SizedBox(height:5),
        FutureBuilder<String>(
        future: vm.readUser(rc.userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text(snapshot.error.toString()));
          }
          if (snapshot.hasData) {
            final r = snapshot.data!;
            return Wrap(
                children:<Widget>[
                    Text('User Name: $r'),
                    const SizedBox(height:5),
                ]
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        }),
        const SizedBox(height:5),
         Text('Status: ${rc.status}'),
         const SizedBox(height:5),
          const Text('DeliveryAddress:'),
          Text(rc.shippingAddress),
          const SizedBox(height:5),
          Text('Phone No: ${rc.phone}'),
          const SizedBox(height:5),
          if(rc.trackingNo.isNotEmpty)
          Text('Tracking No: ${rc.trackingNo}'),
          const SizedBox(height:5),
        Text('Date of Redemption: ${rc.creationTime}'),
           const SizedBox(height:5,),
           RewardRedemptionButton(
            viewmodel: AdminRewardViewmodel(),
            model: rc,
            docID:rc.id ,
          )

        ]
          ),
         
        ),

          

      ]
      
         
      );
    
}


