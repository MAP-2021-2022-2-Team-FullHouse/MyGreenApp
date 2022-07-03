import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'package:my_green_app/ui/views/map/MapViewModel.dart';
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

Future queryData(String queryString)async{
  print("aaaaa");
  return FirebaseFirestore.instance
  .collection("RecycleCenter")
  .where( "name", isGreaterThanOrEqualTo:queryString)
  .get();
}
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
  Future<RecycleCenter?> readCenter(String docemail) async {
    String id = '';
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
    final rc = FirebaseFirestore.instance.collection("RecycleCenter").doc(id);
    final snapshot = await rc.get();
    if (snapshot.exists) {
      return RecycleCenter.fromJson(snapshot.data()!);
    } else {
      return null;
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
  Future getRC(String docemail) async {
    var rc;
    await FirebaseFirestore.instance
        .collection('RecycleCenter')
        .where('email', isEqualTo: docemail)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element.id);
        rc = element.data();
      });
    });
    return RecycleCenter.fromJson(rc);
  }

  Future<bool> isRecycleCenterNameExist(String name) async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('RecycleCenter');
    List centerList = [];
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    centerList = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (int i = 0; i < centerList.length; i++) {
      if (centerList[i]['name'] == name) {
        return true;
      }
    }
    return false;
  }

  Future<bool> isImageExist(String name) async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('RecycleCenter');
    List centerList = [];
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    centerList = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (int i = 0; i < centerList.length; i++) {
      if (centerList[i]['image'] == name) {
        return true;
      }
    }
    return false;
  }

  Future<bool> isPhoneExist(String name) async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('RecycleCenter');
    List centerList = [];
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    centerList = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (int i = 0; i < centerList.length; i++) {
      if (centerList[i]['phone'] == name) {
        return true;
      }
    }
    return false;
  }

  @override
  Future addRecycleCenter(
      {required RecycleCenter rc,
     
      File? file}) async {
    late bool n, p;
    try {
      

      if(rc.address.isEmpty||rc.phone.isEmpty||rc.name.isEmpty||rc.email.isEmpty||rc.password.isEmpty||rc.lat.isNaN||rc.lon.isNaN){
       
        return "Form is not completely filled";
      }
       String pattern = r'\w+@\w+\.\w+';
       RegExp regex;
        regex=RegExp(pattern);
       if(!regex.hasMatch(rc.email)){
        return "Invalid email format";
       }
       pattern= r'^(\+?6?01)[02-46-9]-*[0-9]{7}|^(\+?6?01)[1]-*[0-9]{8}$';
        regex=RegExp(pattern);
         if(!regex.hasMatch(rc.phone)){
        return "Invalid phone format";
       }
       if(rc.password.length<8){
        return "Password too short";
       }

       n = await isRecycleCenterNameExist(rc.name);
      
      p = await isPhoneExist(rc.phone);
      if (n == true) {
        return "name duplicated";
      }
    
      if (p == true) {
        return "phone duplicated";
      }

      


      final recycleCenterCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: rc.email,
        password: rc.password,
      );
      String? img='';
      int pos=rc.image.indexOf('.');
      if(img.contains('.'))
      {img="${recycleCenterCredential.user?.uid}${rc.image.substring(pos)}";}

      firestoreInstance
          .collection("RecycleCenter")
          .doc(recycleCenterCredential.user?.uid)
          .set(rc.toJson()).then((value) {
        print('Recycle Center added');
      });
      firestoreInstance
          .collection("User")
          .doc(recycleCenterCredential.user?.uid)
          .set({
        "name": rc.name,
        "phone": rc.phone,
        "email": rc.email,
        "address": rc.address,
        "role": "Recycle Center",
      }).then((value) {
        print('User added');
      });

      if(file!=null){
        uploadFile(img, file);
      }
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

  @override
  Future editRecycleCenter(
      {required String oriemail,
      required String name,
      required String address,
      required String phone,
      required String image,
      required String email,
      required double lat,
      required double lon,
      required String password}) async {
    late bool n, e, p;
    try {
      n = await isRecycleCenterNameUsedByOthers(name, oriemail);
      e = await isEmailRegisteredByOthers(oriemail, email);
      p = await isPhoneRegisteredByOthers(phone, oriemail);
      if (n == true) {
        return "name duplicated";
      }
      if (e == true) {
        return "email registered by others";
      }
      if (p == true) {
        return "phone duplicated";
      }
      String id = '';
      await FirebaseFirestore.instance
          .collection('RecycleCenter')
          .where('email', isEqualTo: oriemail)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          id = element.id;
        });
      });
      firestoreInstance.collection("RecycleCenter").doc(id).update({
        "name": name,
        "address": address,
        "phone": phone,
        "image": image,
        "email": email,
        "lat": lat,
        "lon": lon,
        "password": password
      }).then((value) {
        print('Recycle Center edited');
      });
      firestoreInstance.collection("User").doc(id).update({
        "name": name,
        "phone": phone,
        "email": email,
        "address": address,
        "role": "Recycle Center",
      }).then((value) {
        print('User edited');
      });
      return "ok";
    } on FirebaseAuthException catch (e) {
      String error;
      if (e.code == 'weak-password') {
        error = 'weak-password';
      } /*else if (e.code == 'email-already-in-use') {
        error = 'email-already-in-use';
      }*/
      else {
        error = e.toString();
      }
      return error;
    }
  }

  Future<bool> isRecycleCenterNameUsedByOthers(
      String name, String email) async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('RecycleCenter');
    List centerList = [];
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    centerList = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (int i = 0; i < centerList.length; i++) {
      if (centerList[i]['email'] == email) {
        continue;
      }
      if (centerList[i]['name'] == name) {
        return true;
      }
    }
    return false;
  }

  Future<bool> isPhoneRegisteredByOthers(String phone, String email) async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('RecycleCenter');
    List centerList = [];
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    centerList = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (int i = 0; i < centerList.length; i++) {
      if (centerList[i]['email'] == email) {
        continue;
      }
      if (centerList[i]['phone'] == phone) {
        return true;
      }
    }
    return false;
  }

  Future<bool> isEmailRegisteredByOthers(
      String oriemail, String newemail) async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('RecycleCenter');
    List centerList = [];
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    centerList = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (int i = 0; i < centerList.length; i++) {
      if (centerList[i]['email'] == oriemail) {
        continue;
      }
      if (centerList[i]['email'] == newemail) {
        return true;
      }
    }
    return false;
  }

  Future<String> getImage(String pathname) async {
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

  static Future<UploadTask?> uploadFile(String img, File file) async {
    try {
      final destination="recycleCenter/"+img;
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
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
