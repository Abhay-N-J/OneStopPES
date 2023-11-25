import 'package:flutter/material.dart';
import 'package:pes_revanced/screens/splash_screen.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  static const mobileBackgroundColor = Color.fromRGBO(0, 0, 0, 1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: const Scaffold(body: SplashScreen()));
  }
}
