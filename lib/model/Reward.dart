import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Reward {
  late String title;
  late String description;
  late int quantity;
  late double point;

  Reward(
      {this.title = '',
      this.description= '',
      this.quantity= 0,
      this.point = 0,
      });

  static Future getRewardList() async {
    // Get docs from collection reference
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('RewardItem');
    List rewardList = [];
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    rewardList = querySnapshot.docs.map((doc) => doc.data()).toList();

    return rewardList;
  }

  static Reward fromJson(Map<String, dynamic> json) =>Reward(
      title: json['title'],
      description: json['description'],
      quantity: json['quantity'],
      point: json['point']);
}
