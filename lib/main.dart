import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/app/router.dart' as router;
import 'package:my_green_app/ui/setup_dialog_ui.dart';
import 'package:stacked_services/stacked_services.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  setupDialogUi();
  // Keep splash screen until initialization has completed
  //FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
  // whenever your initialization is completed, remove the splash screen
  //FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Green App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      //navigatorKey: locator<NavigatorService>().navigatorKey,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: router.generateRoute,
      initialRoute: routes.loginRoute,
    );
  }
}
