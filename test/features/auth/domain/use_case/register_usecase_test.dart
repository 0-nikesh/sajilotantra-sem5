import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sajilotantra/core/error/failure.dart';
import 'package:sajilotantra/features/auth/domain/entity/auth_entity.dart';
import 'package:sajilotantra/features/auth/domain/use_case/register_usecase.dart';
import 'package:sajilotantra/features/auth/domain/use_case/repository.mock.dart';

void main() {
  late MockAuthRepository repository;
  late RegisterUsecase registerUsecase;

  setUp(() {
    repository = MockAuthRepository();
    registerUsecase = RegisterUsecase(repository);
    registerFallbackValue(const AuthEntity.empty());
  });

  const validRegisterParams = RegisterUserParams(
    fname: "Bottle",
    lname: "Bhandari",
    email: "bottlebhandari@gmail.com",
    password: "123456",
    profileImage:
        "https://asset.cloudinary.com/davmrc5zy/af439146d7b5384d3651879fdcf855a7",
  );

  group('RegisterUsecase Tests', () {
    test('Returns Failure when any field is empty', () async {
      // Arrange
      const invalidParams = RegisterUserParams(
        fname: "",
        lname: "Bhandari",
        email: "bottlebhandari@gmail.com",
        password: "123456",
        profileImage:
            "https://asset.cloudinary.com/davmrc5zy/af439146d7b5384d3651879fdcf855a7",
      );
      when(() => repository.registerUser(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "All fields are required")));

      // Act
      final result = await registerUsecase(invalidParams);

      // Assert
      expect(
          result, const Left(ApiFailure(message: "All fields are required")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('Returns Failure when email format is invalid', () async {
      // Arrange
      const invalidEmailParams = RegisterUserParams(
        fname: "Bottle",
        lname: "Bhandari",
        email: "invalid-email",
        password: "123456",
        profileImage:
            "https://asset.cloudinary.com/davmrc5zy/af439146d7b5384d3651879fdcf855a7",
      );
      when(() => repository.registerUser(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: "Invalid email format")));

      // Act
      final result = await registerUsecase(invalidEmailParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Invalid email format")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('Returns Failure when server returns an error', () async {
      // Arrange
      when(() => repository.registerUser(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Internal Server Error")));

      // Act
      final result = await registerUsecase(validRegisterParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Internal Server Error")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('Returns successfully when all fields are valid', () async {
      // Arrange
      when(() => repository.registerUser(any()))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await registerUsecase(validRegisterParams);

      // Assert
      expect(result, const Right(null));
      verify(() => repository.registerUser(any())).called(1);
    });
  });
}
