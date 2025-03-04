// features/user/domain/entity/user_entity.dart
class UserEntity {
  final String? id; // Nullable to match API and model
  final String fname;
  final String lname;
  final String email;
  final String? image; // Profile image URL (nullable)
  final String? cover; // Cover image URL (nullable)
  final String? bio; // Bio (nullable)
  final bool isAdmin;
  final bool isVerified;

  UserEntity({
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
}
