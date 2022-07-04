import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  Future<String> getImage(String pathname) async {
    try {
       print("ahhhhhhhhhhhhhhhhhhhhhhhhhh");
       print(pathname);
      final ref = FirebaseStorage.instance.ref().child(pathname);
      String imageUrl = await ref.getDownloadURL();
   
         print("hahahah"+imageUrl);
      return imageUrl;
    } catch (e) {
      return e.toString();
    }
  }

  Future returnImage(String pathname)async{
    try{
      final ref = FirebaseStorage.instance.ref().child(pathname);
      File file=File(ref.fullPath);
      return file;
    }catch(e){
      print( "fail to retrieve image");
    }
  }



  @override
  Future redeemReward(
      {
      required RewardUnit rewardUnit,
     
      }) async {
        try{
          if(rewardUnit.phone.isEmpty||rewardUnit.shippingAddress.isEmpty){
            return "Form is not completely filled";
          }
         
      String pattern =
          r'^(\+?6?01)[02-46-9]-*[0-9]{7}|^(\+?6?01)[1]-*[0-9]{8}$';
      RegExp regex = RegExp(pattern);
      // String match = text!;
      if (!regex.hasMatch(rewardUnit.phone)) {
        return 'Invalid phone number format';
      }
    
          final String uid=FirebaseAuth.instance.currentUser!.uid;
          rewardUnit.userId=uid;
          rewardUnit.trackingNo="";
          rewardUnit.status="Pending";
          rewardUnit.creationTime=DateTime.now();
          await FirebaseFirestore.instance
          .collection("RewardUnit")
          .doc()
          .set(rewardUnit.toJson());

          int qty=0;
          await FirebaseFirestore.instance
                  .collection('RewardItem')
                  .doc(rewardUnit.rewardId)
                  .get()
                  .then((value) {
                
                  qty= value.data()?['quantity'];
          
              }); 
        if(qty!=0)
        {qty-=1;}
        else
        {return 'Stock Out';}

        await  FirebaseFirestore.instance.collection("RewardItem").doc(rewardUnit.rewardId).update({
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
                  .doc(rewardUnit.rewardId)
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
      {required Reward reward,
       File? file,
      }) async {
        try{
          String? img = '';
          int pos = reward.image.indexOf('.');
          final rewardFirebase=await FirebaseFirestore.instance
          .collection("RewardItem")
          .add(reward.toJson());
          img = "${rewardFirebase.id}${reward.image.substring(pos)}";
          await FirebaseFirestore.instance.collection("RewardItem").doc(rewardFirebase.id).update(
            {'image':img}
          );
           if (file != null) {
                uploadFile(img, file);
              }


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
    required Reward reward,
    File?file
  }
)async{
  try{
    String photo="";

     await FirebaseFirestore.instance
                  .collection('RewardItem')
                  .doc(reward.id)
                  .get()
                  .then((value) {
                  photo= value.data()?['image'];    
              }); 
      if(photo.isNotEmpty){
        deleteImage(photo);
      }
    if(reward.image!=null){
      
      String? img = '';
        int pos = reward.image.indexOf('.');
        img = "${reward.id}${reward.image.substring(pos)}";
        reward.image=img;
    }
       
       FirebaseFirestore.instance.collection("RewardItem").doc(reward.id).update(reward.toJson());
    if(file!=null)
     {uploadFile(reward.image, file);}
     

 
   
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
       String photo="";

     await FirebaseFirestore.instance
                  .collection('RewardItem')
                  .doc(docID)
                  .get()
                  .then((value) {
                  photo= value.data()?['image'];    
              }); 
      if(photo.isNotEmpty){
        deleteImage(photo);
      }

      await FirebaseFirestore.instance.collection("RewardItem").doc(docID).delete();
      

      return true;
    } on FirebaseException catch (e) {
  
      return "${e.code}. Something went wrong. Please try again.";
    }
  }
 static Future<UploadTask?> uploadFile(String img, File file) async {
    try {

       final destination = "reward/$img";
        final ref = FirebaseStorage.instance.ref().child(destination);

      
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }
  Future deleteImage(String img)async{
     try {
       final destination = "reward/$img";
        final ref = FirebaseStorage.instance.ref().child(destination);
     if(ref!=null){
      FirebaseStorage.instance.ref(ref.fullPath).delete();
     }
    } on FirebaseException catch (e) {
      return null;
    }

  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }

}