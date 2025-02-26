import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id') // Maps MongoDB `_id` to `id`
  final String? id;

  final String fname;
  final String lname;
  final String email;

  @JsonKey(name: 'image') // Ensures `image` from API maps to `profileImage`
  final String? profileImage;

  final String? password;

  const AuthApiModel({
    this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.profileImage,
    required this.password,
  });

  /// Factory to create an instance from JSON
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  /// Converts the object to JSON
  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  /// Converts to Entity
  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      fname: fname,
      lname: lname,
      email: email,
      profileImage: profileImage,
      password: password ?? '',
    );
  }

  /// Converts from Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      id: entity.id,
      fname: entity.fname,
      lname: entity.lname,
      email: entity.email,
      profileImage: entity.profileImage,
      password: entity.password,
    );
  }

  @override
  List<Object?> get props => [id, fname, lname, email, profileImage, password];
}
