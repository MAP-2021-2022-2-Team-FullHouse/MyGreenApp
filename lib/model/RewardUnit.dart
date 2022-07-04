import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class RewardUnit {
  late String id;
  late String userId;
  late String rewardId;
  late String shippingAddress;
  late String phone;
  late String trackingNo;
  late String status;
  late DateTime creationTime;


   RewardUnit
     ( {
        this.id='',
        this.userId='',
        this.rewardId='',
        this.shippingAddress='',
        this.phone='',
        this.trackingNo='',
        this.status='',
        DateTime? creationDateTime,
      }):creationTime = creationDateTime ?? DateTime.now();

  static RewardUnit fromJson(String docId, Map<String, dynamic> json) {
 
    RewardUnit reward=RewardUnit(
    id:docId,
    userId: json['userId'],
     rewardId:json['rewardId'],
      shippingAddress: json['shippingAddress'],
      phone: json['phone'],
      trackingNo: json['trackingNo'],
      status: json['status'],
      creationDateTime:json['creationTime'].toDate()
      );
     
      return reward;
}

  Map<String, dynamic> toJson() => {
        
        'userId':userId,
        'rewardId': rewardId,
        'shippingAddress': shippingAddress,
        'phone': phone,
        'trackingNo':trackingNo,
        'status':status,
       'creationTime':Timestamp.now(),
     
        
      };

}
