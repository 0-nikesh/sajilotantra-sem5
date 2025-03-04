// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostApiModel _$PostApiModelFromJson(Map<String, dynamic> json) => PostApiModel(
      id: json['_id'] as String? ?? '',
      caption: json['caption'] as String? ?? 'No caption available',
      category: json['category'] as String? ?? 'Uncategorized',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => CommentApiModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      userId: UserApiModel.fromJson(json['user_id'] as Map<String, dynamic>),
      createdAt: PostApiModel._parseDateTime(json['created_at']),
    );

Map<String, dynamic> _$PostApiModelToJson(PostApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'caption': instance.caption,
      'category': instance.category,
      'images': instance.images,
      'like_count': instance.likeCount,
      'comments': instance.comments,
      'user_id': instance.userId,
      'created_at': instance.createdAt.toIso8601String(),
    };

UserApiModel _$UserApiModelFromJson(Map<String, dynamic> json) => UserApiModel(
      id: json['_id'] as String? ?? 'Unknown',
      fname: json['fname'] as String? ?? 'Unknown',
      lname: json['lname'] as String? ?? 'User',
      image: json['image'] as String? ?? '',
    );

Map<String, dynamic> _$UserApiModelToJson(UserApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fname': instance.fname,
      'lname': instance.lname,
      'image': instance.image,
    };

CommentApiModel _$CommentApiModelFromJson(Map<String, dynamic> json) =>
    CommentApiModel(
      user: json['user'] as String? ?? 'Anonymous',
      text: json['text'] as String? ?? 'No comment',
      createdAt: PostApiModel._parseDateTime(json['createdAt']),
    );

Map<String, dynamic> _$CommentApiModelToJson(CommentApiModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'text': instance.text,
      'createdAt': instance.createdAt.toIso8601String(),
    };
