import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../model/user.dart' as AppUser;

abstract class AuthenticationService {
  Future signIn({required String email, required String password});
  Future<String> getRole(String userid);
  Future<String> getImage(String pathname);
  Future signOut();
  String? getCurrentUserEmail();
  Future<String> getEmail(String uid);
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUser();
  Future updateUser(AppUser.User user);
  Future readUser(String docID);
  //Future<String> getCurrentRole();
  /* static Future<String> getImage(String pathname) async {
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
}
