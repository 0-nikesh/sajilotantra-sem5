import 'package:flutter/material.dart';
import 'package:sajilotantra/view/dashboard.dart';
import 'package:sajilotantra/view/login.dart';
import 'package:sajilotantra/view/register.dart';
import 'package:sajilotantra/view/splash_screen.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => MyApp(),
        '/login': (context) => Login(),
        "/register": (context) => Register(),
        "/dashboard": (context) => MyApp(),
      }));
}
