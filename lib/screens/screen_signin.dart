import 'package:firebase_auth_app/blocs/signin/signin_cubit.dart';
import 'package:firebase_auth_app/screens/screen_home.dart';
import 'package:firebase_auth_app/screens/screen_signup.dart';
import 'package:firebase_auth_app/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

class ScreenSignIn extends StatefulWidget {
  static const String routeName = '/signin';
  const ScreenSignIn({super.key});

  @override
  State<ScreenSignIn> createState() => _ScreenSignInState();
}

class _ScreenSignInState extends State<ScreenSignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _email, _password;

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();
    context.read<SigninCubit>().signIn(email: _email!, password: _password!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<SigninCubit, SigninState>(
          listener: (context, state) {
            if (state.signinStatus == SigninStatus.error) {
              errorDialog(context, state.error);
            } else if (state.signinStatus == SigninStatus.success) {
              Navigator.pushNamed(context, ScreenHome.routeName);
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Image.asset(
                          'assets/images/flutter_logo.png',
                          width: 150,
                          height: 150,
                        ),
                        const SizedBox(height: 50),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Email Required.";
                            }

                            if (!isEmail(value.trim())) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _email = newValue;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Password Required.";
                            }

                            if (value.trim().length < 6) {
                              return "Password must be at least 6 characters long.";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _password = newValue;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () =>
                              state.signinStatus == SigninStatus.submitting
                                  ? null
                                  : _submit(),
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                          ),
                          child: state.signinStatus == SigninStatus.submitting
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator.adaptive(
                                    backgroundColor: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Text("Sign In"),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () =>
                              state.signinStatus == SigninStatus.submitting
                                  ? null
                                  : Navigator.pushNamed(
                                      context, ScreenSignUp.routeName),
                          style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                          )),
                          child: const Text("Not a member? Sign Up!"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
