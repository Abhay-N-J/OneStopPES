import 'package:flutter/material.dart';
import 'package:pes_revanced/components/components.dart';
// import 'package:login_app/components/components.dart';
import 'package:pes_revanced/screens/login.dart';
import 'package:pes_revanced/screens/signup.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TopScreenImage(screenImageName: 'assets/PES_Logo.png'),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 15.0, left: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Hello',
                        style: TextStyle(fontSize: 100),
                      ),
                      const Text(
                        'Welcome to PES Revanced App',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Hero(
                        tag: 'login_btn',
                        child: ElevatedButton(
                          child: const Text('Login'),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const LoginScreen()));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Hero(
                        tag: 'signup_btn',
                        child: ElevatedButton(
                          child: const Text('Sign Up'),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const SignUpScreen()));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
