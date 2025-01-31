import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String fname;
  final String lname;
  final String email;
  final String? password;
  final String? profileImage;

  const AuthApiModel({
    this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.profileImage,
    required this.password,
  });
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

//   To Entity
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

  // From ENtity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
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
