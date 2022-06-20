import 'package:get_it/get_it.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:my_green_app/services/authentication/authentication_service_firebase.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'package:my_green_app/services/recycleCenter/recycleCenter_service.dart';
import 'package:my_green_app/services/recycleCenter/recycleCenter_service_firebase.dart';
import 'package:my_green_app/services/recycling_info/recycling_info_service.dart';
import 'package:my_green_app/services/recycling_info/recycling_info_service_firebase.dart';
import 'package:my_green_app/services/registration/registration_service.dart';
import 'package:my_green_app/services/registration/registration_service_firebase.dart';
import 'package:my_green_app/services/user/user_repository.dart';
import 'package:my_green_app/ui/views/login/login_viewmodel.dart';
import 'package:my_green_app/ui/views/recycleCenter/recycleCenter_viewmodel.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_viewmodel.dart';
import 'package:my_green_app/ui/views/register/register_viewmodel.dart';
import 'package:my_green_app/ui/views/admin/admin_viewmodel.dart';
import 'package:my_green_app/ui/views/reset/reset_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import '../services/resetpassword/reset_service.dart';
import '../services/resetpassword/reset_service_firebase.dart';
import '../ui/views/home/home_viewmodel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Services
  locator.registerLazySingleton<RegistrationService>(
      () => RegistrationServiceFirebase());
  locator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationServiceFirebase());
  locator.registerLazySingleton<ResetPasswordService>(
      () => ResetPasswordServiceFirebase());
  locator.registerLazySingleton<RecycleCenterService>(
      () => RecycleCenterServiceFirebase());
  locator.registerLazySingleton<RecyclingInfoService>(
      () => RecyclingInfoServiceFirebase());
  locator.registerLazySingleton<NavigatorService>(() => NavigatorService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton<UserRepository>(() => UserRepository());

  // Viewmodels
  locator.registerLazySingleton<HomeViewmodel>(() => HomeViewmodel());
  locator.registerLazySingleton<RegisterViewmodel>(() => RegisterViewmodel());
  locator.registerLazySingleton<LoginViewmodel>(() => LoginViewmodel());
  locator.registerLazySingleton<AdminViewmodel>(() => AdminViewmodel());
  locator.registerLazySingleton<ResetViewmodel>(() => ResetViewmodel());
  locator.registerLazySingleton<RecycleCenterViewmodel>(
      () => RecycleCenterViewmodel());
  locator.registerLazySingleton<RecyclingInfoViewmodel>(
      () => RecyclingInfoViewmodel());
}
