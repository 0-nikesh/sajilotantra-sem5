import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sajilotantra/core/error/failure.dart';
import 'package:sajilotantra/features/auth/domain/use_case/login_usecase.dart';
import 'package:sajilotantra/features/auth/domain/use_case/repository.mock.dart';
import 'package:sajilotantra/features/auth/domain/use_case/token.mock.dart';


void main() {
  late MockAuthRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late LoginUsecase loginUsecase;

  setUp(() {
    repository = MockAuthRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    loginUsecase = LoginUsecase(repository, tokenSharedPrefs);
  });

  const userLoginParams = LoginParams(
    email: "bhandarinikesh93@gmail.com",
    password: "123456",
  );

  const generatedToken = "mock_jwt_token";

  group('LoginUsecase Tests', () {
    test('Returns Failure when credentials are incorrect', () async {
      // Arrange
      when(() => repository.loginUser(any(), any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Invalid user credentials")));

      // Act
      final result = await loginUsecase(userLoginParams);

      // Assert
      expect(
          result, const Left(ApiFailure(message: "Invalid user credentials")));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => tokenSharedPrefs.saveToken(any()));
    });

    test('Returns Failure when email is empty', () async {
      // Arrange
      const userLoginParams = LoginParams(email: "", password: "SecurePassword123");
      when(() => repository.loginUser(any(), any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Email cannot be empty")));

      // Act
      final result = await loginUsecase(userLoginParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Email cannot be empty")));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => tokenSharedPrefs.saveToken(any()));
    });

    test('Returns Failure when password is empty', () async {
      // Arrange
      const userLoginParams = LoginParams(email: "test@example.com", password: "");
      when(() => repository.loginUser(any(), any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Password cannot be empty")));

      // Act
      final result = await loginUsecase(userLoginParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Password cannot be empty")));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => tokenSharedPrefs.saveToken(any()));
    });

    test('Returns Failure when there is a server error', () async {
      // Arrange
      when(() => repository.loginUser(any(), any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Internal Server Error")));

      // Act
      final result = await loginUsecase(userLoginParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Internal Server Error")));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => tokenSharedPrefs.saveToken(any()));
    });

    test('Returns successfully and return token', () async {
      // Arrange
      when(() => repository.loginUser(any(), any()))
          .thenAnswer((_) async => const Right(generatedToken));
      when(() => tokenSharedPrefs.saveToken(any()))
          .thenAnswer((_) async => const Right(null));
      when(() => tokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(generatedToken));

      // Act
      final result = await loginUsecase(userLoginParams);

      // Assert
      expect(result, const Right(generatedToken));
      verify(() => repository.loginUser(
          userLoginParams.email, userLoginParams.password)).called(1);
      verify(() => tokenSharedPrefs.saveToken(generatedToken)).called(1);
      verify(() => tokenSharedPrefs.getToken()).called(1);
    });
  });
}