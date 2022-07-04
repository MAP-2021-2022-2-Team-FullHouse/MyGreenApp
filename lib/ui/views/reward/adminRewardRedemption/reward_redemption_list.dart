
import 'package:flutter/material.dart';
import 'package:my_green_app/model/RewardUnit.dart';
import '../../../../model/Reward.dart';
import '../adminViewReward/admin_reward_viewmodel.dart';
import 'reward_redemption_button.dart';

AdminRewardViewmodel vm=AdminRewardViewmodel();

Widget buildRewardRedemption(RewardUnit rc) {
// User  user=vm.readUser(rc.userId);
// dynamic reward=vm.readReward(rc.rewardId);
return Card(
 margin:EdgeInsets.all(8),
color: (rc.status.compareTo("Pending")==0)? Color.fromARGB(255, 227, 0, 72):Color.fromARGB(255, 2, 174, 7),
  child:   ExpansionTile(
    title:Text('RedemptionID: ${rc.id}',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),),
    subtitle: Text('Status: ${rc.status} ',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),) ,
    children:[
          ListTile(
            title:const Text("Reward:\n",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white, fontSize: 16)),
            subtitle:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              Text('Reward ID: ${rc.rewardId}',style:TextStyle(color:Colors.white, fontSize: 15)),
              const SizedBox(height:5),
              FutureBuilder<Reward?>(
          future: vm.readReward(rc.rewardId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                  child: Text('Something went wrong',style:TextStyle(color:Colors.white, fontSize: 15)));
            }
            if (snapshot.hasData) {
              final r = snapshot.data!;
              return Wrap(
                  children:<Widget>[
                    
                   
                    Text(r.title,style:TextStyle(color:Colors.white, fontSize: 15)),
                    
                      Text(' (${r.description})',style:TextStyle(color:Colors.white, fontSize: 15)),
                  ]);
            } else {
              return const Center(child: Text('No data found',style:TextStyle(color:Colors.white, fontSize: 15)));
            }
          }),
                      const SizedBox(height:5),
                       Text('User ID: ${rc.userId}',style:TextStyle(color:Colors.white, fontSize: 15)),
         const SizedBox(height:5),
          FutureBuilder<String>(
          future: vm.readUser(rc.userId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Text(snapshot.error.toString(),style:TextStyle(color:Colors.white, fontSize: 15)));
            }
            if (snapshot.hasData) {
              final r = snapshot.data!;
              return Wrap(
                  children:<Widget>[
                      Text('User Name: $r',style:TextStyle(color:Colors.white, fontSize: 15)),
                      const SizedBox(height:5),
                  ]
              );
            } else {
              return const Center(child: Text('No data found',style:TextStyle(color:Colors.white, fontSize: 15)));
            }
          }),
          const SizedBox(height:5),
           Text('Status: ${rc.status}',style:TextStyle(color:Colors.white, fontSize: 15)),
           const SizedBox(height:5),
            const Text('DeliveryAddress:',style:TextStyle(color:Colors.white, fontSize: 15)),
            Text(rc.shippingAddress,style:TextStyle(color:Colors.white, fontSize: 15)),
            const SizedBox(height:5),
            Text('Phone No: ${rc.phone}',style:TextStyle(color:Colors.white, fontSize: 15)),
            const SizedBox(height:5),
            if(rc.trackingNo.isNotEmpty)
            Text('Tracking No: ${rc.trackingNo}',style:TextStyle(color:Colors.white, fontSize: 15)),
            const SizedBox(height:5),
          Text('Date of Redemption: ${rc.creationTime}',style:TextStyle(color:Colors.white, fontSize: 15)),
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
        
           
        ),
);
    
}



