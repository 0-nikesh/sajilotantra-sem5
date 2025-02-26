import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dartz/dartz.dart';

import '../../../../app/shared_prefs/token_shared_prefs.dart';
import '../../../../core/error/failure.dart';
import '../../../auth/domain/entity/auth_entity.dart';
import '../../domain/repository/user_repository.dart';
import '../data_source/user_remote_data_source.dart';

class UserRemoteRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final TokenSharedPrefs tokenSharedPrefs;

  UserRemoteRepositoryImpl(this.userRemoteDataSource, this.tokenSharedPrefs);

  @override
  Future<Either<Failure, AuthEntity>> getUserProfile() async {
    try {
      final tokenResult = await tokenSharedPrefs.getToken();
      return tokenResult.fold(
        (failure) => Left(failure),
        (token) async {
          if (token.isEmpty) {
            return const Left(ApiFailure(message: "Token is empty"));
          }

          final decodedToken = JWT.decode(token);
          final userId = decodedToken.payload['id'];

          if (userId == null || userId is! String) {
            return const Left(
                ApiFailure(message: "User ID not found in token"));
          }

          final userModel =
              await userRemoteDataSource.getUserProfile(userId, token);
          return Right(userModel.toEntity());
        },
      );
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
