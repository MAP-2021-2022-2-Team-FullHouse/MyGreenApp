import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/services/resetpassword/reset_service.dart';
import 'package:stacked/stacked.dart';
import '../../../services/user/user_repository.dart';

class ResetViewmodel extends BaseViewModel {
  late final UserRepository _userRepository = locator();
  final ResetPasswordService _resetService = locator();

  User get user => _userRepository.user.copyWith();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future sendResetPassEmail({required String email}) async {
    dynamic result = await _resetService.sendResetPassEmail(email: email);
    if (result != null) {
      _errorMessage = "yeah errormessage null";
      //_errorMessage = _userRepository.error;
      return _errorMessage;
    } else {
      _errorMessage = " ";
      return _errorMessage;
    }
  }
}
