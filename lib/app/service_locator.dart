import 'package:map_mvvm/service_locator.dart';
import 'package:mygreenapp/services/authentication/authentication_service.dart';
import 'package:mygreenapp/services/authentication/authentication_service_firebase.dart';
import 'package:mygreenapp/services/registration/registration_service.dart';
import 'package:mygreenapp/services/registration/registration_service_firebase.dart';
import 'package:mygreenapp/services/user/user_repository.dart';
import 'package:mygreenapp/ui/screen/login/login_viewmodel.dart';
import 'package:mygreenapp/ui/screen/register/register_viewmodel.dart';

import '../ui/screen/home/home_viewmodel.dart';
import '../services/services.dart';

final locator = ServiceLocator.locator;

Future<void> initializeServiceLocator() async {
  // In case of using Firebase services, Firebase must be initialized first before the service locator,
  //  because viewmodels may need to access firebase during the creation of the objects.

  // To comply with Dependency Inversion, the Firebase.initializeApp() is called in a dedicated service file.
  //  So that, if you want to change to different services (other than Firebase), you can do so by simply
  //  defining another ServiceInitializer class.

  // await Firebase.initializeApp();

  // Register first and then run immediately
  locator.registerLazySingleton<ServiceInitializer>(
      () => ServiceInitializerFirebase());

  final serviceInitializer = locator<ServiceInitializer>();
  await serviceInitializer.init();

  // Register Services
  locator
      .registerLazySingleton<CounterService>(() => CounterServiceFirestore());
  locator.registerLazySingleton<RegistrationService>(
      () => RegistrationServiceFirebase());
  locator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationServiceFirebase());
  locator.registerLazySingleton<UserRepository>(() => UserRepository());

  // Register Viewmodels
  locator.registerLazySingleton<HomeViewmodel>(() => HomeViewmodel());
  locator.registerLazySingleton<RegisterViewmodel>(() => RegisterViewmodel());
  locator.registerLazySingleton<LoginViewmodel>(() => LoginViewmodel());
}
