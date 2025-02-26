import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sajilotantra/app/constants/hive_table_constant.dart';
import 'package:sajilotantra/features/guidance/domain/entity/guidance_entity.dart';
import 'package:uuid/uuid.dart';

part 'guidance_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.guidanceTableId)
class GuidanceHiveModel extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String thumbnail;
  @HiveField(4)
  final String category;
  @HiveField(5)
  final List<String>? documentsRequired;
  @HiveField(6)
  final String? costRequired;
  @HiveField(7)
  final String? userId;
  @HiveField(8)
  final DateTime? createdAt;

  GuidanceHiveModel({
    String? id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.category,
    this.documentsRequired,
    this.costRequired,
    // this.governmentProfileName, // Changed to governmentProfileName
    this.userId,
    this.createdAt,
  }) : id = id ?? const Uuid().v4();

  const GuidanceHiveModel.initial()
      : id = '',
        title = '',
        description = '',
        thumbnail = '',
        category = '',
        documentsRequired = const [],
        costRequired = '',
        // governmentProfileName = '', // Changed to governmentProfileName
        userId = '',
        createdAt = null;

  /// Converts [GuidanceHiveModel] to [GuidanceEntity]
  GuidanceEntity toEntity() {
    return GuidanceEntity(
      id: id,
      title: title,
      description: description,
      thumbnail: thumbnail,
      category: category,
      documentsRequired: documentsRequired,
      costRequired: costRequired,
      //  governmentProfileName: governmentProfileName, // Changed to governmentProfileName
      userId: userId,
      createdAt: createdAt,
    );
  }

  /// Converts [GuidanceEntity] to [GuidanceHiveModel]
  factory GuidanceHiveModel.fromEntity(GuidanceEntity entity) {
    return GuidanceHiveModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      thumbnail: entity.thumbnail,
      category: entity.category,
      documentsRequired: entity.documentsRequired,
      costRequired: entity.costRequired,
      // governmentProfileName:
      //     entity.governmentProfileName, // Changed to governmentProfileName
      userId: entity.userId,
      createdAt: entity.createdAt,
    );
  }

  /// Converts [GuidanceHiveModel] from JSON
  factory GuidanceHiveModel.fromJson(Map<String, dynamic> json) {
    return GuidanceHiveModel(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      thumbnail: json['thumbnail'] as String,
      category: json['category'] as String,
      documentsRequired: (json['documentsRequired'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      costRequired: json['costRequired'] as String?,
      //governmentProfileName: json['governmentProfileName']
         // as String?, // Changed to governmentProfileName
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  /// Converts [GuidanceHiveModel] to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
      'category': category,
      'documentsRequired': documentsRequired,
      'costRequired': costRequired,
      // 'governmentProfileName':
      //     governmentProfileName, // Changed to governmentProfileName
      'userId': userId,
      'createdAt': createdAt?.toIso8601String(),
    };
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
        // governmentProfileName, // Changed to governmentProfileName
        userId,
        createdAt,
      ];
}
