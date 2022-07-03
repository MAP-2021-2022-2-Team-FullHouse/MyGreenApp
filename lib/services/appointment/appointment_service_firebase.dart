import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_green_app/model/Appointment.dart';
import 'package:my_green_app/services/authentication/authentication_service_firebase.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'package:my_green_app/services/push_notification_service.dart';
import '../firebase.dart';
import 'appointment_service.dart';
// ignore: library_prefixes
import 'package:path/path.dart' as Path;

class AppointmentServiceFirebase extends AppointmentService {
  final navigator = NavigatorService();
  final firestoreInstance = FirebaseFirestore.instance;
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('Appointment');
  // ignore: non_constant_identifier_names
  static var URLs = [];
  static List photoList = [];
  static String docID = '';
  static String name = '';
  static String phone = '';
  static String appointmentID = '';
  static String email = '';
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
        docID = documentSnapshot.id;
        int count = 1;
        for (var i in imageURLs!) {
          var ref = FirebaseStorage.instance
              .ref()
              .child('appointment/$docID/${Path.basename(i.path)}');
          await ref.putFile(i).whenComplete(() async {
            await ref.getDownloadURL().then((value) {
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
      return e.toString();
    }
  }

  @override
  String? getEmail() {
    return AuthenticationServiceFirebase().getCurrentUserEmail();
  }

  @override
  Future<String> getRole() async {
    var id = _auth.currentUser!.uid;
    return await AuthenticationServiceFirebase().getRole(id);
  }

  Future<String> getImage(String pathname) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(pathname);
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
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
        id = element.id;
      }
    });
    return id;
  }

  Future getPhotos(String docID) async {
    try {
      var list = Appointment.getPhotos(docID);
      return list;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Stream<List<Appointment>> readUserAppointment() {
    var currEmail = getEmail();
    var appointments = FirebaseFirestore.instance
        .collection('Appointment')
        .where('userEmail', isEqualTo: currEmail)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              var a = Appointment.fromJson(doc.data());
              a.documentId = doc.id;
              return a;
            }).toList());
    return appointments;
  }

  @override
  Stream<List<Appointment>> readRCAppointments() {
    var currEmail = getEmail();
    var appointments = FirebaseFirestore.instance
        .collection('Appointment')
        .where('recycleCenterEmail', isEqualTo: currEmail)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              var a = Appointment.fromJson(doc.data());
              a.documentId = doc.id;
              return a;
            }).toList());
    return appointments;
  }

  @override
  Future getPhotoURLs(String id) async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('Appointment');
    List photoList = [];
    QuerySnapshot querySnapshot =
        await collectionRef.doc(id).collection('photos').get();
    // Get data from docs and convert map to List
    photoList = querySnapshot.docs;
    return photoList;
  }

  @override
  Future<String> getID(String rcEmail, DateTime dt, String uEmail) async {
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
  Future cancelAppointment(String id, String oppositeEmail) async {
    await firestoreInstance
        .collection("Appointment")
        .doc(id)
        .update({'status': 'cancel'});
    var currentRole = await getRole();
    if (currentRole == 'user') {
      var userDevice = await retrieveUserDevice(oppositeEmail);
      PushNotificationService().sendPushMessageRecycleCenter(
          'Appointment', 'An appointment has been cancelled.', userDevice);
    } else if (currentRole == 'Recycle Center') {
      var userDevice = await retrieveUserDevice(oppositeEmail);
      PushNotificationService().sendPushMessage(
          'Appointment', 'Your appointment has been cancelled.', userDevice);
    }
  }

  @override
  Future changeAppointmentStatus(String id, String status, String email) async {
    await firestoreInstance
        .collection("Appointment")
        .doc(id)
        .update({'status': status});

    var userDevice = await retrieveUserDevice(email);
    if (status == 'approve') {
      PushNotificationService().sendPushMessage('Congratulations!',
          "Your appointment has been approved.", userDevice);
    } else if (status == 'reject') {
      PushNotificationService().sendPushMessage(
          'Appointment', 'Your appointment has been rejected.', userDevice);
    } else if (status == 'going') {
      PushNotificationService().sendPushMessage('Appointment',
          'The recycle center is going to pick up now.', userDevice);
    } else if (status == 'complete') {
      PushNotificationService().sendPushMessage(
          'Appointment', 'Your appointment has been completed.', userDevice);
    } else {
      PushNotificationService().sendPushMessage(
          'Appointment', 'Check out your appointment status.', userDevice);
    }
  }

  @override
  Future readPhoto(String email) async {
    //getEmail();
    await FirebaseFirestore.instance
        .collection('Appointment')
        .where('userEmail', isEqualTo: email)
        .get()
        .then((value) async {
      for (var element in value.docs) {
        appointmentID = element.id;
        CollectionReference collectionRef =
            FirebaseFirestore.instance.collection('Appointment');
        return collectionRef.doc(docID).collection('photos').get();
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
  Future<String> retrieveUserDevice(String email) async {
    var collection = await FirebaseFirestore.instance
        .collection('User')
        .where('email', isEqualTo: email)
        .get();
    var token = await collection.docs[0]['fcmToken'];
    return token;
  }

  @override
  Future<String> retrievePhone(String email) async {
    var coll = await FirebaseFirestore.instance
        .collection('User')
        .where('email', isEqualTo: email)
        .get();
    return coll.docs[0]['phone'];
  }

  /*static DateTime StartOfWeek(DateTime dt)
  {
    DateTime ndt = dt.Subtract(TimeSpan.FromDays((int)dt.DayOfWeek));
    return new DateTime(ndt.Year, ndt.Month, ndt.Day, 0, 0, 0, 0);
  }*/

  @override
  Future<List<int>> trackAppointment() async {
    var currEmail = getEmail();
    List<int> appointmentData = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    int weekAppointment,
        monthAppointment,
        yearAppointment,
        pendingAppointment,
        acceptedAppointment,
        goingAppointment,
        rejectedAppointment,
        cancelledAppointment,
        completedAppointment;
    var now = DateTime.now();
    int currentDay = now.weekday == 7 ? 0 : now.weekday;
    var nowWeekStart = now.subtract(Duration(days: currentDay));
    nowWeekStart = DateTime(
        nowWeekStart.year, nowWeekStart.month, nowWeekStart.day, 0, 0, 0);
    var nextWeekStart =
        now.add(Duration(days: DateTime.daysPerWeek - currentDay));
    nextWeekStart = DateTime(
        nextWeekStart.year, nextWeekStart.month, nextWeekStart.day, 0, 0, 0);
    var nowMonthStart = DateTime(now.year, now.month, 1, 0, 0, 0);
    var nextMonthStart = DateTime(now.year, now.month + 1, 1);
    var nowYearStart = DateTime(now.year, 1, 1);
    var nextYearStart = DateTime(now.year + 1, 1, 1);
    //Get number of appointments in this week starting from Sunday to Saturday
    await FirebaseFirestore.instance
        .collection('Appointment')
        .where('recycleCenterEmail', isEqualTo: currEmail)
        .where('dateTime',
            isGreaterThanOrEqualTo: Timestamp.fromDate(nowWeekStart))
        .where('dateTime', isLessThan: Timestamp.fromDate(nextWeekStart))
        .get()
        .then((data) {
      weekAppointment = data.docs.length;
      appointmentData[0] = weekAppointment;
    });
    //Get number of appointments in this month
    await FirebaseFirestore.instance
        .collection('Appointment')
        .where('recycleCenterEmail', isEqualTo: currEmail)
        .where('dateTime',
            isGreaterThanOrEqualTo: Timestamp.fromDate(nowMonthStart))
        .where('dateTime', isLessThan: Timestamp.fromDate(nextMonthStart))
        .get()
        .then((data) {
      monthAppointment = data.docs.length;
      appointmentData[1] = monthAppointment;
    });
    //Get number of appointments in this year
    await FirebaseFirestore.instance
        .collection('Appointment')
        .where('recycleCenterEmail', isEqualTo: currEmail)
        .where('dateTime',
            isGreaterThanOrEqualTo: Timestamp.fromDate(nowYearStart))
        .where('dateTime', isLessThan: Timestamp.fromDate(nextYearStart))
        .get()
        .then((data) {
      yearAppointment = data.docs.length;
      appointmentData[2] = yearAppointment;
    });
    // Get number of pending appointments
    await FirebaseFirestore.instance
        .collection('Appointment')
        .where('recycleCenterEmail', isEqualTo: currEmail)
        .where('status', isEqualTo: 'pending')
        .get()
        .then((data) {
      pendingAppointment = data.docs.length;
      appointmentData[3] = pendingAppointment;
    });
    // Get number of accepted appointments
    await FirebaseFirestore.instance
        .collection('Appointment')
        .where('recycleCenterEmail', isEqualTo: currEmail)
        .where('status', isEqualTo: 'accept')
        .get()
        .then((data) {
      acceptedAppointment = data.docs.length;
      appointmentData[4] = acceptedAppointment;
    });
    // Get number of in-progress(going) appointments
    await FirebaseFirestore.instance
        .collection('Appointment')
        .where('recycleCenterEmail', isEqualTo: currEmail)
        .where('status', isEqualTo: 'going')
        .get()
        .then((data) {
      goingAppointment = data.docs.length;
      appointmentData[5] = goingAppointment;
    });
    // Get number of rejected appointments
    await FirebaseFirestore.instance
        .collection('Appointment')
        .where('recycleCenterEmail', isEqualTo: currEmail)
        .where('status', isEqualTo: 'reject')
        .get()
        .then((data) {
      rejectedAppointment = data.docs.length;
      appointmentData[6] = rejectedAppointment;
    });
    // Get number of cancelled appointments
    await FirebaseFirestore.instance
        .collection('Appointment')
        .where('recycleCenterEmail', isEqualTo: currEmail)
        .where('status', isEqualTo: 'cancel')
        .get()
        .then((data) {
      cancelledAppointment = data.docs.length;
      appointmentData[7] = cancelledAppointment;
    });
    // Get number of completed appointments
    await FirebaseFirestore.instance
        .collection('Appointment')
        .where('recycleCenterEmail', isEqualTo: currEmail)
        .where('status', isEqualTo: 'complete')
        .get()
        .then((data) {
      completedAppointment = data.docs.length;
      appointmentData[8] = completedAppointment;
    });
    return appointmentData;
  }
}
