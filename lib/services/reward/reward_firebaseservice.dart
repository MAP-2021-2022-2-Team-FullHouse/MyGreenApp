import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_green_app/model/RewardUnit.dart';
import 'package:my_green_app/services/reward/reward_service.dart';
import 'package:http/http.dart' as http;

import '../../model/Reward.dart';

class RewardFirebaseService extends RewardService{
 
 @override
  Future<String> getRewardPoint()async{
  final String uid=FirebaseAuth.instance.currentUser!.uid;
  int point=0;
   String result='';
      await FirebaseFirestore.instance
                  .collection('User')
                  .doc(uid)
                  .get()
                  .then((value) {
                  point= value.data()?['point'];    
              }); 
     result="$point";        
    return result;
 }
  @override
  Future isPointSufficient(String docID) async{
    try{
      final String uid=FirebaseAuth.instance.currentUser!.uid;
       final docUser = await FirebaseFirestore.instance.collection('User').doc(uid).get();
      int rewardPoint=docUser['point'];
      Reward reward=await getReward(docID);
      int redeemPoint=reward.point;
    
    if(redeemPoint>rewardPoint){
      return 'false';
    }else{
      return 'true';
    }

    }on FirebaseAuthException catch (e) {
      return e.code;
    } 
  }
  @override
  Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String address,
   required String trackingno,
   required String phone,
  })async{
    const serviceId='service_lg841rr';
    const templateId='template_0e92ygc';
    const userId='2jehMZ2xzgISfLOjI';
    final url=Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    await http.post(
      headers:{
        'origin':'http://localhost',
        'Content-Type':'application/json',
      },
      url,
      body: json.encode({
        'service_id':serviceId,
        'template_id':templateId,
        'user_id':userId,
        'template_params':{
          'user_subject':subject,
          'user_name':name,
          'user_email':email,
          'user_address':address,
          'user_trackingno':trackingno,
          'user_phone':phone


        },

      }),
      );
  }

  @override
  Future redeemReward(
      {
      required String rewardId,
      required String shippingAddress,
      required String phone,
     
      }) async {
        try{
          if(phone.isEmpty||shippingAddress.isEmpty){
            return "Form is not completely filled";
          }
         
      String pattern =
          r'^(\+?6?01)[02-46-9]-*[0-9]{7}|^(\+?6?01)[1]-*[0-9]{8}$';
      RegExp regex = RegExp(pattern);
      // String match = text!;
      if (!regex.hasMatch(phone)) {
        return 'Invalid phone number format';
      }
    
          final String uid=FirebaseAuth.instance.currentUser!.uid;
          await FirebaseFirestore.instance
          .collection("RewardUnit")
          .doc()
          .set({
        "userId": uid,
        "rewardId": rewardId,
        "shippingAddress": shippingAddress,
        "phone": phone,
        "trackingNo":"",
        "status":"Pending",
        "creationTime":Timestamp.now()
      });

          int qty=0;
          await FirebaseFirestore.instance
                  .collection('RewardItem')
                  .doc(rewardId)
                  .get()
                  .then((value) {
                
                  qty= value.data()?['quantity'];
          
              }); 
        if(qty!=0)
        {qty-=1;}
        else
        {return 'Stock Out';}

        await  FirebaseFirestore.instance.collection("RewardItem").doc(rewardId).update({
        "quantity": qty,
      });
      int point=0;
      await FirebaseFirestore.instance
                  .collection('User')
                  .doc(uid)
                  .get()
                  .then((value) {
                  point= value.data()?['point'];    
              }); 
      int rewardPoint=0;
      await FirebaseFirestore.instance
                  .collection('RewardItem')
                  .doc(rewardId)
                  .get()
                  .then((value) {
                  rewardPoint= value.data()?['redeemPoint'];    
              }); 
              point=point-rewardPoint;
          await  FirebaseFirestore.instance.collection("User").doc(uid).update({
        "point": point,
      });     
     

      return 'ok';
        }on FirebaseAuthException catch (e) {
      String error;

        error = e.toString();
      
      return error;
    }
  }

  @override
  Future addReward(
      {required String title,
      required String description,
      required int quantity,
      required int point,
      }) async {
        try{
          await FirebaseFirestore.instance
          .collection("RewardItem")
          .doc()
          .set({
        "title": title,
        "description": description,
        "quantity": quantity,
        "redeemPoint": point
      });
      return 'ok';
        }on FirebaseAuthException catch (e) {
      String error;
      
        error = e.toString();
      
      return error;
    }
  }

@override
  Future editReward(
  {
    required String id,
    required String title,
    required String description,
    required int quantity,
    required int point,
  }
)async{
  try{
    FirebaseFirestore.instance.collection("RewardItem").doc(id).update({
        "title": title,
        "description": description,
        "quantity": quantity,
        "redeemPoint": point,
       
      });
      return 'ok';
  }on FirebaseAuthException catch (e) {
      String error;
      
        error = e.toString();
      
      return error;
    }

}

@override
  Future editRewardUnit(
  {
    required String id,
    required String trackingNo,
    
  }
)async{
  try{
    if(trackingNo.isEmpty){
      return "Form Is Not Completely Filled.";
    }
    FirebaseFirestore.instance.collection("RewardUnit").doc(id).update({
        "trackingNo": trackingNo, 
        "status":"Processed"
      });
     String phone="";
     String shippingAddress="";
     String userId="";
     String username="";
     String email="";
      await FirebaseFirestore.instance
                  .collection('RewardUnit')
                  .doc(id)
                  .get()
                  .then((value) {
                  phone= value.data()?['phone'];   
                  shippingAddress = value.data()?['shippingAddress'];   
                  userId= value.data()?['userId'];   
              }); 
      await FirebaseFirestore.instance
                  .collection('User')
                  .doc(userId)
                  .get()
                  .then((value) {
                  email= value.data()?['email'];   
                  username = value.data()?['name'];   
                   
              });
    
    String subject="Your Reward Is On The Way!";
    sendEmail(name:username,email:email,subject:subject, address:shippingAddress,trackingno: trackingNo,phone:phone);

      return 'ok';
  }on FirebaseAuthException catch (e) {
      String error;
      
        error = e.toString();
      
      return error;
    }
}

 @override
  Stream<List<Reward>> readRewards() {
  
  Stream<List<Reward>>rewardList= FirebaseFirestore.instance
      .collection('RewardItem')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Reward.fromJson(doc.id,doc.data()))
          .toList());
          return rewardList;
}
@override
  Stream<List<RewardUnit>> readRewardUnits() {
 dynamic rewardList=  FirebaseFirestore.instance
      .collection('RewardUnit')
      .orderBy("creationTime",descending:true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((rewardunit){ 
            return RewardUnit.fromJson(rewardunit.id,rewardunit.data());           
            })
          .toList());
          
          return rewardList;
}

@override
  Stream<List<RewardUnit>> readRewardUnitsPersonalized() {
  
   final String uid=FirebaseAuth.instance.currentUser!.uid;
 dynamic rewardList=  FirebaseFirestore.instance
      .collection('RewardUnit')
      
      .where('userId', isEqualTo:uid)
      .orderBy("creationTime",descending:true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((rewardunit){ 
            return RewardUnit.fromJson(rewardunit.id,rewardunit.data());           
            })
          .toList());
 
          return rewardList;
}


@override
  Stream<List<Reward>> readUserRewards() {
Stream<List<Reward>>rewardList= FirebaseFirestore.instance
      .collection('RewardItem')
      .where('quantity', isGreaterThan: 0)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Reward.fromJson(doc.id,doc.data()))
          .toList());
          return rewardList;
}
@override
  Future getUser(String docID) async {

Map<String, dynamic>? userData;
    await FirebaseFirestore.instance
        .collection('User')
        .doc(docID)
        .get()
        .then((value) {
      
        userData= value.data();
       
    });
    return userData;
  }
  
  @override
  Future getReward(String docID) async {
// ignore: prefer_typing_uninitialized_variables
var rewardData;
    await FirebaseFirestore.instance
        .collection('RewardItem')
        .doc(docID)
        .get()
        .then((value) {
      
        rewardData= value.data();
 
    });
    return Reward.fromJson(docID,rewardData);
  }

  @override
  Future getRewardUnit(String docID) async {
// ignore: prefer_typing_uninitialized_variables
var rewardData;
    await FirebaseFirestore.instance
        .collection('RewardUnit')
        .doc(docID)
        .get()
        .then((value) {
      
        rewardData= value.data();
 
    });
    return RewardUnit.fromJson(docID,rewardData);
  } 

  @override
  Future deleteReward(String docID) async {
    try {
      await FirebaseFirestore.instance.collection("RewardItem").doc(docID).delete();

      return true;
    } on FirebaseException catch (e) {
  
      return "${e.code}. Something went wrong. Please try again.";
    }
  }
}