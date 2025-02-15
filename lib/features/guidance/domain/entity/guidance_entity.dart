import 'package:equatable/equatable.dart';

class GuidanceEntity extends Equatable {
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

  const GuidanceEntity({
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

  const GuidanceEntity.empty()
      : id = '',
        title = '',
        description = '',
        thumbnail = '',
        category = '',
        documentsRequired = const [],
        costRequired = '',
        governmentProfileId = '',
        userId = '',
        createdAt = null;

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
