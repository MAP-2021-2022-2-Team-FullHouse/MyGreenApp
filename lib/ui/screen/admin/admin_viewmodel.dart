import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_mvvm/viewmodel.dart';
import 'package:mygreenapp/services/user/user_repository.dart';
import '../../../app/app.dart';

import '../../../app/service_locator.dart';

class AdminViewmodel extends Viewmodel {
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;
  final UserRepository _userRepository = locator();

  AdminViewmodel() {
    _userRepository.addListener(() {
      notifyListeners();
    });
  }

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;
  }

  Future<void> signOut() async {
    await _userRepository.signOut();
    /*if (_userRepository.user == null) {
      print("Logout");
    } else {
      //_errorMessage = _userRepository.error;
      print("Not logout");
    }*/
  }

  @override
  void dispose() {
    _streamListener?.cancel();
    _streamListener = null;
    super.dispose();
  }

  // Future<User?> readUser() async {
  //   final docUser=FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser.uid);
  // }
}
