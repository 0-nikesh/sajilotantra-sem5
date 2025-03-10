import 'package:flutter/material.dart';
import 'package:sajilotantra/app/app.dart';

import 'app/di/di.dart';
import 'core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  // await clearUserBox();

  // Initialize dependencies (including Hive)
  await initDependencies();

  runApp(const MyApp());
}

