import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String fname;
  final String lname;
  final String? profileImage;
  final String email;
  final String password;
  // final bool isAdmin;

  const AuthEntity({
    this.id,
    required this.fname,
    required this.lname,
    this.profileImage,
    required this.email,
    required this.password,
    // this.isAdmin = false,
  });

  const AuthEntity.empty()
      : id = '',
        fname = '',
        lname = '',
        profileImage = '',
        email = '',
        password = '';

  @override
  List<Object?> get props => [id, fname, lname, email, profileImage, password];
}
