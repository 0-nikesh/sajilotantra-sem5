// import 'package:dio/dio.dart';

// import '../../../../app/constants/api_endpoints.dart';
// import '../../../../core/error/failure.dart';
// import '../../../auth/data/model/auth_api_model.dart';

// abstract class UserRemoteDataSource {
//   Future<AuthApiModel> getUserProfile(String userId, String token);
// }

// class UserRemoteDataSourceImpl implements UserRemoteDataSource {
//   final Dio dio;

//   UserRemoteDataSourceImpl(this.dio);

//   @override
//   Future<AuthApiModel> getUserProfile(String userId, String token) async {
//     try {
//       final response = await dio.get(
//         ApiEndpoints.getuser + userId,
//         options: Options(headers: {"Authorization": "Bearer $token"}),
//       );

//       if (response.statusCode == 200) {
//         final jsonData = response.data;
//         print("✅ API Response: $jsonData"); // Debug log

//         return AuthApiModel.fromJson({
//           "_id": jsonData["_id"] ?? "",
//           "fname": jsonData["fname"] ?? "",
//           "lname": jsonData["lname"] ?? "",
//           "email": jsonData["email"] ?? "No Email",
//           "password": jsonData["password"] ?? "",
//           "image": jsonData["image"] != null ? jsonData["image"] as String : "",
//         });
//       } else {
//         throw const ApiFailure(message: "Failed to fetch user profile");
//       }
//     } catch (e) {
//       print("❌ Error in getUserProfile: $e");
//       throw ApiFailure(message: e.toString());
//     }
//   }
// }

// features/user/data/data_source/user_remote_data_source.dart
// features/user/data/data_source/user_remote_data_source.dart
import 'package:dio/dio.dart';

import '../../../../app/constants/api_endpoints.dart';
import '../../../../core/error/failure.dart';
import '../model/user_api_model.dart';

abstract class UserRemoteDataSource {
  Future<UserApiModel> getUserProfile(String userId, String token);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl(this.dio);

  @override
  Future<UserApiModel> getUserProfile(String userId, String token) async {
    try {
      final response = await dio.get(
        ApiEndpoints.getuser + userId,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        final jsonData = response.data as Map<String, dynamic>? ?? {};
        print("✅ API Response: $jsonData"); // Debug log

        return UserApiModel.fromJson(jsonData);
      } else {
        throw const ApiFailure(message: "Failed to fetch user profile");
      }
    } catch (e) {
      print("❌ Error in getUserProfile: $e");
      throw ApiFailure(message: e.toString());
    }
  }
}
