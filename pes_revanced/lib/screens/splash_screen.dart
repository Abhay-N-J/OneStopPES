import 'package:flutter/material.dart';
import 'package:pes_revanced/layouts/mobile_screen_layout.dart';
import 'package:http/http.dart' as http;
import 'package:pes_revanced/screens/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Access { auth, ok, bad }

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    pingAndRoute().then((value) => _navigateToNextScreen(value));

    // Future.delayed(const Duration(milliseconds: 1500), () {
    //   _navigateToNextScreen();
    // });
  }

  Future<Access> pingAndRoute() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final response = await http
          .get(Uri.parse('http://10.14.146.73:6969/ping'))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        return http.Response('Error', 408);
      });
      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String user = prefs.getString("user") ?? "";
        if (user.isEmpty) {
          return Access.auth;
        }
        return Access.ok;
      } else {
        return Access.bad;
      }
    } catch (e) {
      print(e);
      return Access.bad;
    }
  }

  void _navigateToNextScreen(Access isGranted) {
    if (isGranted == Access.bad) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          "Connection Error",
          textAlign: TextAlign.center,
        ),
        duration: const Duration(minutes: 10),
        backgroundColor: Colors.deepOrange,
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(24),
        ),
      ));
      return;
    }
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              isGranted == Access.ok
                  ? const MobileScreenLayout()
                  : const Auth(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage('assets/PES_Logo.png'),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
    );
  }
}
