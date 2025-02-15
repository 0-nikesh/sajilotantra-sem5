import 'package:dartz/dartz.dart';
import 'package:sajilotantra/core/error/failure.dart';
import 'package:sajilotantra/features/guidance/domain/entity/guidance_entity.dart';
import 'package:sajilotantra/features/guidance/domain/repository/guidance_repository.dart';

import '../data_source/remote_data_source/guidance_remote_datasource.dart';

class GuidanceRemoteRepository implements IGuidanceRepository {
  final GuidanceRemoteDataSource _guidanceRemoteDataSource;

  GuidanceRemoteRepository(
      {required GuidanceRemoteDataSource guidanceRemoteDataSource})
      : _guidanceRemoteDataSource = guidanceRemoteDataSource;

  @override
  Future<Either<Failure, void>> createGuidance(GuidanceEntity guidance) async {
    try {
      await _guidanceRemoteDataSource.createGuidance(guidance);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGuidance(String id) async {
    try {
      await _guidanceRemoteDataSource.deleteGuidance(id);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GuidanceEntity>>> getAllGuidances() async {
    try {
      final guidances = await _guidanceRemoteDataSource.getAllGuidances();
      return Right(guidances);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GuidanceEntity?>> getGuidanceById(String id) async {
    try {
      final guidance = await _guidanceRemoteDataSource.getGuidanceById(id);
      return Right(guidance);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateGuidance(
      String id, GuidanceEntity guidance) async {
    try {
      await _guidanceRemoteDataSource.updateGuidance(id, guidance);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
