// features/user/domain/use_case/get_user_profile_usecase.dart
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

class GetUserProfileUseCase {
  final UserRepository userRepository;

  GetUserProfileUseCase(this.userRepository);

  Future<Either<Failure, UserEntity>> call() {
    return userRepository.getUserProfile();
  }
}
