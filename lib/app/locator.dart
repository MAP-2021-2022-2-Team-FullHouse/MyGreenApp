import 'package:get_it/get_it.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:my_green_app/services/authentication/authentication_service_firebase.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'package:my_green_app/services/recycleCenter/recycleCenter_service.dart';
import 'package:my_green_app/services/recycleCenter/recycleCenter_service_firebase.dart';
import 'package:my_green_app/services/registration/registration_service.dart';
import 'package:my_green_app/services/registration/registration_service_firebase.dart';
import 'package:my_green_app/services/shop/shop_service.dart';
import 'package:my_green_app/services/shop/shop_service_firebase.dart';
import 'package:my_green_app/services/user/user_repository.dart';
import 'package:my_green_app/ui/views/login/login_viewmodel.dart';
import 'package:my_green_app/ui/views/recycleCenter/recycleCenter_viewmodel.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_viewmodel.dart';
import 'package:my_green_app/ui/views/register/register_viewmodel.dart';
import 'package:my_green_app/ui/views/admin/admin_viewmodel.dart';
import 'package:my_green_app/ui/views/reset/reset_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_green_app/services/reward/reward_service.dart';
import 'package:my_green_app/services/reward/reward_firebaseservice.dart';
import '../services/appointment/appointment_service.dart';
import '../services/appointment/appointment_service_firebase.dart';
import '../services/resetpassword/reset_service.dart';
import '../services/resetpassword/reset_service_firebase.dart';
import '../ui/views/Appointment/appointment_viewmodel.dart';
import '../ui/views/appointment/CreateAppointment/create_appointment_viewmodel.dart';
import '../ui/views/home/home_viewmodel.dart';
import 'package:my_green_app/ui/views/reward/createReward/create_reward_viewmodel.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/managelisting_viewmodel.dart';
import 'package:my_green_app/ui/views/shop/shop_viewmodel.dart';
import 'package:my_green_app/services/recycling_info/recycling_info_service.dart';
import 'package:my_green_app/services/recycling_info/recycling_info_service_firebase.dart';
import 'package:my_green_app/services/push_notification_service.dart';
import 'package:my_green_app/services/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

GetIt locator = GetIt.instance;
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
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
        locator.registerLazySingleton<RewardService>(
      () => RewardFirebaseService());
      locator.registerLazySingleton<AppointmentService>(
      () => AppointmentServiceFirebase());
  locator.registerLazySingleton<ShopService>(
      () => ShopServiceFirebase());
  locator.registerLazySingleton<RecyclingInfoService>(
      () => RecyclingInfoServiceFirebase());
  locator.registerLazySingleton<NavigatorService>(() => NavigatorService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton<PushNotificationService>(
      () => PushNotificationService());
  locator.registerLazySingleton<LocalNotificationService>(
      () => LocalNotificationService());
  
  locator.registerLazySingleton<UserRepository>(() => UserRepository());

  // Viewmodels
  locator.registerLazySingleton<HomeViewmodel>(() => HomeViewmodel());
  locator.registerLazySingleton<RegisterViewmodel>(() => RegisterViewmodel());
  locator.registerLazySingleton<LoginViewmodel>(() => LoginViewmodel());
  locator.registerLazySingleton<AdminViewmodel>(() => AdminViewmodel());
  locator.registerLazySingleton<ResetViewmodel>(() => ResetViewmodel());
  locator.registerLazySingleton<RecycleCenterViewmodel>(() => RecycleCenterViewmodel());
  locator.registerLazySingleton<CreateReward_ViewModel >(() => CreateReward_ViewModel ());
  locator.registerLazySingleton<AppointmentViewmodel>(
      () => AppointmentViewmodel());
  locator.registerLazySingleton<CreateAppointment_ViewModel>(
      () => CreateAppointment_ViewModel());
  locator.registerLazySingleton<ShopViewmodel>(
      () => ShopViewmodel());
  locator.registerLazySingleton<ManageListingViewmodel>(
      () => ManageListingViewmodel());
  locator.registerLazySingleton<RecyclingInfoViewmodel>(
      () => RecyclingInfoViewmodel());
      
}
