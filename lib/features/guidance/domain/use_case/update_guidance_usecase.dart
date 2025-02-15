import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/guidance_entity.dart';
import '../repository/guidance_repository.dart';

class UpdateGuidanceParams extends Equatable {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final String category;
  final List<String>? documentsRequired;
  final String? costRequired;

  const UpdateGuidanceParams({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.category,
    this.documentsRequired,
    this.costRequired,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        thumbnail,
        category,
        documentsRequired,
        costRequired
      ];
}

class UpdateGuidanceUseCase
    implements UsecaseWithParams<void, UpdateGuidanceParams> {
  final IGuidanceRepository guidanceRepository;

  UpdateGuidanceUseCase({required this.guidanceRepository});

  @override
  Future<Either<Failure, void>> call(UpdateGuidanceParams params) async {
    final guidance = GuidanceEntity(
      id: params.id,
      title: params.title,
      description: params.description,
      thumbnail: params.thumbnail,
      category: params.category,
      documentsRequired: params.documentsRequired,
      costRequired: params.costRequired,
    );
    return await guidanceRepository.updateGuidance(params.id, guidance);
  }
}
