
import 'package:flutter/material.dart';
import '../../../../model/Reward.dart';
import '../adminViewReward/admin_reward_screen_state.dart';
import '../adminViewReward/admin_reward_viewmodel.dart';
import 'user_view_reward.dart';

AdminRewardScreenfulState state=AdminRewardScreenfulState();
AdminRewardViewmodel vm=AdminRewardViewmodel();

Widget buildReward(Reward rc) => Column(
  children:[ 
    Row(
    children: [
      const SizedBox(width: 10,height: 10,),
      Expanded(
        // height: 150.00,
        // width: 125.00,
        flex: 2,
        child: FutureBuilder(
          future: state.getImgUrl("reward/${rc.image}",vm),
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
              return Container(
              child: buildImage(snapshot.data),
              );
          },
        ),
      ),
      const SizedBox(width: 10,height: 10,),

      Expanded(
        flex: 3,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          Text(rc.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
           Text(rc.description),
           
           Text('Quantity: ${rc.quantity}'),
           Text('Points to Redeem: ${rc.point}'),
          UserRewardButton(
              viewmodel: UserRewardViewmodel(),
              model: rc,
              state: UserRewardScreenfulState(),
              docID:rc.id ,
            )
        ],
      ),
      ),
      const SizedBox(width: 10,height: 10,),

      
      
    ],
  ),
  const SizedBox(width: 10,height: 25,),
  ],
    );
 
 // ListTile(
      
//       title: Text(rc.title),
//       subtitle: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(rc.description),
//           Text('Quantity: ${rc.quantity}'),
//           Text('Points to Redeem: ${rc.point}'),
//           Row(),
//           AdminRewardButton(
//             viewmodel: AdminRewardViewmodel(),
//             model: rc,
//             state: AdminRewardScreenfulState(),
//             docID:rc.id ,
//           )
//         ],
//       ),
//     );

    Widget buildImage(String? data) {
  return ClipRect(
    child: Material(
      color: Colors.transparent,
      child: Ink.image(
        image: NetworkImage(data.toString()),
        fit: BoxFit.cover,
        width: 128,
        height: 128,
        child: const InkWell(/* onTap: onClicked */),
      ),
    ),
  );
}
//Card(
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(20), // if you need this
//     side: BorderSide(
//       color: Colors.grey.withOpacity(0.2),
//       width: 1,
//     ),
//   ),

  
//   child:   ListTile(
//         minVerticalPadding: 10,
//         title: Text(rc.title,style:TextStyle(color:Colors.black)),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(rc.description,style:TextStyle(color:Colors.black)),
//             Text('Quantity: ${rc.quantity}',style:TextStyle(color:Colors.black)),
//             Text('Points to Redeem: ${rc.point}',style:TextStyle(color:Colors.black)),
//             Row(),
//             UserRewardButton(
//               viewmodel: UserRewardViewmodel(),
//               model: rc,
//               state: UserRewardScreenfulState(),
//               docID:rc.id ,
//             )
//           ],
//         ),
//       ),
// );

