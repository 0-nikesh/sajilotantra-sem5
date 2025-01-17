import 'package:flutter/material.dart';
import 'package:sajilotantra/features/auth/presentation/view/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/tantra-logo.png',
              width: 300,
              height: 200,
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/text-logo.png',
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(
              color: Color.fromARGB(255, 17, 47, 74),
            ),
          ],
        ),
      ),
    );
  }
}
