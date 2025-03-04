import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/failure.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _sharedPreferences.setString('token', token);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      if (token == null || token.isEmpty) {
        return const Left(SharedPrefsFailure(message: "No Token Found"));
      }
      return Right(token);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<void> clearToken() async {
    await _sharedPreferences.remove('token');
  }
}
