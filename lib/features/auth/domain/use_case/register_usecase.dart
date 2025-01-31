import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/auth_entity.dart';
import '../repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String fname;
  final String lname;
  final String email;
  final String password;
  final String profileImage;

  const RegisterUserParams({
    required this.fname,
    required this.lname,
    required this.email,
    required this.password,
    required this.profileImage,
  });
  const RegisterUserParams.initial()
      : fname = '',
        lname = '',
        email = '',
        password = '',
        profileImage = '';

  @override
  // TODO: implement props
  List<Object?> get props => [fname, lname, email, password, profileImage];
}

class RegisterUsecase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;
  RegisterUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
        id: null,
        fname: params.fname,
        lname: params.lname,
        email: params.email,
        password: params.password,
        profileImage: params.profileImage);
    return repository.registerUser(authEntity);
  }
}
