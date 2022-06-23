import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_green_app/model/listing.dart';
import 'package:my_green_app/services/shop/shop_service.dart';

class ShopServiceFirebase extends ShopService {
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Stream<List<Listing>> readListingList(String email) =>
      FirebaseFirestore.instance
          .collection('Listing')
          .where('seller', isEqualTo: email)
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
      required String useremail,
      File? file}) async {
    try {
      String? img = '';
      int pos = image.indexOf('.');
      final listingFirebase =
          await firestoreInstance.collection("Listing").add({
        "title": title,
        "category": category,
        "condition": condition,
        "price": price,
        "description": description,
        "method": method,
        "seller": useremail,
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
      required String useremail,
      required String docid,
      File? file}) async {
    try {
      await firestoreInstance.collection("Listing").doc(docid).update({
        "title": title,
        "category": category,
        "condition": condition,
        "price": price,
        "description": description,
        "method": method,
        "seller": useremail,
      });
      if (image.isNotEmpty) {
        String? img = '';
        int pos = image.indexOf('.');
        img = "${docid}${image.substring(pos)}";
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
}
