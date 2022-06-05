import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/services/navigation_service.dart';
import '../../model/user.dart' as AppUser;
import '../firebase.dart';
import 'recycleCenter_service.dart';

class RecycleCenterServiceFirebase extends RecycleCenterService {
  final navigator = NavigatorService();
  final firestoreInstance = FirebaseFirestore.instance;
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('RecycleCenter');
  final _firebaseAuth = FirebaseAuthentication();
  FirebaseAuth get _auth => _firebaseAuth.auth;


  @override
  Future deleteCenter(String docemail) async {
    try {
      String id = '';
      String rcName = '';
      await FirebaseFirestore.instance
          .collection('RecycleCenter')
          .where('email', isEqualTo: docemail)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          print(element.id);
          id = element.id;
        });
      });
      print(id);
      await firestoreInstance.collection("RecycleCenter").doc(id).delete();
      return true;
    } on FirebaseException catch (e) {
      return e.code + ". Something went wrong. Please try again.";
    }
  }

  @override
  Future getRCList() async {
    try {
      if (await RecycleCenter.getCenterList() != null) {
        //rcList = rcDocuments;
        return await RecycleCenter.getCenterList();
      } else {
        return "Error in fetching list";
      }
    } catch (e) {
      return e.toString();
    }
  }
  
   static Future getCenterList() async {
    // Get docs from collection reference
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('RecycleCenter');
    List centerList = [];
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    centerList = querySnapshot.docs.map((doc) => doc.data()).toList();

    return centerList;
  }

  @override
  Stream<List<RecycleCenter>> readRC() => FirebaseFirestore.instance
      .collection('RecycleCenter')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => RecycleCenter.fromJson(doc.data()))
          .toList());

  @override
  Future getRC(String docemail) async
  {
    var rc;
    await FirebaseFirestore.instance
      .collection('RecycleCenter')
      .where('email', isEqualTo: docemail)
      .get()
      .then((value) {
        value.docs.forEach((element) {
          print(element.id);
          rc=element.data();
        });
      });
    return RecycleCenter.fromJson(rc);
    
  }
  
  Future<bool> isRecycleCenterNameExist(String name)async{
 CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('RecycleCenter');
    List centerList = [];
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    centerList = querySnapshot.docs.map((doc) => doc.data()).toList();
    for(int i=0; i<centerList.length; i++){
      if(centerList[i]['name']==name){ 
        return true;
      }
    }
return false;
  }
  Future<bool> isImageExist(String name)async{
 CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('RecycleCenter');
    List centerList = [];
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    centerList = querySnapshot.docs.map((doc) => doc.data()).toList();
    for(int i=0; i<centerList.length; i++){
      if(centerList[i]['image']==name){ 
        return true;
      }
    }
return false;
  }
  Future<bool> isPhoneExist(String name)async{
 CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('RecycleCenter');
    List centerList = [];
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    centerList = querySnapshot.docs.map((doc) => doc.data()).toList();
    for(int i=0; i<centerList.length; i++){
      if(centerList[i]['phone']==name){ 
        return true;
      }
    }
return false;
  }
@override
  Future addRecycleCenter(
      {required String name,
      required String address,
      required String phone,
      required String image,
      required String email,
      required double lat,
      required double lon,
      required String password
      }) async {
      late bool n,i, p;
    try {
      n=await isRecycleCenterNameExist(name);
      i=await isImageExist(image);
      p=await isPhoneExist(phone);
      if(n==true){
        return "name duplicated";
      }
      if(image!=null&&image!=""&&i==true){
        return "image duplicated";
      }
      if(p==true){
        return "phone duplicated";
      }
      final recycleCenterCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      

      firestoreInstance.collection("RecycleCenter").doc(recycleCenterCredential.user?.uid).set({
        "name": name,
         "address": address,
        "phone": phone,
        "image":image,
        "email": email,
        "lat":lat,
        "lon":lon,
        "password":password
      }).then((value) {
        print('Recycle Center added');
      });
      firestoreInstance.collection("User").doc(recycleCenterCredential.user?.uid).set({
        "name": name,
        "phone": phone,
        "email": email,
        "address": address,
        "role": "Recycle Center",
      }).then((value) {
        print('User added');
      });
      return "ok";


    } on FirebaseAuthException catch (e) {
      String error;
      if (e.code == 'weak-password') {
        error = 'weak-password';
      } else if (e.code == 'email-already-in-use') {
        error = 'email-already-in-use';
      } else {
        error = e.toString();
      }
      return error;
    }
  }

  Future<String> getImage(String pathname) async
  {
    try {
      final ref = FirebaseStorage.instance.ref().child(pathname);
      String imageUrl = await ref.getDownloadURL();
      print(imageUrl);
      return imageUrl;
    } catch (e) {
      print("Error: $e");
      return e.toString();
    }
  }

  static Future<UploadTask?> uploadFile(String destination, File file) async  {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return  ref.putFile(file);
    } on FirebaseException catch (e) {
      print("error");
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
