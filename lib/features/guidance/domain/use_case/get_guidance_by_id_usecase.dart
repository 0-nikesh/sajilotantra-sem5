import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/guidance_entity.dart';
import '../repository/guidance_repository.dart';

class GetGuidanceByIdParams extends Equatable {
  final String id;

  const GetGuidanceByIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetGuidanceByIdUseCase
    implements UsecaseWithParams<GuidanceEntity?, GetGuidanceByIdParams> {
  final IGuidanceRepository guidanceRepository;

  GetGuidanceByIdUseCase({required this.guidanceRepository});

  @override
  Future<Either<Failure, GuidanceEntity?>> call(
      GetGuidanceByIdParams params) async {
    return await guidanceRepository.getGuidanceById(params.id);
  }
}
