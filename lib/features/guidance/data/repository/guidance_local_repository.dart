import 'package:dartz/dartz.dart';
import 'package:sajilotantra/core/error/failure.dart';
import 'package:sajilotantra/features/guidance/domain/entity/guidance_entity.dart';
import 'package:sajilotantra/features/guidance/domain/repository/guidance_repository.dart';

import '../data_source/local_data_source/guidance_local_datasource.dart';

class GuidanceLocalRepository implements IGuidanceRepository {
  final GuidanceLocalDataSource _guidanceLocalDataSource;

  GuidanceLocalRepository(
      {required GuidanceLocalDataSource guidanceLocalDataSource})
      : _guidanceLocalDataSource = guidanceLocalDataSource;

  @override
  Future<Either<Failure, void>> createGuidance(GuidanceEntity guidance) async {
    try {
      await _guidanceLocalDataSource.createGuidance(guidance);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGuidance(String id) async {
    try {
      await _guidanceLocalDataSource.deleteGuidance(id);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GuidanceEntity>>> getAllGuidances() async {
    try {
      final guidances = await _guidanceLocalDataSource.getAllGuidances();
      return Right(guidances);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GuidanceEntity?>> getGuidanceById(String id) async {
    try {
      final guidance = await _guidanceLocalDataSource.getGuidanceById(id);
      return Right(guidance);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateGuidance(
      String id, GuidanceEntity guidance) async {
    try {
      await _guidanceLocalDataSource.updateGuidance(id, guidance);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
