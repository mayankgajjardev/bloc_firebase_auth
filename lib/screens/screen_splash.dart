import 'package:flutter/material.dart';

class ScreenSplash extends StatelessWidget {
  static const String routeName = '/';
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
