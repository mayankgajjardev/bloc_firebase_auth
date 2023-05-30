import 'package:flutter/material.dart';

class ScreenSignIn extends StatefulWidget {
  static const String routeName = '/signin';
  const ScreenSignIn({super.key});

  @override
  State<ScreenSignIn> createState() => _ScreenSignInState();
}

class _ScreenSignInState extends State<ScreenSignIn> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("SignIn"),
      ),
    );
  }
}
