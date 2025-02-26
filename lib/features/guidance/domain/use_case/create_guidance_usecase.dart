import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sajilotantra/core/error/failure.dart';
import 'package:sajilotantra/features/guidance/domain/entity/guidance_entity.dart';
import 'package:sajilotantra/features/guidance/domain/repository/guidance_repository.dart';

import '../../../../app/usecase/usecase.dart';

class CreateGuidanceParams extends Equatable {
  final String title;
  final String description;
  final String thumbnail;
  final String category;
  final List<String>? documentsRequired;
  final String? costRequired;

  const CreateGuidanceParams({
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.category,
    this.documentsRequired,
    this.costRequired,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        thumbnail,
        category,
        documentsRequired,
        costRequired
      ];
}

class CreateGuidanceUseCase
    implements UsecaseWithParams<void, CreateGuidanceParams> {
  final IGuidanceRepository guidanceRepository;

  CreateGuidanceUseCase({required this.guidanceRepository});

  @override
  Future<Either<Failure, void>> call(CreateGuidanceParams params) async {
    final guidance = GuidanceEntity(
      title: params.title,
      description: params.description,
      thumbnail: params.thumbnail,
      category: params.category,
      documentsRequired: params.documentsRequired,
      costRequired: params.costRequired,
    );
    return await guidanceRepository.createGuidance(guidance);
  }
}
