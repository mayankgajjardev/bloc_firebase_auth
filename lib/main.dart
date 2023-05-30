import 'package:firebase_auth_app/firebase_options.dart';
import 'package:firebase_auth_app/screens/screen_home.dart';
import 'package:firebase_auth_app/screens/screen_signin.dart';
import 'package:firebase_auth_app/screens/screen_signup.dart';
import 'package:firebase_auth_app/screens/screen_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScreenSplash(),
      routes: {
        ScreenSignUp.routeName: (context) => const ScreenSignUp(),
        ScreenSignIn.routeName: (context) => const ScreenSignIn(),
        ScreenHome.routeName: (context) => const ScreenHome(),
      },
    );
  }
}
