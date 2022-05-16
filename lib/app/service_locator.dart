import 'package:map_mvvm/service_locator.dart';
import 'package:mygreenapp/services/authentication/authentication_service.dart';
import 'package:mygreenapp/services/authentication/authentication_service_firebase.dart';
import 'package:mygreenapp/services/dialog/dialog_service.dart';
import 'package:mygreenapp/services/navigation_service.dart';
import 'package:mygreenapp/services/registration/registration_service.dart';
import 'package:mygreenapp/services/registration/registration_service_firebase.dart';
import 'package:mygreenapp/services/user/user_repository.dart';
import 'package:mygreenapp/ui/screen/login/login_viewmodel.dart';
import 'package:mygreenapp/ui/screen/register/register_viewmodel.dart';
import 'package:mygreenapp/ui/screen/admin/admin_viewmodel.dart';


import '../ui/screen/home/home_viewmodel.dart';
import '../services/services.dart';

final locator = ServiceLocator.locator;

Future<void> initializeServiceLocator() async {
  locator.registerLazySingleton<ServiceInitializer>(
      () => ServiceInitializerFirebase());

  final serviceInitializer = locator<ServiceInitializer>();
  await serviceInitializer.init();

  // Services
  locator.registerLazySingleton<RegistrationService>(
      () => RegistrationServiceFirebase());
  locator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationServiceFirebase());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton<UserRepository>(() => UserRepository());
  locator.registerLazySingleton(() => DialogService());

  // Viewmodels
  locator.registerLazySingleton<HomeViewmodel>(() => HomeViewmodel());
  locator.registerLazySingleton<RegisterViewmodel>(() => RegisterViewmodel());
  locator.registerLazySingleton<LoginViewmodel>(() => LoginViewmodel());
  locator.registerLazySingleton<AdminViewmodel>(() => AdminViewmodel());
}
