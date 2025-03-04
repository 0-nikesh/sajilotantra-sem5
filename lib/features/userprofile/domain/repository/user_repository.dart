// features/user/domain/repository/user_repository.dart
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/user_entity.dart';

abstract interface class UserRepository {
  Future<Either<Failure, UserEntity>> getUserProfile();
}
