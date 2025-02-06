import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sajilotantra/core/error/failure.dart';
import 'package:sajilotantra/features/auth/domain/use_case/repository.mock.dart';
import 'package:sajilotantra/features/auth/domain/use_case/verify_usecase.dart';


void main() {
  late MockAuthRepository repository;
  late VerifyEmailUsecase verifyEmailUsecase;

  setUp(() {
    repository = MockAuthRepository();
    verifyEmailUsecase = VerifyEmailUsecase(repository);
  });



  group('VerifyEmailUsecase Tests', () {
    test('should return Failure when email is empty', () async {
      // Arrange
      var emptyEmailParams = VerifyEmailParams(email: "", otp: "123456",);
      when(() => repository.verifyEmail(any(), any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Email cannot be empty")));

      // Act
      final result = await verifyEmailUsecase(emptyEmailParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Email cannot be empty")));
      verify(() => repository.verifyEmail(any(), any())).called(1);
    });

    test('should return Failure when OTP is empty', () async {
      // Arrange
      var emptyOtpParams = VerifyEmailParams(email: "test@example.com", otp: "");
      when(() => repository.verifyEmail(any(), any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "OTP cannot be empty")));

      // Act
      final result = await verifyEmailUsecase(emptyOtpParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "OTP cannot be empty")));
      verify(() => repository.verifyEmail(any(), any())).called(1);
    });
  });
}