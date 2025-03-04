// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiModel _$UserApiModelFromJson(Map<String, dynamic> json) => UserApiModel(
      id: json['_id'] as String?,
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      email: json['email'] as String,
      image: json['image'] as String?,
      cover: json['cover'] as String?,
      bio: json['bio'] as String?,
      isAdmin: json['isAdmin'] as bool,
      isVerified: json['isVerified'] as bool,
    );

Map<String, dynamic> _$UserApiModelToJson(UserApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fname': instance.fname,
      'lname': instance.lname,
      'email': instance.email,
      'image': instance.image,
      'cover': instance.cover,
      'bio': instance.bio,
      'isAdmin': instance.isAdmin,
      'isVerified': instance.isVerified,
    };
