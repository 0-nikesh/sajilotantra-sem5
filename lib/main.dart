import 'package:flutter/material.dart';
import 'package:sajilotantra/app/app.dart';
import 'package:sajilotantra/services/service_locator.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependency();

  runApp(
    const MyApp(),
  );
}