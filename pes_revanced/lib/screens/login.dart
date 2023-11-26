import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pes_revanced/layouts/mobile_screen_layout.dart';
import 'package:pes_revanced/components/components.dart';
import 'package:pes_revanced/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            controller: _email,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            decoration: kTextInputDecoration.copyWith(
                                hintText: 'Email')),
                      ),
                      CustomTextField(
                        textField: TextField(
                          obscureText: true,
                          // onChanged: (value) {
                          //   _password = value;
                          // },
                          controller: _password,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: kTextInputDecoration.copyWith(
                              hintText: 'Password'),
                        ),
                      ),
                      CustomBottomScreen(
                        textButton: 'Login',
                        question: 'Forgot password?',
                        buttonPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          context.loaderOverlay.show();
                          try {
                            // await _auth.signInWithEmailAndPassword(
                            //     email: _email, password: _password);
                            if (_email.value.text.isEmpty ||
                                _password.value.text.isEmpty) {
                              throw ErrorDescription(
                                  "Email and Password can't be empty");
                            }
                            final response = await http.post(
                                Uri.parse('$goURI/login'),
                                body: {
                                  "email": _email.value.text,
                                  "pass": _password.value.text
                                }).timeout(const Duration(seconds: 20),
                                onTimeout: () => http.Response('Error', 408));
                            if (response.statusCode == 200) {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              final body = json.decode(response.body);
                              prefs.setString("user", _email.value.text);
                              prefs.setString("srn", body["srn"]);
                              prefs.setString("branch", body["branch"]);
                              prefs.setString("sem", body["sem"]);
                              if (context.mounted) {
                                Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            const MobileScreenLayout()));
                              }
                            } else {
                              throw ErrorDescription(response.body.toString());
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "Connection Error $e",
                                  textAlign: TextAlign.center,
                                ),
                                duration: const Duration(seconds: 5),
                                backgroundColor: Colors.deepOrange,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.red, width: 1),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ));
                            }
                          } finally {
                            if (context.mounted) {
                              context.loaderOverlay.hide();
                            }
                          }
                        },
                        questionPressed: () {
                          //   signUpAlert(
                          //     onPressed: () async {
                          //       await FirebaseAuth.instance
                          //           .sendPasswordResetEmail(email: _email);
                          //     },
                          //     title: 'RESET YOUR PASSWORD',
                          //     desc:
                          //         'Click on the button to reset your password',
                          //     btnText: 'Reset Now',
                          //     context: context,
                          //   ).show();
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
    );
  }
}

// WillPopScope(
//       onWillPop: () async {
//         Navigator.of(context).pushReplacement(PageRouteBuilder(
//             pageBuilder: (context, animation, secondaryAnimation) =>
//                 const MobileScreenLayout()));
//         return false;
//       },
//       child: 
