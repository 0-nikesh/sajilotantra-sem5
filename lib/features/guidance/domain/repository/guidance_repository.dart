import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/guidance_entity.dart';

abstract interface class IGuidanceRepository {
Future<Either<Failure, List<GuidanceEntity>>> getAllGuidances();
Future<Either<Failure, GuidanceEntity?>> getGuidanceById(String id);
Future<Either<Failure, void>> createGuidance(GuidanceEntity guidance);
Future<Either<Failure, void>> updateGuidance(String id, GuidanceEntity guidance);
Future<Either<Failure, void>> deleteGuidance(String id);

}
