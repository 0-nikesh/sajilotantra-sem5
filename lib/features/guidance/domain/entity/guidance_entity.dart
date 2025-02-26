import 'package:equatable/equatable.dart';

class GuidanceEntity extends Equatable {
  final String? id;
  final String title;
  final String description;
  final String thumbnail;
  final String category;
  final List<String>? documentsRequired;
  final String? costRequired;
  // final String?
  //     governmentProfileName; // Changed from governmentProfileId to governmentProfileName
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
    //this.governmentProfileName, // Changed
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
        //governmentProfileName = '', // Changed
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
       // governmentProfileName, // Changed
        userId,
        createdAt,
      ];
}
