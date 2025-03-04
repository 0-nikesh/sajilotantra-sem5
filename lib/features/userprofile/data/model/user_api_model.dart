// features/user/data/model/user_api_model.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/user_entity.dart';

part 'user_api_model.g.dart';

@JsonSerializable()
class UserApiModel extends Equatable {
  @JsonKey(name: '_id') // Maps MongoDB `_id` to `id`
  final String? id;

  final String fname;
  final String lname;
  final String email;

  @JsonKey(name: 'image') // Maps API `image` to `image`
  final String? image;

  @JsonKey(name: 'cover') // Maps API `cover` to `cover`
  final String? cover;

  @JsonKey(name: 'bio') // Maps API `bio` to `bio`
  final String? bio;

  final bool isAdmin;
  final bool isVerified;

  const UserApiModel({
    this.id,
    required this.fname,
    required this.lname,
    required this.email,
    this.image,
    this.cover,
    this.bio,
    required this.isAdmin,
    required this.isVerified,
  });

  /// Factory to create an instance from JSON
  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  /// Converts the object to JSON
  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

  /// Converts to Entity
  UserEntity toEntity() {
    return UserEntity(
      id: id ?? '', // Fallback to empty string if null
      fname: fname,
      lname: lname,
      email: email,
      image: image,
      cover: cover,
      bio: bio ?? '', // Fallback to empty string if null
      isAdmin: isAdmin,
      isVerified: isVerified,
    );
  }

  /// Converts from Entity
  factory UserApiModel.fromEntity(UserEntity entity) {
    return UserApiModel(
      id: entity.id,
      fname: entity.fname,
      lname: entity.lname,
      email: entity.email,
      image: entity.image,
      cover: entity.cover,
      bio: entity.bio,
      isAdmin: entity.isAdmin,
      isVerified: entity.isVerified,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fname,
        lname,
        email,
        image,
        cover,
        bio,
        isAdmin,
        isVerified,
      ];
}
