import 'package:flutter/material.dart';

class ScreenSignUp extends StatefulWidget {
  static const String routeName = '/signup';
  const ScreenSignUp({super.key});

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("SignUp"),
      ),
    );
  }
}
