import 'dart:async';

import 'package:map_mvvm/viewmodel.dart';
import 'package:mygreenapp/services/user/user_repository.dart';
import '../../../app/app.dart';

import '../../../app/service_locator.dart';

class HomeViewmodel extends Viewmodel {
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;
  final UserRepository _userRepository = locator();

  HomeViewmodel() {
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
}
