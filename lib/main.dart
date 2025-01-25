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
  await printAllUsers();

  runApp(const MyApp());
}

// Future<void> clearUserBox() async {
//   await Hive.deleteBoxFromDisk('userBox'); // Deletes the box from disk
// }

Future<void> printAllUsers() async {
  var hiveService = HiveService();
  var allUsers = await hiveService.getAllUsers();

  if (allUsers.isEmpty) {
    print("No users found in the database.");
  } else {
    print("List of all users in the database:");
    for (var user in allUsers) {
      print("ID: ${user.id}, Email: ${user.email}");
    }
  }
}
