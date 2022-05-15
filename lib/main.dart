import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mygreenapp/services/navigation_service.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeServiceLocator();

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
      navigatorKey: locator<NavigationService>().navigatorKey,
      initialRoute: Routes.loginRoute,
      onGenerateRoute: Routes.createRoute,
    );
  }
}
