import 'package:flutter/material.dart';
import 'package:sajilotantra/core/app_theme/app_theme.dart';
import 'package:sajilotantra/view/dashboard.dart';
import 'package:sajilotantra/view/login.dart';
import 'package:sajilotantra/view/register.dart';
import 'package:sajilotantra/view/splash_screen.dart';

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
