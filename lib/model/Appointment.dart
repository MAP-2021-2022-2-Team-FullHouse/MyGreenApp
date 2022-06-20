import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  late String name, remark, userEmail, recycleCenterEmail;
  //late int quantity;

  late String documentId, status, quantity, photos, userName, phone;
  late String category, deliveryMethod, image;
  //late var photos;
  late DateTime dateTime;

  late String rcName;
  late String url;
  static String nothing = '';

  Appointment({
    this.name = '',
    this.category = '',
    required this.dateTime,
    this.image = '',
    this.userEmail = '',
    this.userName = '',
    this.phone = '',
    this.recycleCenterEmail = '',
    this.quantity = '',
    this.documentId = '',
    this.deliveryMethod = '',
    this.remark = '',
    this.status = '',
    this.photos = '',
    this.rcName = '',
  });

  static void retrieveRecycleCenterName(String email) {
    var name;
    FirebaseFirestore.instance
        .collection('RecycleCenter')
        .where('email', isEqualTo: email)
        .get()
        .then((value) {
      name = value.docs[0]['name'];
      nothing = name;
    });
    //return name;
  }

  static Future<String> retrievePhone(email) async {
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

  static Future<String> retrieveUserName(email) async {
    var uName;
    var coll = await FirebaseFirestore.instance
        .collection('User')
        .where('email', isEqualTo: email)
        .get();
    //.then((value) {
    return coll.docs[0]['name'];
    //});
    //return uName;
  }

  static Future getAppointmentList() async {
    // Get docs from collection reference
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('Appointment');
    List appointmentList = [];
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    appointmentList = querySnapshot.docs.map((doc) => doc.data()).toList();

    return appointmentList;
  }

  static Future getPhotos(String docID) async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('Appointment');
    List photoList = [];
    QuerySnapshot querySnapshot =
        await _collectionRef.doc(docID).collection('photos').get();

    // Get data from docs and convert map to List
    photoList = querySnapshot.docs.map((doc) => doc.data()).toList();

    return photoList;
  }

  static Appointment fromJson(Map<String, dynamic> json) => Appointment(
        name: json['name'],
        dateTime: DateTime.fromMicrosecondsSinceEpoch(
            json['dateTime'].microsecondsSinceEpoch),
        category: json['category'],
        image: json['image'],
        deliveryMethod: json['deliveryMethod'],
        userEmail: json['userEmail'],
        recycleCenterEmail: json['recycleCenterEmail'],
        remark: json['remark'],
        quantity: json['quantity'],
        status: json['status'],
        // rcName: await retrieveRecycleCenterName(json['recycleCenterEmail']),
        // userName: await retrieveUserName(json['userEmail']),
        //phone: await retrievePhone(json['userEmail']
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'dateTime': dateTime,
        'category': category,
        'deliveryMethod': deliveryMethod,
        'userEmail': userEmail,
        'remark': remark,
        'recycleCenterEmail': recycleCenterEmail,
        'quantity': quantity,
        'photos': photos,
        'status': status,
      };

  static Appointment fromMap(Map<String, dynamic> map) {
    //if (map == null) return null;
    retrieveRecycleCenterName(map['recycleCenterEmail']);
    return Appointment(
      name: map['name'],
      dateTime: DateTime.fromMicrosecondsSinceEpoch(
          map['dateTime'].microsecondsSinceEpoch),
      category: map['category'],
      image: map['image'],
      deliveryMethod: map['deliveryMethod'],
      userEmail: map['userEmail'],
      recycleCenterEmail: map['recycleCenterEmail'],
      remark: map['remark'],
      quantity: map['quantity'],
      status: map['status'],
      rcName: nothing,
    );
  }
}
