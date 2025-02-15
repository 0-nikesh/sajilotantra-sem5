import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repository/guidance_repository.dart';

class DeleteGuidanceParams extends Equatable {
  final String id;

  const DeleteGuidanceParams({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteGuidanceUseCase
    implements UsecaseWithParams<void, DeleteGuidanceParams> {
  final IGuidanceRepository guidanceRepository;

  DeleteGuidanceUseCase({required this.guidanceRepository});

  @override
  Future<Either<Failure, void>> call(DeleteGuidanceParams params) async {
    return await guidanceRepository.deleteGuidance(params.id);
  }
}
