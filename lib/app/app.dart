import 'package:flutter/material.dart';
import 'package:sajilotantra/core/theme/app_theme.dart';
import 'package:sajilotantra/features/home/presentation/view/dashboard.dart';
import 'package:sajilotantra/features/auth/presentation/view/login.dart';
import 'package:sajilotantra/features/auth/presentation/view/register.dart';
import 'package:sajilotantra/features/splash/presentation/view/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const Login(),
          "/register": (context) => const Register(),
          "/dashboard": (context) => const Dashboard(),
        });
  }
}