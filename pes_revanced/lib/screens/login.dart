import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pes_revanced/layouts/mobile_screen_layout.dart';
import 'package:pes_revanced/components/components.dart';
import 'package:pes_revanced/constants.dart';
// import 'package:login_app/screens/welcome.dart';
// import 'package:login_app/screens/home_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final _auth = FirebaseAuth.instance;
  late String _email;
  late String _password;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MobileScreenLayout()));
        return false;
      },
      child: Scaffold(
        body: LoaderOverlay(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // const TopScreenImage(screenImageName: 'welcome.png'),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const ScreenTitle(title: 'Login'),
                        CustomTextField(
                          textField: TextField(
                              onChanged: (value) {
                                _email = value;
                              },
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                  hintText: 'Email')),
                        ),
                        CustomTextField(
                          textField: TextField(
                            obscureText: true,
                            onChanged: (value) {
                              _password = value;
                            },
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            decoration: kTextInputDecoration.copyWith(
                                hintText: 'Password'),
                          ),
                        ),
                        CustomBottomScreen(
                          textButton: 'Login',
                          heroTag: 'login_btn',
                          question: 'Forgot password?',
                          buttonPressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            setState(() {
                              _saving = true;
                            });
                            try {
                              // await _auth.signInWithEmailAndPassword(
                              //     email: _email, password: _password);
                              // context.loaderOverlay.show();
                              // await Future.delayed(Duration(seconds: 5));
                              // context.loaderOverlay.hide();
                              // await Future.delayed(Duration(seconds: 2));
                              if (context.mounted) {
                                setState(() {
                                  _saving = false;
                                  Navigator.of(context).pushReplacement(
                                      PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              const LoginScreen()));
                                });
                                Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            const MobileScreenLayout()));
                              }
                            } catch (e) {
                              // signUpAlert(
                              //   context: context,
                              //   onPressed: () {
                              //     setState(() {
                              //       _saving = false;
                              //     });
                              //     Navigator.popAndPushNamed(
                              //         context, LoginScreen.id);
                              //   },
                              //   title: 'WRONG PASSWORD OR EMAIL',
                              //   desc:
                              //       'Confirm your email and password and try again',
                              //   btnText: 'Try Now',
                              // ).show();
                            }
                          },
                          questionPressed: () {
                            // signUpAlert(
                            //   onPressed: () async {
                            //     await FirebaseAuth.instance
                            //         .sendPasswordResetEmail(email: _email);
                            //   },
                            //   title: 'RESET YOUR PASSWORD',
                            //   desc:
                            //       'Click on the button to reset your password',
                            //   btnText: 'Reset Now',
                            //   context: context,
                            // ).show();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
