//hive ko initiation directory path haru diney and db banaune,
//ani tesma queries haru add garney like put request ko for add,
// yesmai resgister adapter ra open box ko concept use garnu parxa
//register adapter le box imean table banauxa of database
// ani open box le tes bhitra ko data or row read garxa

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sajilotantra/app/constants/hive_table_constant.dart';
import 'package:sajilotantra/features/auth/data/model/auth_hive_model.dart';
import 'package:sajilotantra/features/guidance/data/model/guidance_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}/sajilotantra.db';

    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(UserHiveModelAdapter());
    Hive.registerAdapter(GuidanceHiveModelAdapter());
  }

  // User Queries

  // Add or Register a User
  Future<void> addUser(UserHiveModel user) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.put(user.id, user);
  }

  // Delete a User
  Future<void> deleteUser(String id) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  // Get All Users
  Future<List<UserHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    return box.values.toList();
  }

  // Find User by Email and Password (Login)
  Future<UserHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    try {
      return box.values.firstWhere(
        (user) => user.email == email && user.password == password,
      );
    } catch (e) {
      return null; // Return null if no user is found
    }
  }

  // Clear All Data
  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  // Clear Specific User Box
  Future<void> clearUserBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  //----------------------Guidance---------------------------

  // Add a new guidance
  Future<void> addGuidance(GuidanceHiveModel guidance) async {
    var box =
        await Hive.openBox<GuidanceHiveModel>(HiveTableConstant.guidanceBox);
    await box.put(guidance.id, guidance);
  }

  // Delete a guidance by ID
  Future<void> deleteGuidance(String id) async {
    var box =
        await Hive.openBox<GuidanceHiveModel>(HiveTableConstant.guidanceBox);
    await box.delete(id);
  }

  // Get all guidances
  Future<List<GuidanceHiveModel>> getAllGuidance() async {
    var box =
        await Hive.openBox<GuidanceHiveModel>(HiveTableConstant.guidanceBox);
    return box.values.toList();
  }

  // Get a specific guidance by ID
  Future<GuidanceHiveModel?> getGuidanceById(String id) async {
    var box =
        await Hive.openBox<GuidanceHiveModel>(HiveTableConstant.guidanceBox);
    return box.get(id);
  }

  // Update a specific guidance
  Future<void> updateGuidance(String id, GuidanceHiveModel guidance) async {
    var box =
        await Hive.openBox<GuidanceHiveModel>(HiveTableConstant.guidanceBox);
    await box.put(id, guidance);
  }

  // Close Hive Database
  Future<void> close() async {
    await Hive.close();
  }
}
