import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pes_revanced/components/components.dart';
import 'package:pes_revanced/layouts/mobile_screen_layout.dart';
// import 'package:login_app/screens/home_screen.dart';
import 'package:pes_revanced/screens/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:pes_revanced/constants.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String id = 'signup_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // final _auth = FirebaseAuth.instance;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MobileScreenLayout()));
        return true;
      },
      child: Scaffold(
        body: LoaderOverlay(
          useDefaultLoading: false,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const TopScreenImage(screenImageName: 'assets/PES_Logo.png'),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const ScreenTitle(title: 'Sign Up'),
                          CustomTextField(
                            textField: TextField(
                              controller: _email,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Email',
                              ),
                            ),
                          ),
                          CustomTextField(
                            textField: TextField(
                              obscureText: true,
                              controller: _password,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Password',
                              ),
                            ),
                          ),
                          CustomTextField(
                            textField: TextField(
                              obscureText: true,
                              controller: _confirmPass,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Confirm Password',
                              ),
                            ),
                          ),
                          CustomBottomScreen(
                            textButton: 'Sign Up',
                            question: 'Have an account?',
                            buttonPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              context.loaderOverlay.show();
                              if (_confirmPass.value.text ==
                                  _password.value.text) {
                                try {
                                  final response = await http.post(
                                      Uri.parse('$goURI/register'),
                                      body: {
                                        "email": _email.value.text,
                                        "pass": _password.value.text
                                      }).timeout(const Duration(seconds: 20),
                                      onTimeout: () =>
                                          http.Response('Error', 408));

                                  if (response.statusCode == 200) {
                                    if (context.mounted) {
                                      Navigator.of(context).pushReplacement(
                                          PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  const LoginScreen()));
                                    }
                                  } else {
                                    throw ErrorDescription(
                                        response.body.toString());
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        "Error in signIn $e",
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
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text(
                                    "Password and Confirmed Password Not same",
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
                              if (context.mounted) {
                                context.loaderOverlay.hide();
                              }
                            },
                            questionPressed: () async {
                              Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          const LoginScreen()));
                            },
                          ),
                        ],
                      ),
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
