import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/services/navigation_service.dart';
import 'package:my_green_app/services/registration/registration_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewmodel extends BaseViewModel {
  //late final UserRepository _userRepository = locator();
  final _registrationService = locator<RegistrationService>();
  final _navigationService = locator<NavigationService>();
  late String _errorMessage;
  String get errorMessage => _errorMessage;
  /* User get user => _userRepository.user;
   */
  //set errorMessage(value) => update(() => _errorMessage = value);
  RegisterViewmodel() {
    _errorMessage = "";
  }
  Future addUser(
      {required String email,
      required String password,
      required String name,
      required String address,
      required String phone}) async {
    dynamic result = await _registrationService.addUser(
        email: email,
        password: password,
        name: name,
        address: address,
        phone: phone);
    if (result != null) {
      if (result == 'email-already-in-use') {
        return "Email is registered.";
      } else if (result == "weak-password") {
        return "Weak password";
      } else if (result == 'invalid-email') {
        return "Invalid email address.";
      } else {
        _navigationService.navigateTo(routes.homeRoute);
      }
    } else {
      return "Something went wrong.";
    }
  }
}
