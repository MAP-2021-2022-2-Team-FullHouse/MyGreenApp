import 'package:flutter/material.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app/app.dart';

void main() async {
  final widgetBinding = WidgetsFlutterBinding.ensureInitialized();

  // Keep splash screen until initialization has completed
  //FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
  await initializeServiceLocator();
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
        primarySwatch: Colors.amber,
      ),
      initialRoute: Routes.loginRoute,
      onGenerateRoute: Routes.createRoute,
    );
  }
}
