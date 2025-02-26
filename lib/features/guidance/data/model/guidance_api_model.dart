import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/guidance_entity.dart';

part 'guidance_api_model.g.dart';

@JsonSerializable()
class GuidanceApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String title;
  final String description;
  final String thumbnail;
  final String category;
  final List<String>? documentsRequired;
  final String? costRequired;
  final String? governmentProfileId;
  final String? userId;
  final DateTime? createdAt;

  const GuidanceApiModel({
    this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.category,
    this.documentsRequired,
    this.costRequired,
    this.governmentProfileId,
    this.userId,
    this.createdAt,
  });

  /// Converts JSON to [GuidanceApiModel]
  factory GuidanceApiModel.fromJson(Map<String, dynamic> json) =>
      _$GuidanceApiModelFromJson(json);

  /// Converts [GuidanceApiModel] to JSON
  Map<String, dynamic> toJson() => _$GuidanceApiModelToJson(this);

  /// Converts [GuidanceApiModel] to [GuidanceEntity]
  GuidanceEntity toEntity() {
    return GuidanceEntity(
      id: id,
      title: title,
      description: description,
      thumbnail: thumbnail,
      category: category,
      documentsRequired: documentsRequired,
      costRequired: costRequired,
      governmentProfileId: governmentProfileId,
      userId: userId,
      createdAt: createdAt,
    );
  }

  /// Converts [GuidanceEntity] to [GuidanceApiModel]
  factory GuidanceApiModel.fromEntity(GuidanceEntity entity) {
    return GuidanceApiModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      thumbnail: entity.thumbnail,
      category: entity.category,
      documentsRequired: entity.documentsRequired,
      costRequired: entity.costRequired,
      governmentProfileId: entity.governmentProfileId,
      userId: entity.userId,
      createdAt: entity.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        thumbnail,
        category,
        documentsRequired,
        costRequired,
        governmentProfileId,
        userId,
        createdAt,
      ];
}
