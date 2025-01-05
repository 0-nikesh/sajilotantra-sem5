import 'package:flutter/material.dart';
import 'package:sajilotantra/app.dart';
import 'package:sajilotantra/services/service_locator.dart';

// void main() {

//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependency();

  runApp(
    const MyApp(),
  );
}
