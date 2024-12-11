import 'package:flutter/material.dart';
import 'package:flutter_animated_splash/flutter_animated_splash.dart';
import 'package:sajilotantra/view/dashboard.dart';
import 'package:sajilotantra/view/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplash(
        type: Transition.size,
        child: Image.asset(
          "assets/images/tantra-logo.png",
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        backgroundColor: Colors.white,
        navigator: const Login(),
        durationInSeconds: 3);
  }
}
