// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guidance_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuidanceApiModel _$GuidanceApiModelFromJson(Map<String, dynamic> json) =>
    GuidanceApiModel(
      id: json['_id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      thumbnail: json['thumbnail'] as String,
      category: json['category'] as String,
      documentsRequired: (json['documentsRequired'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      costRequired: json['costRequired'] as String?,
      governmentProfileId: json['governmentProfileId'] as String?,
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$GuidanceApiModelToJson(GuidanceApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'category': instance.category,
      'documentsRequired': instance.documentsRequired,
      'costRequired': instance.costRequired,
      'governmentProfileId': instance.governmentProfileId,
      'userId': instance.userId,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
