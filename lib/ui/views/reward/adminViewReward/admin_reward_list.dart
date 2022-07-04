
import 'package:flutter/material.dart';
import '../../../../model/Reward.dart';
import 'admin_view_reward.dart';

AdminRewardScreenfulState state=AdminRewardScreenfulState();
AdminRewardViewmodel vm=AdminRewardViewmodel();

 Widget buildReward(Reward rc) =>Column(
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
          AdminRewardButton(
            viewmodel: AdminRewardViewmodel(),
            model: rc,
            state: AdminRewardScreenfulState(),
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


