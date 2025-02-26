import 'package:dartz/dartz.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/guidance_entity.dart';
import '../repository/guidance_repository.dart';

class GetAllGuidancesUseCase
    implements UsecaseWithoutParams<List<GuidanceEntity>> {
  final IGuidanceRepository guidanceRepository;

  GetAllGuidancesUseCase({required this.guidanceRepository});

  @override
  Future<Either<Failure, List<GuidanceEntity>>> call() async {
    return await guidanceRepository.getAllGuidances();
  }
}
