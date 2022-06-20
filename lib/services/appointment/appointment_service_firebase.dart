import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:my_green_app/model/Appointment.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:my_green_app/services/authentication/authentication_service_firebase.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'package:path/path.dart' as Path;
import '../firebase.dart';
import 'appointment_service.dart';

class AppointmentServiceFirebase extends AppointmentService {
  final navigator = NavigatorService();
  final firestoreInstance = FirebaseFirestore.instance;
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('Appointment');
  //static late File img;
  static var URLs = [];
  static List photoList = [];
  static String docID = '';
  static String name = '';
  static String phone = '';
  static String appointmentID = '';
  static String email = '';
  /* var ref = FirebaseStorage.instance
      .ref()
      .child('appointment/${Path.basename(img.path)}'); */

  final _firebaseAuth = FirebaseAuthentication();
  FirebaseAuth get _auth => _firebaseAuth.auth;

  @override
  Future addAppointment(
      {required String name,
      required String category,
      required String deliveryMethod,
      required String userEmail,
      required String rcEmail,
      required String quantity,
      required String remark,
      required String dateTime,
      List<File>? imageURLs}) async {
    try {
      _collectionRef.add({
        "name": name,
        "category": category,
        "dateTime": DateTime.parse(dateTime),
        "deliveryMethod": deliveryMethod,
        "userEmail": userEmail,
        "recycleCenterEmail": rcEmail,
        "quantity": quantity,
        "remark": remark,
        "status": "pending"
      }).then((documentSnapshot) async {
        print("Added Data with ID: ${documentSnapshot.id}");
        docID = documentSnapshot.id;
        int count = 1;
        for (var i in imageURLs!) {
          var ref = FirebaseStorage.instance
              .ref()
              .child('appointment/$docID/${Path.basename(i.path)}');
          await ref.putFile(i).whenComplete(() async {
            await ref.getDownloadURL().then((value) {
              //imgRef.add({'url': value});
              //imagesURL.add(value);
              firestoreInstance
                  .collection("Appointment")
                  .doc(docID)
                  .collection("photos")
                  .doc("${docID}_$count")
                  .set({'url': value});
              if (count == 1) {
                _collectionRef.doc(docID).update({'image': value});
              }
              count++;
            });
          });
        }
      });
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  @override
  String? getEmail() {
    return AuthenticationServiceFirebase().getUID();
    //print(email);
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

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  /* static Reference transferReference(File img, String userEmail) {
    //File img;
    //String dir = Path.dirname(img.path);
    //String newPath = Path.join(dir, 'case01wd03id01.jpg');
    //print('NewPath: ${newPath}');
    //img.renameSync(newPath);
    return FirebaseStorage.instance
        .ref()
        .child('appointment/${userEmail}/${Path.basename(img.path)}');
  } */

  @override
  Future<String> readAppointmentID(
      String rcEmail, DateTime dt, String uEmail) async {
    String id = '';
    await FirebaseFirestore.instance
        .collection('Appointment')
        .where('userEmail', isEqualTo: uEmail)
        .where('recycleCenterEmail', isEqualTo: rcEmail)
        .where('dateTime', isEqualTo: Timestamp.fromDate(dt))
        .get()
        .then((value) {
      for (var element in value.docs) {
        //print(element.id);
        id = element.id;
      }
    });
    return id;
    /* final rc = FirebaseFirestore.instance.collection("Appointment").doc(id);
    final snapshot = await rc.get();
    if (snapshot.exists) {
      return Appointment.fromJson(snapshot.data()!);
    } else {
      return null;
    } */
  }

  Future getPhotos(String docID) async {
    try {
      var list = Appointment.getPhotos(docID);
      //final ref = FirebaseStorage.instance.ref().child(pathname);
      //String imageUrl = await ref.getDownloadURL();
      print(list);
      return list;
    } catch (e) {
      print("Error: $e");
      return e.toString();
    }
  }

  @override
  Stream<List<Appointment>> readRC() {
    var currEmail = getEmail();
    print(currEmail);
    var appointments;
    appointments = FirebaseFirestore.instance
        .collection('Appointment')
        .where('userEmail', isEqualTo: currEmail)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              var a = Appointment.fromJson(doc.data());
              //a.rcName = retrieveRecycleCenterName(a.recycleCenterEmail);
              //a.userName = retrieveUserName(a.userEmail);
              a.documentId = doc.id;
              return a;
            }).toList());

    return appointments;
  }

  @override
  Stream<List<Appointment>> readRCAppointments() {
    var currEmail = getEmail();
    print(currEmail);
    var appointments;
    appointments = FirebaseFirestore.instance
        .collection('Appointment')
        .where('recycleCenterEmail', isEqualTo: currEmail)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              var a = Appointment.fromJson(doc.data());
              a.documentId = doc.id;
              return a;
            }).toList());
    return appointments;
    //return appointments;
  }

  @override
  Future getPhotoURLs(String id) async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('Appointment');
    List photoList = [];
    QuerySnapshot querySnapshot =
        await _collectionRef.doc(id).collection('photos').get();

    // Get data from docs and convert map to List
    photoList = querySnapshot.docs;

    return photoList;
  }

  @override
  Future<String> getID(String rcEmail, DateTime dt, String uEmail) async {
    //var id;
    var docSnap = await FirebaseFirestore.instance
        .collection('Appointment')
        .where('userEmail', isEqualTo: uEmail)
        .where('recycleCenterEmail', isEqualTo: rcEmail)
        .where('dateTime', isEqualTo: Timestamp.fromDate(dt))
        .get();
    var id = docSnap.docs[0].id;
    docID = id;
    return id;
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getAppointment(String id) {
    // var id = getID(rcEmail, dt, uEmail);
    return FirebaseFirestore.instance
        .collection('Appointment')
        .doc(id)
        .snapshots();
  }

  @override
  Future cancelAppointment(String id) async {
    await firestoreInstance
        .collection("Appointment")
        .doc(id)
        .update({'status': 'cancel'});
  }

  @override
  Future changeAppointmentStatus(String id, String status) async {
    await firestoreInstance
        .collection("Appointment")
        .doc(id)
        .update({'status': status});
  }
  /* @override
  Future<String> getImage() async {
    try {
      final ref = FirebaseStorage.instance.ref().child(pathname);
      String imageUrl = await ref.getDownloadURL();
      print(imageUrl);
      return imageUrl;
    } catch (e) {
      print("Error: $e");
      return e.toString();
    }
  } */

  @override
  Future readPhoto(String email) async {
    //getEmail();
    await FirebaseFirestore.instance
        .collection('Appointment')
        .where('userEmail', isEqualTo: email)
        .get()
        .then((value) async {
      for (var element in value.docs) {
        print(element.id);
        appointmentID = element.id;
        CollectionReference _collectionRef =
            FirebaseFirestore.instance.collection('Appointment');
        List dataPhoto = [];
        QuerySnapshot querySnapshot =
            await _collectionRef.doc(docID).collection('photos').get();
        return _collectionRef.doc(docID).collection('photos').get();
        /* .then((value) {
          for (var i in value.docs) {
            dataPhoto.add(i.data());
            return i.data();
          } */
        //});
        //return dataPhoto;
        //return photoList = querySnapshot.docs.map((doc) => doc.data()).toList();
      }
    });
  }

  @override
  Future<String> retrieveRecycleCenterName(String email) async {
    var collection = await FirebaseFirestore.instance
        .collection('RecycleCenter')
        .where('email', isEqualTo: email)
        .get();
    var name = await collection.docs[0]['name'];
    return name;
  }

  @override
  Future<String> retrieveUserName(String email) async {
    var collection = await FirebaseFirestore.instance
        .collection('User')
        .where('email', isEqualTo: email)
        .get();
    var name = await collection.docs[0]['name'];
    return name;
  }

  @override
  Future<String> retrievePhone(String email) async {
    var phone;
    var coll = await FirebaseFirestore.instance
        .collection('User')
        .where('email', isEqualTo: email)
        .get();
    //.then((value) {
    return coll.docs[0]['phone'];
    //});
    //return phone;
  }

  @override
  Future getPostsOnceOff() async {
    try {
      var currEmail = getEmail();
      print(currEmail);
      var appointments;
      var documents = await FirebaseFirestore.instance
          .collection('Appointment')
          .where('recycleCenterEmail', isEqualTo: currEmail)
          .get();
      if (documents.docs.isNotEmpty) {
        return documents.docs
            .map((snapshot) => Appointment.fromMap(snapshot.data()))
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  // Create the controller that will broadcast the posts
  final StreamController<List<Appointment>> _appsController =
      StreamController<List<Appointment>>.broadcast();

  @override
  Stream listenToPostsRealTime() {
    // Register the handler for when the posts data changes
    var currEmail = getEmail();
    print(currEmail);
    FirebaseFirestore.instance
        .collection('Appointment')
        .where('recycleCenterEmail', isEqualTo: currEmail)
        .snapshots()
        .listen((postsSnapshot) {
      if (postsSnapshot.docs.isNotEmpty) {
        var posts = postsSnapshot.docs
            .map((snapshot) => Appointment.fromMap(snapshot.data()))
            //.where((mappedItem) => mappedItem.title != null)
            .toList();

        // Add the posts onto the controller
        _appsController.add(posts);
      }
    });

    // Return the stream underlying our _postsController.
    return _appsController.stream;
  }
}
