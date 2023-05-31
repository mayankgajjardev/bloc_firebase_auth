import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/blocs/auth/auth_bloc.dart';
import 'package:firebase_auth_app/blocs/profile/profile_cubit.dart';
import 'package:firebase_auth_app/blocs/signin/signin_cubit.dart';
import 'package:firebase_auth_app/blocs/signup/signup_cubit.dart';
import 'package:firebase_auth_app/firebase_options.dart';
import 'package:firebase_auth_app/repositories/auth_repository.dart';
import 'package:firebase_auth_app/repositories/profile_repository.dart';
import 'package:firebase_auth_app/screens/screen_home.dart';
import 'package:firebase_auth_app/screens/screen_signin.dart';
import 'package:firebase_auth_app/screens/screen_signup.dart';
import 'package:firebase_auth_app/screens/screen_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
        RepositoryProvider(
          create: (context) => ProfileRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SigninCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(
              profileRepository: context.read<ProfileRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
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
        ),
      ),
    );
  }
}
