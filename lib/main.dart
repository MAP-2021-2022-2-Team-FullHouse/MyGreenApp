import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/app/router.dart' as router;
import 'package:my_green_app/ui/setup_dialog_ui.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:my_green_app/model/PushNotification.dart';
import 'package:my_green_app/services/push_notification_service.dart';
import 'package:my_green_app/ui/notification_badge.dart';
import 'package:overlay_support/overlay_support.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> backroundHandler(RemoteMessage message) async {
  print(" This is message from background");
  print(message.notification!.title);
  print(message.notification!.body);
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  setupDialogUi();
  FirebaseMessaging.onBackgroundMessage(backroundHandler);
  // Keep splash screen until initialization has completed
  //FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
  // whenever your initialization is completed, remove the splash screen
  //FlutterNativeSplash.remove();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return OverlaySupport(
        child: MaterialApp(
      title: 'My Green App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      //navigatorKey: locator<NavigatorService>().navigatorKey,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: router.generateRoute,
      initialRoute: routes.loginRoute,
        ));
  }
}
