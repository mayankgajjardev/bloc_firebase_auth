import 'package:firebase_auth_app/blocs/auth/auth_bloc.dart';
import 'package:firebase_auth_app/screens/screen_home.dart';
import 'package:firebase_auth_app/screens/screen_signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenSplash extends StatelessWidget {
  static const String routeName = '/';
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            ScreenSignIn.routeName,
            (route) =>
                route.settings.name == ModalRoute.of(context)!.settings.name
                    ? true
                    : false,
          );
        } else if (state.authStatus == AuthStatus.authenticated) {
          Navigator.pushNamed(context, ScreenHome.routeName);
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      },
    );
  }
}
