import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_green_app/model/listing.dart';
import 'package:my_green_app/services/authentication/authentication_service_firebase.dart';
import 'package:my_green_app/services/shop/shop_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:my_green_app/app/locator.dart';

class ShopServiceFirebase extends ShopService {
  final firestoreInstance = FirebaseFirestore.instance;
  late final _dialogService = locator<DialogService>();

  @override
  Stream<List<Listing>> readListingList(String userID) => FirebaseFirestore
      .instance
      .collection('Listing')
      .where('sellerID', isEqualTo: userID)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Listing.fromJson(doc.id, doc.data()))
          .toList());

  @override
  Stream<List<Listing>> readAllListingList() => FirebaseFirestore.instance
      .collection('Listing')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Listing.fromJson(doc.id, doc.data()))
          .toList());

  @override
  Future<String> getImage(String pathname) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(pathname);
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future addListing(
      {required String title,
      required String category,
      required String condition,
      required String price,
      required String description,
      required String method,
      required String image,
      required String userID,
      File? file}) async {
    try {
      String? img = '';
      int pos = image.indexOf('.');
      String user =
          await AuthenticationServiceFirebase.getCurrentUserName(userID);
      final listingFirebase =
          await firestoreInstance.collection("Listing").add({
        "title": title,
        "category": category,
        "condition": condition,
        "price": price,
        "description": description,
        "method": method,
        "sellerID": userID,
        "seller": user
      });
      img = "${listingFirebase.id}${image.substring(pos)}";
      if (file != null) {
        uploadFile(img, file);
      }
    } on FirebaseAuthException catch (e) {
      String error;
      error = e.toString();
      return error;
    }
  }

  @override
  Future editListing(
      {required String title,
      required String category,
      required String condition,
      required String price,
      required String description,
      required String method,
      required String image,
      required String userID,
      required String docid,
      File? file}) async {
    try {
      String user =
          await AuthenticationServiceFirebase.getCurrentUserName(userID);
      await firestoreInstance.collection("Listing").doc(docid).update({
        "title": title,
        "category": category,
        "condition": condition,
        "price": price,
        "description": description,
        "method": method,
        "sellerID": userID,
        "seller": user
      });
      if (image.isNotEmpty) {
        String? img = '';
        int pos = image.indexOf('.');
        img = "$docid${image.substring(pos)}";
        if (file != null) {
          uploadFile(img, file);
        }
      }
    } on FirebaseAuthException catch (e) {
      String error;
      error = e.toString();
      return error;
    }
  }

  static Future<UploadTask?> uploadFile(String img, File file) async {
    try {
      final destination = "listing/$img";
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
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

  @override
  Future<Listing?> readListing(String docid) async {
    final listing = FirebaseFirestore.instance.collection('Listing').doc(docid);

    final snapshot = await listing.get();
    if (snapshot.exists) {
      return Listing.fromJson(docid, snapshot.data()!);
    } else {
      return null;
    }
  }

  @override
  Future deleteListing(String docid) async {
    try {
      await firestoreInstance.collection("Listing").doc(docid).delete();
      return true;
    } on FirebaseException catch (e) {
      return "${e.code}. Something went wrong. Please try again.";
    }
  }

  @override
  Future contactSeller(String phoneNo, Listing model) async {
    String text =
        "Hi ${model.seller}! I am interested to the *${model.title}* you listed in MyGreenApp!";

    var whatsappURl = "whatsapp://send?phone=+6$phoneNo&text=$text";
    try {
      await launchUrlString(whatsappURl);
    } catch (e) {
      _dialogService.showDialog(
        title: 'Failure',
        description: 'Something went wrong. Please try again.',
        buttonTitle: 'OK',
        dialogPlatform: DialogPlatform.Material, // DialogPlatform.Material
      );
    }
  }
}
